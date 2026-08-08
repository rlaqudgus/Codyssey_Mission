# 코디세이 1차 미션 - 개발 워크스테이션 구축

## 1) 실행 환경

- **OS**: macOS 15.7.4
- **아키텍처**: x86_64
- **셸**: /bin/zsh
- **Git 버전**: git version 2.53.0

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
## 5) Dockerfile 작성 및 이미지 빌드
## 6) 컨테이너 실행 (포트 매핑)
## 7) 볼륨 / 바인드 마운트
## 8) attach vs exec 관찰
## 9) 트러블슈팅