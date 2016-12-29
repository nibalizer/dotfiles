#!/bin/bash

repo=$1
FQDN=`hostname -f`

if [ -z $repo ]; then
  echo "Please provide a repository name"
  echo "Usage: $0 <reponame>"
  exit 1
fi

if [ -d ~/git/${repo} ]; then
  echo "Repository already exists?"
  echo "Found a directory at ~${USER}/git/${repo}"
  exit 1
fi

cd 
mkdir ~/git/${repo}
cd ~/git/${repo}
git init --bare

echo "Local path: ~/git/${repo}"
echo "git remote add origin ${USER}@${FQDN}:git/${repo}"
echo "git clone ${USER}@${FQDN}:git/${repo}"
