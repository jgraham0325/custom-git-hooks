# Description
Scripts to automtically increment the version number when on team branch (project specific concept where snapshot numbers need to be incremented each time)

There is a pre-commit hook that checks artifactory for the latest version and then increments by 1

There is also a pre-push hook that checks to make sure someone hasn't subsequently built a version with same number. If so it'll fail the push and you'll need to do a "git commit --amend" to rerun the git hook that bumps the version or manually update the version numbers

# Installation
Run from mac/linux command line: setup-team-branch-version-increment.sh "~/app"

(where ~/app is the root folder of your git repos)

This will then update all of your git repos to use the git hooks in this folder by default


# Testing
There is a test script included in this directory that creates a dummy file and makes sure it's correctly pushed to gerrit. 
Update it with your git repos base path
