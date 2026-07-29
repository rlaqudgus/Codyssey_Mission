#!/bin/bash
# 이 파일은 실행 환경 정보를 자동으로 수집해요

echo "## 1) 실행 환경"
echo ""
echo "- **OS**: $(sw_vers -productName) $(sw_vers -productVersion)"
echo "- **아키텍처**: $(uname -m)"
echo "- **셸**: $SHELL"
echo "- **Git 버전**: $(git --version)"