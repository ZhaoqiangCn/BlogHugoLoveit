#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
HUGO_ENV=production hugo --gc --minify 

#npm run algolia

#hugo -t loveit

#echo "acbdc102e2c95f016d423fa03690923d $2"
#searchKey="$2"
#python2 search_process.py -k "${searchKey}" || fail "site search data process fail. Error Code: [ $? ]"

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin develop

