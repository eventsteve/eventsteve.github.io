---
layout: post
title:      Git simple guidelines
date:       2014-04-13 02:32:00
summary:    Simple guide for getting started GIT
category:   git
comments:   true
tags:       git
permalink:  /git-simple-guidelines.html
---

  * [Git Setup](#Git Setup)
  * [Git Config](#Git Config)
  * [Create a new repository](#Create a new repository)
  * [Checkout a repository](#Checkout a repository)
  * [Add & Commit](#Add & Commit)
  * [Pushing changes](#Pushing changes)
  * [Branching](#Branching)
  * [Update & Merge](#Update & Merge)
  * [Tagging](#Tagging)
  * [Log](#Log)
  * [Replace local changes](#Replace local changes)

___



### Git Setup<a id="Git Setup"></a>
  * [Download git for OSX](https://git-scm.com/download/mac)
  * [Download git for Windows](https://git-scm.com/download/win)
  * [Download git for Linux](https://git-scm.com/download/linux)
  * [Download git for Solaris](https://git-scm.com/download/linux)
	

### Git Config<a id="Git Config"></a>



Git comes with a tool called git config that lets you get and set configuration variables that control all aspects of how Git looks and operates. These variables can be stored in three different places:

/etc/gitconfig file: Contains values for every user on the system and all their repositories. If you pass the option--system to git config, it reads and writes from this file specifically.
~/.gitconfig file: Specific to your user. You can make Git read and write to this file specifically by passing the --global option.
config file in the git directory (that is, .git/config) of whatever repository you’re currently using: Specific to that single repository. Each level overrides values in the previous level, so values in .git/config trump those in /etc/gitconfig.


git config --global user.name "Terry Wang"
git config --global user.email 'terry.wang@linux.ninja'
git config --global core.editor vim
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global merge.tool vimdiff
git config --global alias.d difftool



Check config

git config --list
git config -l


### Create a new repository<a id="Create a new repository"></a>


### Checkout a repository<a id="Checkout a repository"></a>


### Add & Commit<a id="Add & Commit"></a>


You can propose changes (add it to the Index) using
git add <filename>
git add *
This is the first step in the basic git workflow. To actually commit these changes use
git commit -m "Commit message"
Now the file is committed to the HEAD, but not in your remote repository yet.

### Pushing changes<a id="Pushing changes"></a>

Your changes are now in the HEAD of your local working copy. To send those changes to your remote repository, execute 
git push origin master
Change master to whatever branch you want to push your changes to. 

If you have not cloned an existing repository and want to connect your repository to a remote server, you need to add it with
git remote add origin <server>
Now you are able to push your changes to the selected remote server


### Branching<a id="Branching"></a>

Branches are used to develop features isolated from each other. The master branch is the "default" branch when you create a repository. Use other branches for development and merge them back to the master branch upon completion.

create a new branch named "feature_x" and switch to it using
git checkout -b feature_x
switch back to master
git checkout master
and delete the branch again
git branch -d feature_x
a branch is not available to others unless you push the branch to your remote repository
git push origin <branch>



### Update & Merge<a id="Update & Merge"></a>


to update your local repository to the newest commit, execute 
git pull
in your working directory to fetch and merge remote changes.
to merge another branch into your active branch (e.g. master), use
git merge <branch>
in both cases git tries to auto-merge changes. Unfortunately, this is not always possible and results in conflicts. You are responsible to merge those conflicts manually by editing the files shown by git. After changing, you need to mark them as merged with
git add <filename>
before merging changes, you can also preview them by using
git diff <source_branch> <target_branch>



### Tagging<a id="Tagging"></a>

it's recommended to create tags for software releases. this is a known concept, which also exists in SVN. You can create a new tag named 1.0.0 by executing
git tag 1.0.0 1b2e1d63ff
the 1b2e1d63ff stands for the first 10 characters of the commit id you want to reference with your tag. You can get the commit id by looking at the... 


###Log<a id="Log"></a>

in its simplest form, you can study repository history using.. git log
You can add a lot of parameters to make the log look like what you want. To see only the commits of a certain author:
git log --author=bob
To see a very compressed log where each commit is one line:
git log --pretty=oneline
Or maybe you want to see an ASCII art tree of all the branches, decorated with the names of tags and branches: 
git log --graph --oneline --decorate --all
See only which files have changed: 
git log --name-status
These are just a few of the possible parameters you can use. For more, see git log --help



### Replace local changes<a id="Replace local changes"></a>


In case you did something wrong, which for sure never happens ;), you can replace local changes using the command
git checkout -- <filename>
this replaces the changes in your working tree with the last content in HEAD. Changes already added to the index, as well as new files, will be kept.

If you instead want to drop all your local changes and commits, fetch the latest history from the server and point your local master branch at it like this
git fetch origin
git reset --hard origin/master
