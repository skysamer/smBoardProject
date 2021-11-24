# :pushpin: smBoardProject
>게시판 웹 프로젝트
>

</br>

## 1. 제작 기간 & 참여 인원
- 2021년 9월 1일 ~ 
- 개인 프로젝트

</br>

## 2. 사용 기술
#### `Back-end`
  - Java 8
  - Spring 5
  - Maven
  - MyBatis
  - Oracle 11g
  - Spring Security
#### `Front-end`
  - BootStrap
  - JQuery

</br>

## 3. ERD 설계
![]()

## 4. 전체 흐름
<img width="831" src="https://user-images.githubusercontent.com/73572543/142586025-0e310172-7256-44ee-b79e-a4e1cd43c2e1.png">
</br>

## 5. 웹 게시물 관리

### 5.1. Controller :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/controller/BoardController.java)
- Service 객체에 의존적이므로 @AllArgsConstructor를 이용하여 생성자를 만들고 자동 주입
- Model 객체를 파라미터로 지정

- **게시글 목록** 
  - 글 제목, 글 내용, 작성자 데이터 등이 담긴 vo객체의 리스트 형을 model객체로 화면단에 전달

- **신규 글 등록** 
  - String을 리턴 타입으로 지정하고 등록 작업 후, 목록 화면으로 이동 및 등록 게시물의 번호를 전달하기 위해 RedirectAttribute를 파라미터로 지정
  - 게시글 vo객체를 파라미터로 지정하여 화면단에서 전송하는 글 등록 데이터 수집
  - 리턴 타입에 'redirect:' 접두어를 지정하여 스프링이 내부적으로 response.sendRedirect()를 처리하도록 지정
  - addFlashAttribute()를 활용하여 등록된 글 번호를 전달하여 등록 완료 메시지 처리
  - getMapping메서드와 postMapping메서드를 각각 지정하여 하나는 화면단, 하나는 데이터 처리를 지정

- **상세 글 조회** 
  - @RequestParam을 이용하여 게시글 번호값을 명시적으로 처리
  - 게시글 vo객체를 model객체를 활용하여 화면단에 전달

- **글 수정**
  - 변경된 내용을 수집하여 게시글 vo객체 파라미터로 처리
  - 리턴 타입에 'redirect:' 접두어를 지정하여 수정 후 목록 화면으로 이동하도록 지정
  - RedirectAttributes 객체를 파라미터로 지정하여 수정이 정상적으로 동작한 경우 성공 메시지를 화면단에 일회성 데이터로 전달

- **글 삭제**
  - post 방식으로 지정
  - 리턴 타입에 'redirect:' 접두어를 지정하여 삭제 후 목록 화면으로 이동하도록 지정
  - RedirectAttributes 객체를 파라미터로 지정하여 삭제가 정상적으로 동작한 경우 성공 메시지를 화면단에 일회성 데이터로 전달
  - @RequestParam을 이용하여 게시글 번호값을 명시적으로 처리

### 5.2. Service :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/service/BoardServiceImpl.java)
- 인터페이스(interface)를 생성하고 이를 상속하는 형태로 구현
- @Service 어노테이션을 선언하여 비즈니스 영역을 담당하는 객체임을 표시
- Mapper 클래스 의존성 주입

- **글 등록** 
  - mapper.insertSelectKey()의 반환값인 int가 아닌 void를 반환값으로 설정

- **글 목록** 
  - vo객체의 list값을 반환값으로 설정

- **글 상세 보기** 
  - vo객체값을 반환값으로 설정

- **글 삭제 및 수정** 
  - Boolean 타입으로 반환값을 설정


### 5.3. Mapper :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/resources/com/sm/mapper/BoardMapper.xml)
- 테이블 설계를 기준으로 vo클래스를 생성
- DAO 클래스 대신 Mapper 인터페이스를 작성

- **글 목록 ** 
  - URL 유효성 체크와 이미지, 제목 파싱이 끝난 컨텐츠는 DB에 저장합니다.
  - 저장된 컨텐츠는 다시 Repository - Service - Controller를 거쳐 화면단에 송출됩니다.

</div>
</details>

</br>

## 6. 페이징 처리
### 6.1. 컨텐츠 필터와 페이징 처리 문제
- 저는 이 서비스가 페이스북이나 인스타그램 처럼 가볍게, 자주 사용되길 바라는 마음으로 개발했습니다.  
때문에 페이징 처리도 무한 스크롤을 적용했습니다.



<details>
<summary><b>기존 코드</b></summary>
<div markdown="1">

~~~java

public Page<PostResponseDto> listTopTen() {

    PageRequest pageRequest = PageRequest.of(0, 10, Sort.Direction.DESC, "rankPoint", "likeCnt");
    return postRepository.findAll(pageRequest).map(PostResponseDto::new);
}


public Page<PostResponseDto> listFilteredByTagName(String tagName, Pageable pageable) {

    return postRepository.findAllByTagName(tagName, pageable).map(PostResponseDto::new);
}

// ... 게시물 필터 (Member) 생략 


public List<PostResponseDto> listFilteredByDate(String createdDate) {

    // 등록일 00시부터 24시까지
    LocalDateTime start = LocalDateTime.of(LocalDate.parse(createdDate), LocalTime.MIN);
    LocalDateTime end = LocalDateTime.of(LocalDate.parse(createdDate), LocalTime.MAX);

    return postRepository
                    .findAllByCreatedAtBetween(start, end)
                    .stream()
                    .map(PostResponseDto::new)
                    .collect(Collectors.toList());
    }
~~~

</div>
</details>



ㅇㅈㅇㅈㅂㅇㅈㅂㅇㅈㅂㅇㅈㅂ
</div>
</details>

</br>

## 7. 페이징 처리

</div>
</details>

</br>

## 8. 검색 기능

</div>
</details>

</br>

## 9. REST와 Ajax를 활용한 댓글 처리

</div>
</details>

</br>

## 10. 파일 업로드

</div>
</details>

</br>

## 11. 스프링 시큐리티를 활용한 로그인 처리

</div>
</details>

</br>

## 12. 그 외 트러블 슈팅
<details>
<summary>npm run dev 실행 오류</summary>
<div markdown="1">

- Webpack-dev-server 버전을 3.0.0으로 다운그레이드로 해결
- `$ npm install —save-dev webpack-dev-server@3.0.0`

</div>
</details>


</br>

## 6. 회고 / 느낀점

