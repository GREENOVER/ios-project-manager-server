# iOS Project Manager Application Project

### 업무를 관리해주는 트렐로 기능을 구현한 프로젝트 매니저 앱 프로젝트 (서버 파트)
[API Document](https://github.com/GREENOVER/ios-project-manager-server/wiki/API-Document)
***
#### What I learned✍️
- API Document
- Homebrew
- Vapor
- Mock Data
- Fluent
- Model & Migration
- API Test
- Heroku
- PostgreSQL
- HTTP

#### What have I done🧑🏻‍💻
- 클라이언트 파트와 회의를 하며 API Document를 설계하였다.
  - 생성되는 Thing들에 대한 id 값은 서버 측에서 UUID 타입으로 생성하여 클라이언트에게 응답해줘 클라이언트측에서  해당 id 값을 다루고 이 id값으로 CRUD의 기능을 구현한다.
  - API Document는 Swift 개발자뿐만이 아닌 다양한 파트의 구성원이 보는 문서임으로 Swift에서 사용되는 옵셔널 등의 키워드를 붙여서 문서화하기에는 부적합하다. 이에 Request/Response값에 Required라는 열을 만들어 Required와 Optional로 문서를 구분지어 해당 값이 필수적인지 선택적인지 알 수 있도록 설계하였다.
  - 클라이언트 파트에서 업무의 만료일은 due_date로 네이밍을 지었고 추가로 updated_at이라는 값은 서버에서 생성하게되는데 이 값의 역할은 해당 업무가 만들어지거나 다시 업데이트되거나하는 시점의 시스템 시간을 담는다. 이 값으로 클라이언트 측에서는 서버와의 마지막 통신 시간을 체크하여 활용할 수 있도록 설계하였다.
  - Post / Patch / Delete에 대해서도 클라이언트에게 Response를 주어 해당 Request에 대해 잘 응답하였는지 알려줄 수 있게 설계하였다.
  - 통신에 대한 에러 코드는 기본적으로 400번과 404번 에러로 나누어 설계하였으나 추후 클라이언트에서 프로젝트를 진행하며 추가적인 에러에 대해서는 보강할 계획으로 설계하였다.
- API Document 설계를 토대로 응답에 대한 Mock 데이터를 생성하여 클라이언트 파트에서 테스트 할 수 있도록 제공하였다. 
- Homebrew를 설치하고 이용하여 Vapor Toolbox를 설치 및 사용하여 프로젝트를 진행하였다.
  - 홈브루는 오픈소스 소프트웨어 패키지 관리 시스템의 일종으로 macOS의 SW 설치를 지원해준다.
  - brew ~ 라는 커맨드 라인 프로그램의 명령어를 입력하여 실행할 명령어를 입력한다.
  - Vapor Toolbox는 Swift 언어 기반의 웹 프레임워크로 Vapor 앱 개발 시 사용되는 CLI 도구이다.
- Vapor에서 Fluent 프레임워크를 사용하여 PostgreSQL DB의 모델/마이그레이션을 정의하고 구축하였다.
  - Fluent 프레임워크는 Vapor에서 사용되는 Swift 기반의 ORM 프레임워크로 Vapor로 DB를 다루는 프레임워크이다.
  - PostgreSQL DB는 객체-관계형 데이터베이스 관리 시스템 (ORDBMS) 종류중 하나이다.
  - 모델은 DB에 정보를 저장하기 위해 사용되는 자료구조로 타이틀, 설명, 날짜, 상태 등의 프로퍼티를 만들어 저장하게도록 정의하였다.
  - 마이그레이션은 모델을 저장할 DB를 준비하는것으로 모델과 DB를 매핑해주도록 정의하였다.
- 클라우드 서비스형 플랫폼에 앱을 배포하기 위해 Heroku에 앱을 등록하고 배포하였다.
  - Heroku는 여러 프로그래밍 언어를 지원하는 클라우드 PaaS이다.
  - Heroku에 계정을 생성하고 대시보드에서 Create New App을 통해 앱을 생성한 뒤 PostgreSQL을 추가하여 Heroku 앱을 구성하였다.
  - Heroku CLI을 설치하고 이용하여 로컬 터미널에서 빌드팩 및 DB 등의 설정을 한 뒤 프로젝트 브랜치를 배포하였다. 이후 변경사항이 있을때마다 해당 Heroku로 푸시하여 배포하였다.
- GET / POST / PATCH / DELETE API를 구현하고 호출 테스트를 하였다.
  - 클라이언트 Request의 데이터에 대해 유효성을 검증하였다. 1,000자 이상 넘어가지 않는지 체크하는 메서드를 구현하였다.
  - Response를 위해 해당 구현된 Thing 정보를 반환하여 클라이언트에서 요청에 대한 응답을 볼 수 있도록 구현하였다.
  - Postman을 통해 API 호출에 대한 테스트를 진행하였다.

#### Trouble Shooting👨‍🔧
- 문제점: 로컬에서 해당 서버를 테스트해보기 위해 앱을 빌드해보는 과정에서 아래와 같은 런타임 에러가 나타나게 되었다. http://localhost:8080 에서 Get을 찍어보니 이상은 없는데 왜 이런 오류가 나타나게 되는것인지 문제였다.
<img src = "https://github.com/GREENOVER/SwiftUI/blob/main/InXcode.png" width="50%" height="50%">

- 원인: 해당 오류 메시지를 가지고 수소문하며 찾았는데 이유는 이전 해당 앱을 빌드하여 이미 로컬인 8080 서버가 실행이 되고 있어 중복으로 바인딩을 하려니 문제가 나타나는것이였다. 즉 이미 해당 로컬호스트 8080 서버를 사용하고 있는데 거기서 똑같은 로컬호스트를 서버로 동일하게 사용하려하니 이미 사용되고 있다고 에러가 나타나게 된것이다.

- 해결방법: 중복으로 사용되고 있는 서버를 죽여주기 위해 아래와 같이 Activity Monitor (활성상태보기)에서 Run으로 검색하여 지금 해당 로컬호스트 서버를 물고 있는 2개의 run을 발견하였다. 이 run이 해당 로컬호스트를 점유하고 있는 메모리로 둘중 이전것이든 지금것이든 아니면 둘다 죽이고 다시 빌드를 하던하게되면 정상적으로 에러 메시지 없이 실행되었다.
<img src = "https://github.com/GREENOVER/SwiftUI/blob/main/InSimulator.png" width="50%" height="50%">

- 만약 Run이라는 프로세스 이름을 모르고 있을때는 프로세스 ID 즉 PID를 알면되는데 이 PID를 찾기 위해서는 터미널에서 ``` $ sudo lsof -i :8080 ``` 명령어를 통해 해당 프로세스가 실행되는 PID 번호를 찾아낼 수 있다. 그러면 위와 같이 활성상태보기 창에서 해당 PID를 찾아 종료해주면된다.
