#!/bin/bash

# Script : setup-repository.bas
# Author : M. Romdhani
# This scripts creates and initializes a Git Repo in a folder named repo-challenge.
# -------------------------------------------------------------------------------- 

# functions section
cleanUpFolderIfExits() {
 if [ -d "$1" ]; then
     rm -rf "$1"
     echo "Removed the existing $1..."
  fi
}
setCommitterLocally() {
  git config --local  user.name "$1"
  git config --local  user.email "$2"
}

# The Scripts Starts here

# Initializing a new repository
REPO_FOLDER="repo-challenge"
cleanUpFolderIfExits $REPO_FOLDER
echo "Setting Up the Repository in: ${DIR}..."
git init "$REPO_FOLDER"

# Go there 
cd "$REPO_FOLDER"  || exit

setCommitterLocally "Me, the Challenger" "challenger@challengeland.com"

### Making Commit 01
echo " Working on Commit 01 ..."
git commit --allow-empty -m "01- Initial commit"


### Making Commit 02
echo " Working on Commit 02 ..."
echo "Unrelated stuff!" > other.code
git add .
git commit -am "02- Finished Hello World feature"

### Making Commit 03
echo " Working on Commit 03 ..."
echo "Hello" > hello.code
git add hello.code
git commit -m "03- StArrtid Helo Volrd feature"

### Making Commit 04
echo " Working on Commit 04 ..."

echo "HelloWrld?" > hello.code
echo "Hello World!" > hello.code
git commit -am "04- Really made the thingy done"

### Making Commit 05
echo " Working on Commit 05 ..."
setCommitterLocally "LE Pompier" "super.pompier@debugland.com"
echo "HelloWrld?" > hello.code
echo "println DEBUG" > hello.code
git commit -am "05- debugging"

### Making Commit 06
echo " Working on Commit 06 ..."
setCommitterLocally "Me, the Challenger" "challenger@challengeland.com"
echo "4321pass" > private.secret
git add private.secret
git commit -m "06- important secret"

### Making Commit 07
echo " Working on Commit 07 ..."
echo "# THE Hello World program" > README.md
git add README.md
git commit -m "07- Add doc - step 1"

### Making Commit 08
echo " Working on Commit 08 ..."
echo "# THE Ultimate Hello World program" > README.md
git commit -am "08- Add doc - step 2"

### Making Commit 09
echo " Working on Commit 09 ..."
echo "" >> README.md
echo "This program does exactly what it says" >> README.md
git commit -am "09- Add doc - step 3"

### Making Commit 10
echo " Working on Commit 10 ..."
echo "should_return_true(hello.code)" > hello.test
git add hello.test
git commit -m "10- Test for feature hello world"

### Making Commit 11
echo " Working on Commit 11 ..."
echo "should_return_true(hello.code);" > hello.test
git commit -am "11- I forgot a semicolon"

# ----- End of the Script