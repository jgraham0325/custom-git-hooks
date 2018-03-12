#!/bin/bash -e
usage(){ 
cat <<END
-----------------------------------------------------------------------------------
 Description: Sets up global git hooks for GIT projects
 Useful for actions like incrementing team branch version numbers for each commit

 Parameters:
 1. Path to local GIT repos root (e.g. "~/app")

 Usage: ./setup-team-branch-version-increment.sh "~/app"
-----------------------------------------------------------------------------------
END
}

[[ ($# -ne 1) ]] && ( usage ; exit 1 )

GIT_REPO_ROOT_PATH=$1

CURRENT_SCRIPT_DIRECTORY=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
GLOBAL_GIT_HOOKS_PATH=${CURRENT_SCRIPT_DIRECTORY}"/git-templates/hooks/"
GIT_REPO_SEARCH="find ./* -type d -maxdepth 0"

function main() {

	eval cd $GIT_REPO_ROOT_PATH

	printGitReposToUpdate

	read -p "Would you like to proceed with setting global git hooks for these repos? type y or n: " -n 1 -r
	echo    
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    createGlobalHookSymlinks
	fi
}

function printGitReposToUpdate() {
	echo "===================================="
	echo "GIT directories found to update:"
	echo "===================================="
	for DIRECTORY in `${GIT_REPO_SEARCH}`; do
		echo $DIRECTORY
	done
	echo "===================================="
}

function createGlobalHookSymlinks(){
echo "Setting repos to use git hooks in: "${GLOBAL_GIT_HOOKS_PATH}
for REPO_DIRECTORY in `${GIT_REPO_SEARCH}`; do
	for HOOK_FILE_PATH in ${GLOBAL_GIT_HOOKS_PATH}*; do
		HOOK_FILE_NAME=$(basename ${HOOK_FILE_PATH})
		echo "Setting up symlink for hook (${HOOK_FILE_PATH}) in repo: ${REPO_DIRECTORY}"
		rm -f "${REPO_DIRECTORY}/.git/hooks/${HOOK_FILE_NAME}"
		ln -sf "${HOOK_FILE_PATH}" "${REPO_DIRECTORY}/.git/hooks/${HOOK_FILE_NAME}"
	done
done
}

main




