#!/bin/bash

# 一键 put 到 github 仓库
# 如果没有执行权限 运行: chmod 777 ./putToGithub.sh 或 chmod u+x ./putToGithub.sh

read -p "Please input put Github explain: " PUT_GIT_EXPLAIN

git add .
git commit -m ${PUT_GIT_EXPLAIN}
git push origin master