DAT=$(date '+%Y-%m-%dT%H:%M:%S')
git pull origin main
git add .
git commit -m "Notes sync. $DAT"
git push origin main
