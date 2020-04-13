#/bin/bash

git clone https://github.com/tredfern/moonpie-template.git $1
cd $1
rm -r .git
git init .
git add --all
git commit -m "Initial Commit"
rm -rf ext/moonpie
git submodule init
git submodule add https://github.com/tredfern/moonpie.git ext/moonpie