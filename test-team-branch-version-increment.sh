#!/bin/bash
# Test for pre-push hook to increment version number in team branch
# WARNING: Will do hard reset on branch, don't use if you have any changes!
# Parameters: 1. path to get repo to run test on
# Usage: ./test-team-branch-version-increment.sh ~/app/test.repo

SUCCESS_TEXT="<<INSERT HERE>>"

GIT_REPO_PATH=$1

eval cd ${GIT_REPO_PATH}

git checkout team/ATCM
git reset --hard origin/team/ATCM
git pull

# GIVEN: create and commit test file
echo "TESTING" > test.sh
git add test.sh
git commit -m "testing, do not submit"

# WHEN: push to team branch
OUTPUT=$(git push origin HEAD:refs/for/team/ATCM 2>&1)

# THEN: should have created a code review in Gerrit
if [[ $OUTPUT = *"${SUCCESS_TEXT}"* ]] ; then
	echo "PASSED TEST. Review (abandon manually): "`grep -o 'http://codereview[^ ]*' <<< "$OUTPUT"`
	git reset --hard origin/team/ATCM
	exit 0
else
	echo "OUTPUT: "$OUTPUT
	echo "FAILED TEST"
	git reset --hard origin/team/ATCM
	exit 1
fi


