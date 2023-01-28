DAT=$(date '+%Y-%m-%dT%H:%M:%S')
git add .
git commit -m "Notes sync. $DAT"
git push origin main
