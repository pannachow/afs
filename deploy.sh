#!/usr/bin/env sh

# taken from https://cli.vuejs.org/guide/deployment.html#github-pages
# chmod +x deploy.sh to make it executable

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

# if you are deploying to a custom domain
echo 'pannachow.io' > CNAME

git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:pannachow/transfers.git master:gh-pages

cd -
