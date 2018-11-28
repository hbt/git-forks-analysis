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


[//]: # (// TODO(hbt) ENHANCE simplify Config)


// TODO(hbt) NEXT add instructions 

## How to install it?

// TODO(hbt) NEXT add submodules init  -- test from scratch
```bash

git clone https://github.com/hbt/git-forks-analysis
docker-compose pull hbtlabs/git-forks-analysis

```

## How to use it?

// TODO(hbt) ENHANCE check code highlight 

To generate HTML visualization of forks

```

cd bin

./analyze-forks username repository

# retrieve all direct forks for https://github.com/hbt/mouseless
./analyze-forks hbt mouseless

# retrieve all forks recursively (the whole network) https://github.com/frost-nzcr4/find_forks -- purposefully chose a small repo to avoid running this by mistake
./analyze-forks-deep frost-nzcr4 find_forks

```

view generated html files  in `out` directory for:

- gitinspector in /out/repo.html e.g /out/mouseless.html
- quick_stats in /out/repo/quick_stats/index.html e.g /opt/mouseless/quick_stats/index.html


Calling the `gitinspector` directly via CLI

```bash

./bin/gitinspector /out/mouseless
./bin/gitinspector --grading=true /out/mouseless
./bin/gitinspector --grading=true  --format=html /out/mouseless

```




