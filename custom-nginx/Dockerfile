# 1) 기존 베이스 이미지 선택
FROM nginx:alpine

# 2) 메타데이터 (커스텀 포인트: 이미지 정보 명시)
LABEL maintainer="your-name"
LABEL description="Custom NGINX with static content & healthcheck"

# 3) 환경변수 설정 (커스텀 포인트)
ENV APP_ENV=production

# 4) 커스텀 정적 콘텐츠 교체
COPY html/ /usr/share/nginx/html/

# 5) 커스텀 nginx 설정 교체
COPY default.conf /etc/nginx/conf.d/default.conf

# 6) 헬스체크 추가 (커스텀 포인트)
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost/health || exit 1

# 7) 포트 노출
EXPOSE 80