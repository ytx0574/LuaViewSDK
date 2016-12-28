GIT_MERGE="git merge $1"

echo "save current branch changes:"

git stash

GIT_CURRENT_BRANCH=$(git symbolic-ref -q HEAD)
GIT_CURRENT_BRANCH=${GIT_CURRENT_BRANCH##refs/heads/}
GIT_CURRENT_BRANCH=${GIT_CURRENT_BRANCH:-HEAD}


git pull
git checkout develop
git pull
$GIT_MERGE

echo "\npush to develop"
git push
echo "\npush to github on branch develop"
git push https://github.com/alibaba/LuaViewSDK develop:develop

echo "\n"
git checkout master
git pull
git merge develop

echo "\npush to master"
git push
echo "\npush to github on branch master"
git push https://github.com/alibaba/LuaViewSDK master:master

git checkout $GIT_CURRENT_BRANCH
git stash apply
