<?php

function config()
{
    set_time_limit(0);
    assert_options(ASSERT_ACTIVE, true);
    assert_options(ASSERT_BAIL, true);
    ini_set('assert.active', 1);
    ini_set('assert.bail', 1);
    ini_set('assert.warning', 1);
    ini_set('assert.exception', 1);
    ini_set('zend.assertions', 1);
}

function check($argv, $min)
{
    assert(count($argv) === $min, "Expects $min parameters. \n Usage: username repository");
}

function shell($cmd)
{
    system($cmd);
}

function getAllDirectForks(string $user, string $repo)
{
    $outDir = "/out/$repo";

    $cmd = "git clone https://github.com/$user/$repo";
    shell($cmd);

    assert(file_exists($outDir), "Could not clone repository $cmd");

    $cmd = "cd $outDir && /git-forks-analysis-src/bin/find-forks";
    shell($cmd);

    quickStats($user, $repo);
}

/**
 * @param string $user
 * @param string $repo
 */
function quickStats(string $user, string $repo)
{
    $cmd = "python /git-forks-analysis-src/deps/gitinspector/gitinspector.py --grading=true --format=html  /out/$repo >  /out/$repo.html";
    shell($cmd);

    $cmd = sprintf('bash -l -c "rvm use 2.1.3 && ruby --version && cd /out/%s && /deps/git_stats/bin/git_stats generate"', $repo);
    shell($cmd);
    
    echo "View output in " . "/out/$repo.html AND in /out/$repo/quick_stats/index.html";
}


function getAllForksRecursively(string $user, string $repo)
{
    $outDir = "/out/$repo";

    assert(file_exists('/root/.ssh2'), '/root/.ssh2 not mounted');
    assert(file_exists('/root/.gitconfig'), '/root/.gitconfig not mounted');

    $cmd = "/git-forks-analysis-src/bin/find-forks-recursively -u $user -r $repo -o /out -f";
    shell($cmd);

    assert(file_exists($outDir), "Could not clone repository $cmd");

    quickStats($user, $repo);
}

function analyzeForks($argv)
{

    config();
    check($argv, 3);

    $user = trim($argv[1]);
    $repo = trim($argv[2]);

    getAllDirectForks($user, $repo);
}

function analyzeForksRecursively($argv)
{

    config();
    check($argv, 3);

    $user = trim($argv[1]);
    $repo = trim($argv[2]);

    getAllForksRecursively($user, $repo);
}
