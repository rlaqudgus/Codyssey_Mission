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
## 4) Docker 설치 확인 및 기본 명령
## 5) Dockerfile 작성 및 이미지 빌드
## 6) 컨테이너 실행 (포트 매핑)
## 7) 볼륨 / 바인드 마운트
## 8) attach vs exec 관찰
## 9) 트러블슈팅