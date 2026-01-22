#!/bin/bash
# 오늘의집 API 데이터 갱신 스크립트
# 사용법: ./update-data.sh

echo "📦 오늘의집 데이터 갱신 중..."

# Summary (통계 + 리뷰) - nickname, userId 제거
echo "  - Summary 데이터 가져오는 중..."
curl -s "https://ohou.se/expert/contents/api/v1/myhome/23827218/summaries?addressId=61b6d8ab2d280b026ee2f98c" | \
  jq 'walk(if type == "object" then del(.nickname, .userId) else . end)' > data/summary.json

# Portfolio (포트폴리오)
echo "  - Portfolio 데이터 가져오는 중..."
curl -s "https://ohou.se/expert/contents/api/v1/myhome/23827218/contents?size=24&type=1&portfolioListType=3&addressId=61b6d8ab2d280b026ee2f98c" > data/portfolio.json

# Photos (사진)
echo "  - Photos 데이터 가져오는 중..."
curl -s "https://ohou.se/expert/contents/api/v1/myhome/23827218/contents?size=24&type=2&portfolioListType=3&addressId=61b6d8ab2d280b026ee2f98c" > data/photos.json

echo "✅ 데이터 갱신 완료!"
echo ""
echo "갱신된 파일:"
ls -la data/*.json
echo ""
echo "커밋하려면: git add data/ && git commit -m 'chore: 오늘의집 데이터 갱신' && git push"
