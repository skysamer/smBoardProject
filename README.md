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
<img width="769" src="https://user-images.githubusercontent.com/73572543/143258430-08d7d0c0-570e-4abc-b432-910fb017b65a.png">

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

- **글 등록** 
  - seq_board.nextval 시퀀스를 이용하여 시퀀스의 다음 값을 구해서 insert
  - 혹은 selectKey구문을 이용하여 시퀀스의 값을 bno에 저장한 후 이 값을 이용하여 insert

- **상세 글 조회 및 삭제**
  - bno(글번호)값을 파라미터로 지정하여 특정 번호의 글 조회 혹은 삭제

</div>
</details>

</br>

## 6. 페이징 처리
- 무한 스크롤 방식이 아닌 페이지 별로 번호를 지정하여 관리
- 가장 최신글부터 볼 수 있도록 역순(descending)으로 정렬


### 6.1. Mapper :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/resources/com/sm/mapper/BoardMapper.xml)
- order by 대신에 index_desc 힌트를 활용하여 별도의 정렬과정 생략
- rownum 컬럼을 활용하여 각 페이지당 할당할 글 개수를 지정함
- 인라인뷰를 활용하여 반드시 1을 포함해야하는 rownum의 범위를 임의로 지정하여 특정 페이지에 포함되는 글 번호와 개수를 출력하도록 함(rownum을 하나의 컬럼으로 활용하기 위함)
- 파라미터값을 지정하여 페이지 번호, 페이지 당 데이터 개수 값을 받음
- 메서드에서 Criteria객체를 파라미터로 받도록 지정
- 인덱스를 생성하고 rownum컬럼을 불러와서 오름차순으로 정렬 후, Criteria 객체의 pageNum, amount데이터를 이용하여 웹 게시물과 같이 페이징 처리
- 댓글의 숫자를 파악할 수 있는 getCountByBno()메서드 작성

### 6.2. Criteria :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/domain/Criteria.java)
- 페이지 번호와 페이지 당 데이터 개수값을 하나의 객체로 관리하기 위해 생성한 클래스
- 생성자를 통해서 기본값을 1페이지, 20개로 지정하여 처리

### 6.3. Service :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/service/BoardServiceImpl.java)
- 글 목록을 출력하는 메서드의 파라미터 값으로 Criteria 객체를 지정

### 6.4. Controller :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/controller/BoardController.java)
- 글 목록을 출력하는 메서드의 파라미터 값으로 Criteria 객체를 지정
- PageDTO 객체에 Criteria, 전체 데이터 수 파라미터값을 지정하여 Model객체로 감싸서 화면단에 전송
- 전체 데이터 수의 경우, 
- 상세 글 목록 조회 메서드에서 Criteria 파라미터를 추가
- 글 수정 및 삭제 메서드에 Criteria 파라미터 값을 추가하고, 페이지 번호값과 페이지 당 데이터 개수값을 RedirectAttribute 객체로 감싸서 전달

### 6.5. PageDTO :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/domain/PageDTO.java)
- 현재 페이지 번호, 끝 페이지와 시작 페이지 번호(10개 페이지씩 관리), 다음 페이지와 이전 페이지 번호 정보를 관리하기 위한 객체
- 생성자를 정의하여 Criteria와 전체 데이터 개수를 파라미터로 지정
- 페이지 끝번호는 현재 페이지 번호를 소수점 처리 후, 올림하고 10을 곱하여 지정
- 페이지 첫번호는 페이지 끝번호에서 9를 뺀 값을 지정
- 이전 페이지는 페이지 첫번호가 1보다 큰 경우, 즉 현재 페이지 번호가 10이상인 경우만 생성되도록 지정
- 다음 페이지는 페이지 끝번호가 최종 페이지 끝번호보다 작을 경우만 생성되도록 지정


<details>
<summary><b>기존 코드</b></summary>
<div markdown="1">

~~~java

public Page<PostResponseDto> listTopTen() {

    PageRequest pageRequest = PageRequest.of(0, 10, Sort.Direction.DESC, "rankPoint", "likeCnt");
    return postRepository.findAll(pageRequest).map(PostResponseDto::new);
}

~~~

</div>
</details>

</div>
</details>

</br>

## 7. 검색 기능
- 제목 / 내용 / 작성자 단일 검색 기능
- 제목 or 내용과 같은 다중 항목 검색 기능
- 검색조건에 대한 처리는 SQL 인라인뷰 안에서 해결
- LIKE 처리를 통해서 키워드를 사용

### 7.1. Mapper :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/resources/com/sm/mapper/BoardMapper.xml)
- 동적 SQL기능을 사용하여 경우에 따라 다른 SQL을 만들어 실행
- or연산자를 우선으로 하기 위하여 trim prefix와 suffix 태그를 활용하여 앞뒤로 '('와 ') and'를 추가
- typeArr을 객체로 하는 foreach반복 태그를 생성하여 'or title... or content...'와 같은 구문을 생성
- prefixOverrides 태그를 활용하여 맨 앞의 or을 지움
- sql태그를 이용하여 검색조건 부분을 따로 저장하고, getListWithPaging태그 부분에 include refid 태그를 이용하여 추가

### 7.2. Criteria :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/domain/Criteria.java)
- 검색 조건과 검색 키워드 처리를 위한 변수인 keyword와 type변수 추가
- getTypeArr()메서드를 생성하여 제목 / 내용 / 작성자 각 타입의 값을 갖는 배열 생성
- UriComponentBuilder 클래스를 이용하여 페이지 번호 / 페이지 당 데이터 수 / 검색조건 / 키워드 파라미터를 연결하여 URL형태로 생성

### 7.3. Controller :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/controller/BoardController.java)
- 글 수정 및 삭제 메서드에 검색조건과 키워드 데이터인 type과 keyword값을 RedirectAttribute객체로 감싸서 화면단에 전달
- Criteria 객체의 getListLink()메서드를 이용하여 글 삭제 및 수정 메서드의 반환값에 cri.getListLink() 병합


</div>
</details>

</br>

## 8. 댓글 처리
- 순수한 데이터만을 처리하는 REST방식으로 전환
- 화면단에서 JSON 데이터를 Ajax로 
- 데이터를 JSON 방식으로 주고 받음
- JSON 데이터로 변환하기 위한 jackson-databind 라이브러리를 pom.xml에 추가
- 자바 인스턴스를 JSON 타입의 문자열로 변환하기 위한 gson 라이브러리 추가


### 8.1. Mapper :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/resources/com/sm/mapper/ReplyMapper.xml)
- tbl_board 테이블의 bno컬럼을 fk값으로 활용하여 특정글에 대한 댓글을 구분할 수 있도록 매핑
- seq_reply를 시퀀스로 지정하여 seq_reply.nextval을 활용하여 댓글 번호 자동 증가 처리
- 댓글 삭제, 수정, 등록 interface 메서드의 경우 int형을 반환값으로 설정
- 댓글의 페이징 처리를 위하여 댓글 목록 interface메서드의 파라미터 값으로 Criteria객체와 bno값을 지정(@Param을 활용하여 2개의 파라미터 지정)
- BoardMapper에 댓글 수를 업데이트하는 updateReplyCnt() 메서드를 추가
- BoardMappe의 updateReplyCnt()메서드 파라미터 값으로 게시물 번호와 증감값을 받을 수 있는 파라미터를 지정


### 8.2. Controller :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/controller/ReplyController.java)
- @RestController 어노테이션을 이용하여 REST방식으로 설계
- PK(rno)를 기준으로 URL을 설계(PK만으로 조회, 수정, 삭제가 가능하도록 설계)
- 댓글 조회, 수정, 삭제 메서드의 경우 rno 파라미터 값을 @PathVariable 어노테이션으로 지정하여 URL에 파라미터 전달
- 데이터 조회 메서드의 경우 @GetMapping 어노테이션을 지정

- **특정 게시글 댓글 목록** 
  - produces를 이용하여 JSON 데이터를 반환하도록 지정
  - 페이지 번호 데이터(page)와 글 번호 데이터(bno)를 @PathVariable 어노테이션을 이용하여 파라미터로 지정
  - 파라미터에 @PathVariable 어노테이션을 지정하여 url에 파라미터 값을 같이 전달
  - 생성된 page파리미터는 Criteria 인스턴스를 생성하여 처리

- **댓글 등록** 
  - consumes를 이용하여 서버단에서 JSON 타입으로 된 댓글 데이터를 전송받음
  - @PostMapping 어노테이션을 지정하여 POST방식으로 전송하도록 설정
  - 데이터와 함께 HTTP 헤더의 상태 메시지를 같이 전송하기 위해 ResponseEntity 객체를 반환값으로 지정
  - produces를 이용하여 처리 결과가 정상적으로 되었는지 문자열로 결과 반환
  - ReplyVO 객체를 파라미터 값으로 지정하고 @RequestBody 어노테이션을 지정하여 JSON 데이터를 ReplyVO 타입으로 변환

- **댓글 조회** 
  - @RequestParam을 이용하여 게시글 번호값을 명시적으로 처리
  - 게시글 vo객체를 model객체를 활용하여 화면단에 전달
  - produces를 이용하여 JSON 데이터를 반환하도록 지정

- **댓글 수정**
  - produces를 이용하여 처리 결과가 정상적으로 되었는지 문자열로 결과 반환
  - consumes를 이용하여 서버단에서 JSON 타입으로 된 댓글 데이터를 전송받음
  - ReplyVO 객체를 파라미터 값으로 지정하고 @RequestBody 어노테이션을 지정하여 JSON 데이터를 ReplyVO 타입으로 변환
  - method를 이용하여 PUT 혹은 PATCH 방식으로 전송하도록 지정

- **댓글 삭제**
  - produces를 이용하여 처리 결과가 정상적으로 되었는지 문자열로 결과 반환
  - @DeleteMapping 어노테이션을 지정하여 DELETE 방식으로 전송하도록 지정

### 8.3. ReplyPageDTO :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/domain/ReplyPageDTO.java)
- 게시물 당 전체 댓글 수와 댓글목록 리스트 데이터를 받기 위한 객체
- @AllArgsConstructor 어노테이션을 지정하여 replyCnt와 list를 생성자의 파라미터로 처리

### 8.4. Service :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/service/ReplyServiceImpl.java)
- 댓글 목록을 출력하는 getListPage의 반환값으로 댓글목록 데이터와 댓글 수 데이터를 갖고 있는 ReplyPageDTO 객체를 지정
- 반환값을 ReplyPageDTO로 생성하여 파라미터로 댓글 목록과 댓글수를 출력하는 Mapper 메서드인 getCountByBno()와 getListWithPaging()메서드를 지정
- 트랜잭션을 위한 BoardMapper와 ReplyMapper의존성을 추가
- 댓글 등록과 삭제를 담당하는 메서드는 @Transactional 어노테이션 지정
- 댓글 삭제 메서드의 경우 updateReplyCnt()메서드의 amount 파라미터에 -1 지정
- 댓글 등록 메서드의 경우 updateReplyCnt()메서드의 amount 파라미터에 +1 지정

### 8.5. BoardVO :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/domain/BoardVO.java)
- 댓글 수를 의미하는 인스턴스 변수인 replyCnt 변수 추가

</div>
</details>

</br>

## 9. 파일 업로드
- Servlet 3.0이상부터 지원하는 자체적인 파일 업로드 API 활용
- 첨부파일은 실제 서버가 동작하는 머신 내에 있는 폴더에 업로드(임시 업로드 파일을 저장할 폴더 생성)
- web.xml의 servlet태그에 multipart-config 태그 추가(업로드 공간 지정)
- 스프링 업로드 처리를 위해 servlet-context.xml 파일에 MultipartResolver객체의 빈을 등록
- 이미지 파일의 섬네일 생성을 위해 thumbnailator 라이브러리 추가
- 파잏 타입 체크를 위한 tika-parsers 라이브러리 추가

### 9.1. UploadController :pushpin: [코드 확인](https://github.com/skysamer/smBoardProject/blob/main/src/main/java/com/sm/controller/UploadController.java)
- 파일 업로드 처리를 위한 uploadAjaxPost()메서드를 생성
- 업로드 방식은 Ajax 및 POST로 지정하고, 하고, MultipartFile의 배열 객체를 파라미터값으로 지정
- File객체를 생성하여 파일을 저장할 폴더 경로와 파일 이름을 지정하고 transferTo()메서드를 사용하여 지정한 경로에 파일을 저장
- getFolder() 메서드를 private로 생성하여 년/월/일 단위의 오늘 날짜 폴더 경로를 문자열로 생성
- upload 폴더에 생성된 날짜 경로의 존재 여부를 확인하고 없으면 mkdirs() 메서드를 활용하여 오늘 날짜 경로의 폴더 생성 및 생성된 폴더에 파일 저장
- UUID 클래스의 randomUuid() 메서드를 이용하여 중복파일을 구분할 수 있도록 파일이름 앞에 붙임
- 파일 타입 체크를 위한 checkTypeImage() 메서드를 생성
- Tika 클래스의 detect() 메서드를 이용하여 파라미터로 받은 파일의 타입 체크 후, image 타입일 경우 true를 반환하고 아닐 경우 false를 반환
- 파일이 이미지일 경우 Thumbnailator.createThumbnail()를 이용하여 섬네일 이미지 생성 및 FileOutputStream 객체를 이용하여 접두어로 s_를 붙인 섬네일 파일 이름 생성
- uploadAjaxPost() 메서드의 경우 BoardAttachVO의 list를 반환하는 ResponseEntity 객체로 반환값 지정하고 JSON 데이터를 반환하도록 설정
- getFile() 메서드를 생성하고 반환값을 Byte 배열로 지정 및 파라미터 값으로 파일이름을 문자열로 받도록 지정
- probeContentType() 메서드를 이용해서 섬네일 전송 시 적절한 MIME 타입 데이터를 Http의 헤더 메시지에 포함할 수 있도록 처리
- FileCopyUtils.copyToByteArray()를 이용하여 섬네일 이미지를 헤더 메시지와 함께 전송


</div>
</details>

</br>

## 10. 로그인 처리

</div>
</details>

</br>

## 11. 트러블 슈팅
<details>
<summary>npm run dev 실행 오류</summary>
<div markdown="1">

- Webpack-dev-server 버전을 3.0.0으로 다운그레이드로 해결
- `$ npm install —save-dev webpack-dev-server@3.0.0`

</div>
</details>


</br>

## 6. 회고 / 느낀점

