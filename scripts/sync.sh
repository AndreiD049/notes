DAT=$(date '+%Y-%m-%dT%H:%M:%S')
git pull origin main
# Build the wiki index.html
npx tiddlywiki ./data/Default --build index
mv ./data/Default/output/index.html ./docs/
# Commit changes
git add .
git commit -m "Notes sync. $DAT"
git push origin main
