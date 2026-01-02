cd ..
git add .
$timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
$message = "[$timestamp] push by $($env:USERNAME)"
git commit -m $message
git push origin main




#code par ex pour push tout mon git vers github
#ou script d installation local
#
#Tools c est pour des scripts pour lesz devs limite faire un .gitignore
