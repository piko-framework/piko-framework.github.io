#!/usr/bin/env sh

# abort on errors
set -e

# build
bundle exec jekyll build

# navigate into the build output directory
cd _site

git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:piko-framework/piko-framework.github.io.git master:main

cd -


