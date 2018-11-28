# git-forks-analysis

Analyze forks network to find interesting forks, commits, file changes.


## Why build it?

* Frustration with navigation forks graph / network on GitHub
* Too many forks with nothing interesting and noisy commits
* Wanting to find changes made to a file, function or a set of lines across the network to avoid duplicating the work (fixing similar bugs or building similar features)

## How does it work?

* Gets all forks and all branches into a single repository
* Make available git data mining tools such as `gitinspector` and `git_stats`. Use the tools in this repository as they have been modified to work across all branches
* View other `Tips` below on how to search across the forks network using Git commands





## How to install it?

```bash

git clone https://github.com/hbt/git-forks-analysis
docker-compose pull hbtlabs/git-forks-analysis

```

## How to use it?

To generate HTML visualization of forks

```

cd bin

./analyze-forks username repository

# retrieve all direct forks for https://github.com/hbt/mouseless
./analyze-forks hbt mouseless

# retrieve all forks recursively (the whole network) https://github.com/frost-nzcr4/find_forks -- purposefully chose a small repo to avoid running this by mistake
./analyze-forks-deep frost-nzcr4 find_forks

```

Calling the `gitinspector` directly via CLI

```bash

./bin/gitinspector /out/mouseless
./bin/gitinspector --grading=true /out/mouseless
./bin/gitinspector --grading=true  --format=html /out/mouseless

```

## What does it look like?

* gitinspector of mouseless [mouseless HTML](/example/mouseless/mouseless.html)
* gitinspector CLI output [mouseless CLI](/example/mouseless/mouseless.txt)
* quick_stats of mouseless [mouseless quick stats](/example/mouseless/git_stats/index.html)

## How to find interesting forks?

* Forks with stars / watchers -- use https://techgaun.github.io/active-forks/index.html
* Looks for commits count, insertions and deletion counts


## How to search for commits per file across all forks and branches?

```bash

cd out/mouseless
git log --all background_scripts/extension-reloader.js

# include diffs

git log -p --all background_scripts/extension-reloader.js


```

## How to search for changes in a function across all forks and branches?

```bash

# look for contributions to a specific function across all forks
git log --all -p -L ":getCenters":lib/model/PersonInfo.php --ignore-all-space --ignore-space-change --ignore-space-at-eol --ignore-blank-lines


# also accepts line numbers range
git log --all -p -L 13,20:lib/model/PersonInfo.php --ignore-all-space --ignore-space-change --ignore-space-at-eol --ignore-blank-lines

#modify ~/.gitattributes to add language support
#*.php diff=php
#*.js diff=node

#normalize the repo in case of ^M
#Note: this might fuck up some file formats (e.g binary, images etc.)
https://superuser.com/questions/293941/rewrite-git-history-to-replace-all-crlf-to-lf

**Note: perform all operations on tmpfs. Much faster**
#normalize the whole repo and its history
# specific file  (much faster) -- few minutes
git filter-branch --tree-filter 'git ls-files lib/model/PersonInfo.php -z | xargs -0 fromdos' -- --all

#whole repo but takes longer
git filter-branch --tree-filter 'git ls-files -z | xargs -0 fromdos' -- --all


#Alternative if language is not properly supported is to use pickaxe
git log --all -p -S"function createHints"  content_scripts/hints.js

# for some languages, --function-context works well
git log --all -p -ScreateHints --function-context content_scripts/hints.js


```


## Other git data mining tools worth a mention

* [https://github.com/arzzen/git-quick-stats](https://github.com/arzzen/git-quick-stats)
* [https://github.com/src-d/hercules](https://github.com/src-d/hercules)


## Contribute: Get in touch if you have a git data mining tool recommendation
