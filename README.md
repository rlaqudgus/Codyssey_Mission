# 코디세이 1차 미션 - 개발 워크스테이션 구축

## 1) 실행 환경

- **OS**: macOS 15.7.4
- **아키텍처**: x86_64
- **셸**: /bin/zsh
- **Git 버전**: git version 2.53.0
- **Docker 버전**: 28.5.2

## 2) 터미널 기본 조작

### 위치 확인 / 목록 / 이동
```bash
$ pwd
/Users/kbh39723978/desktop/codyssey_mission

$ ls
check-env.sh	README.md

$ ls -a
.		..		.git		check-env.sh	README.md
```
- `pwd`: 현재 위치(절대경로) 확인
- `ls`: 파일/폴더 목록
- `ls -a`: 숨김파일(`.git` 등) 포함 전체 목록

### 디렉토리 생성 / 삭제
```bash
$ mkdir test          # 디렉토리 생성
$ rm test
rm: test: is a directory   # 디렉토리는 rm만으로 삭제 불가
$ rm -r test          # 디렉토리는 -r 옵션 필요
```

### 파일 생성 / 내용 작성 / 확인
```bash
$ touch test.txt              # 빈 파일 생성
$ echo "hello world" > test.txt   # 내용 작성
$ cat test.txt
hello world
```

### 복사 / 이름변경 / 삭제
```bash
$ cp test.txt copy.txt        # 복사
$ mv copy.txt newcopy.txt     # 이름 변경(이동)
$ rm newcopy.txt              # 파일 삭제
```

### 학습 포인트
- **디렉토리 삭제는 `rm -r`** 이 필요하다 (파일은 `rm`만으로 가능).
- 경로/명령어는 **대소문자를 구분**한다 (`Desktop` vs `desktop`).
- `mv`는 "이동"과 "이름변경"을 동시에 담당하는 명령어다.

## 3) 파일 권한 실습

### 권한 표기 읽는 법
```
- rwx rwx rwx
│  │   │   └ 기타(others)
│  │   └ 그룹(group)
│  └ 소유자(user)
└ 종류 (-=파일, d=디렉토리)
```
| 숫자 | 의미 | 권한 |
|------|------|------|
| 4 | r (읽기) | read |
| 2 | w (쓰기) | write |
| 1 | x (실행/디렉토리 진입) | execute |

예) `7 = 4+2+1 = rwx`, `6 = 4+2 = rw-`, `5 = 4+1 = r-x`

### 기본 권한 확인
```bash
$ ls -l permtest.txt
-rw-r--r--  ... permtest.txt      # 파일 기본값 644

$ ls -ld permdir
drwxr-xr-x  ... permdir           # 디렉토리 기본값 755
```

### 파일 권한 변경 (644 → 777 → 644)
```bash
$ chmod 777 permtest.txt
$ ls -l permtest.txt
-rwxrwxrwx  ... permtest.txt      # 모두에게 rwx 부여

$ chmod 644 permtest.txt          # 안전하게 복구
$ ls -l permtest.txt
-rw-r--r--  ... permtest.txt
```

### 디렉토리 권한 변경 (755 → 700 → 755)
```bash
$ chmod 700 permdir
$ ls -ld permdir
drwx------  ... permdir           # 소유자만 접근 가능

$ chmod 755 permdir               # 다시 복구
$ ls -ld permdir
drwxr-xr-x  ... permdir
```

### 학습 포인트
- macOS 기본 권한은 **파일 644 / 디렉토리 755** 이다.
- `chmod`는 숫자(8진법)로 소유자·그룹·기타 권한을 한 번에 지정한다.
- 디렉토리의 `x`는 **"진입(cd) 권한"** 을 의미한다.
- `777`은 모두에게 모든 권한을 주므로 **보안상 위험** → 실습 후 복구.
- `ls -l`(파일) / `ls -ld`(디렉토리 자체) 로 권한을 확인한다.

## 4) Docker 설치 확인 및 기본 명령

### 4.1 Docker 설치 확인
Docker가 정상 설치되었는지 버전을 확인한다.

```bash
docker --version
```

**결과**
```
Docker version 28.5.2
```
> OrbStack 엔진 기반으로 정상 작동 확인.

---

### 4.2 hello-world 컨테이너 실행
Docker가 정상 동작하는지 테스트용 컨테이너를 실행한다.

```bash
docker run hello-world
```

- 로컬에 이미지가 없어 자동으로 다운로드(pull) 후 실행됨
- "Hello from Docker!" 메시지 출력 → 정상 동작 확인

---

### 4.3 기본 명령 실습

#### (1) 이미지 목록 확인
```bash
docker images
```
```
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
hello-world   latest    e2ac70e7319a   4 months ago   10.1kB
```
> 다운로드된 이미지 목록을 보여준다.

#### (2) 실행 중인 컨테이너 확인
```bash
docker ps
```
```
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
```
> 현재 실행 중인 컨테이너가 없어 비어 있음.

#### (3) 전체 컨테이너 확인 (종료 포함)
```bash
docker ps -a
```
```
CONTAINER ID   IMAGE         COMMAND    STATUS                    NAMES
38eed4778216   hello-world   "/hello"   Exited (0) ...            elastic_benz
```
> `Exited (0)` = 에러 없이 정상 종료됨을 의미.
> 컨테이너는 실행 후 종료되어도 기록으로 남는다.

---

### 4.4 핵심 정리
| 명령어 | 역할 |
|--------|------|
| `docker images` | 이미지 목록 확인 |
| `docker ps` | 실행 중인 컨테이너 확인 |
| `docker ps -a` | 종료된 컨테이너까지 전체 확인 |
| `docker run` | 컨테이너 실행 |

- **이미지**: 실행 준비된 템플릿 (도시락)
- **컨테이너**: 이미지를 실행한 상태 (데운 도시락)
- 컨테이너는 종료되어도 `docker ps -a`에 기록으로 남는다.

## 5) 컨테이너 실행 실습

### 5.1 ubuntu 이미지 pull

```bash
docker pull ubuntu
```

```
Using default tag: latest
latest: Pulling from library/ubuntu
Digest: sha256:...
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

### 5.2 이미지 확인

```bash
docker images
```

```
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
ubuntu        latest    a04dc4851cbc   2 weeks ago   78.1MB
hello-world   latest    ...            ...           ...
```

### 5.3 대화형 컨테이너 실행 (-it)

```bash
docker run -it ubuntu /bin/bash
```

- `-i` : 표준 입력 유지 (interactive)
- `-t` : 터미널 할당 (tty)
- 컨테이너 내부 진입 후 아래 명령 실행

#### 컨테이너 내부 실습

```bash
cat /etc/os-release
```

```
PRETTY_NAME="Ubuntu 24.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.2 LTS (Noble Numbat)"
```

```bash
whoami
```

```
root
```

```bash
ps aux
```

```
USER   PID %CPU %MEM  COMMAND
root     1  0.0  0.0  /bin/bash
root    10  0.0  0.0  ps aux
```

```bash
exit
```

#### ⚠️ 문제 발생

```bash
docker ps
```

```
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS    PORTS   NAMES
```

> `exit` 시 bash(PID 1)가 종료되면서 컨테이너 자체가 종료됨

### 5.4 백그라운드 컨테이너 실행 (-d)

```bash
docker run -d --name myubuntu ubuntu sleep infinity
```

- `-d` : 백그라운드(detached) 실행
- `--name myubuntu` : 컨테이너 이름 지정
- `sleep infinity` : 컨테이너가 종료되지 않도록 유지

```bash
docker ps
```

```
CONTAINER ID   IMAGE    COMMAND            STATUS          NAMES
fcaafb233892   ubuntu   "sleep infinity"   Up 1 minute     myubuntu
```

> 컨테이너가 백그라운드에서 계속 실행 중!

### 5.5 attach vs exec 비교

#### attach 방식

```bash
docker attach myubuntu
ps aux
```

```
USER   PID %CPU %MEM  COMMAND
root     1  0.0  0.0  /bin/bash
root     7  0.0  0.0  ps aux
```

```bash
exit
```

```bash
docker ps
```

```
CONTAINER ID   IMAGE   COMMAND   STATUS   NAMES
```

> bash가 PID 1이었기 때문에 exit 시 컨테이너 종료됨

#### exec 방식

```bash
docker run -d --name myubuntu ubuntu sleep infinity
docker exec -it myubuntu /bin/bash
ps aux
```

```
USER   PID %CPU %MEM  COMMAND
root     1  0.0  0.0  sleep infinity
root     7  0.8  0.0  /bin/bash
root    14  0.0  0.0  ps aux
```

```bash
exit
```

```bash
docker ps
```

```
CONTAINER ID   IMAGE    COMMAND            STATUS          NAMES
fcaafb233892   ubuntu   "sleep infinity"   Up 1 minute     myubuntu
```

> bash를 종료해도 PID 1(sleep infinity)이 살아있어 컨테이너 유지됨!

#### 📊 attach vs exec 최종 비교

| 항목 | attach | exec |
|------|--------|------|
| 접속 방식 | 기존 PID 1 프로세스에 연결 | 새 프로세스 추가 실행 |
| bash의 PID | 1 | 7 (새 프로세스) |
| exit 후 컨테이너 | ❌ 종료됨 | ✅ 유지됨 |
| 실무 사용 | ❌ 비권장 | ✅ 권장 |

> 💡 **실무 팁:** 운영 중인 컨테이너 접속 시 항상 `docker exec -it` 사용!

### 5.6 컨테이너 정리

```bash
docker stop myubuntu
docker rm myubuntu
docker rm aed34b3f1b18 b61811c76211
docker ps -a
```

```
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
```

> 모든 컨테이너 정리 완료!

#### 컨테이너 관리 명령어 정리

| 명령어 | 설명 |
|--------|------|
| `docker ps` | 실행 중인 컨테이너 확인 |
| `docker ps -a` | 전체 컨테이너 확인 (종료 포함) |
| `docker stop <name>` | 컨테이너 중지 |
| `docker rm <name>` | 컨테이너 삭제 |
| `docker rm <id1> <id2>` | 여러 컨테이너 동시 삭제 |

## 6) 커스텀 NGINX 이미지 제작

### 선택 방식
- **(A) 웹 서버 베이스 이미지 활용**
- 베이스 이미지: `nginx:alpine`

### 커스텀 포인트
| 항목 | 목적 |
|------|------|
| `default.conf` 교체 | `/health` 엔드포인트 추가, 커스텀 설정 적용 |
| `index.html` 교체 | 기본 NGINX 페이지 대신 커스텀 페이지 제공 |

### 빌드 및 실행 명령
```bash
# 이미지 빌드
docker build -t custom-nginx .

# 컨테이너 실행 (포트 매핑: 로컬 8080 → 컨테이너 80)
docker run -d -p 8080:80 --name my-nginx custom-nginx
```

### 핵심 결과
- 이미지 빌드 성공: 62.4MB
- 컨테이너 실행 성공

### 포트 매핑 및 접속 확인
- 접속 주소: `http://localhost:8080`

<img width="1005" height="1260" alt="스크린샷 2026-08-10 오후 3 54 35" src="https://github.com/user-attachments/assets/369191f7-ffee-4653-ae29-3334c203960b" />


- 헬스체크: `http://localhost:8080/health` → `healthy` 응답
 
<img width="856" height="205" alt="스크린샷 2026-08-10 오후 1 37 39" src="https://github.com/user-attachments/assets/49d0874e-2bba-442b-ae07-27fe403c84b3" />

### 접속 화면

## 7) Docker 볼륨 영속성 검증

---

### 7.1. 볼륨 생성

```bash
docker volume create my-volume
```

**출력:**
```
my-volume
```

---

### 7.2. 볼륨 확인

```bash
docker volume ls
```

**출력:**
```
DRIVER    VOLUME NAME
local     my-volume
```

---

### 7.3. 컨테이너 생성 및 데이터 쓰기

```bash
docker run -it --name test-container -v my-volume:/data ubuntu
```

**컨테이너 내부:**
```bash
echo "hello volume" > /data/test.txt
cat /data/test.txt
```

**출력:**
```
hello volume
```

---

### 7.4. 컨테이너 삭제

```bash
docker rm test-container
```

**출력:**
```
test-container
```

---

### 7.5. 호스트에서 데이터 접근 불가 확인

```bash
cat /data/test.txt
```

**출력:**
```
cat: /data/test.txt: No such file or directory
```

> 💡 데이터는 호스트가 아닌 **Docker 볼륨**에 저장되므로 호스트에서는 접근 불가

---

### 7.6. 새 컨테이너로 데이터 유지 확인 ✅

```bash
docker run -it --name test-container2 -v my-volume:/data ubuntu
```

**컨테이너 내부:**
```bash
cat /data/test.txt
```

**출력:**
```
hello volume
```

> ✅ **컨테이너 삭제 후에도 볼륨 데이터가 유지됨을 확인**

---

## 8) Git 설정

### 8.1. Git 설정 확인

```bash
git config --list
```

**출력:**
```
credential.helper=osxkeychain
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
remote.origin.url=https://github.com/rlaqudgus/Codyssey_Mission.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
branch.main.vscode-merge-base=origin/main
```

---

### 8.2. GitHub 연동 확인

```bash
git remote -v
```

**출력:**
```
origin  https://github.com/rlaqudgus/Codyssey_Mission.git (fetch)
origin  https://github.com/rlaqudgus/Codyssey_Mission.git (push)
```

> ✅ **GitHub 저장소 연동 완료**

---

## 9) 트러블슈팅

### TS-01. NGINX 컨테이너 접속 불가 (default.conf 설정 누락)

**문제 상황**
- `docker run -p 8080:80` 으로 컨테이너 실행 후 브라우저에서 `localhost:8080` 접속 시 응답 없음

**원인**
- `default.conf` 파일이 비어있어 NGINX가 어떤 요청도 처리하지 못함
- `COPY default.conf /etc/nginx/conf.d/default.conf` 로 빈 파일이 그대로 컨테이너에 복사됨

**해결 과정**

```bash
# 1. default.conf 내용 확인
cat default.conf
# → 아무것도 출력되지 않음 (빈 파일)

# 2. 올바른 server 블록 작성
cat > default.conf << 'EOF'
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
EOF

# 3. 이미지 재빌드
docker build -t my-nginx .

# 4. 컨테이너 재실행
docker run -d -p 8080:80 my-nginx
```

**결과**
- `localhost:8080` 접속 성공 ✅

**교훈**
> NGINX는 `default.conf`가 비어있으면 아무 요청도 처리하지 않음.  
> `server { listen 80; ... }` 블록이 반드시 존재해야 함.

---

### TS-02. Docker 이미지 빌드 후 변경사항 미반영

**문제 상황**
- `index.html` 수정 후 브라우저 새로고침해도 이전 내용이 그대로 출력됨

**원인**
- 이미지를 재빌드하지 않고 기존 컨테이너를 그대로 실행 중이었음
- Docker는 이미지를 기반으로 컨테이너를 생성하므로, 소스 변경 시 **반드시 재빌드 필요**

**해결 과정**

```bash
# 1. 실행 중인 컨테이너 중지 및 삭제
docker stop my-nginx-container
docker rm my-nginx-container

# 2. 이미지 재빌드
docker build -t my-nginx .

# 3. 컨테이너 재실행
docker run -d -p 8080:80 --name my-nginx-container my-nginx
```

**결과**
- 수정된 `index.html` 내용이 브라우저에 정상 반영 ✅

**교훈**
> 파일을 수정했다면 반드시 `docker build` → `docker run` 순서로 재실행해야 함.  
> 컨테이너는 이미지의 **스냅샷**이므로 소스 변경이 자동 반영되지 않음.

