# GIT SWIPE (https://github.com/zueve/git-swipe)
# based on https://github.com/zsh-users/zsh/blob/master/Completion/Unix/Command/_git 
(( $+functions[_git-swipe] )) ||
_git-swipe() {
  local curcontext="$curcontext" state line expl ret=1
  local -A opt_args

  _arguments -C -s -S $endopt \
    '(-c --create -C --force-create -d --detach --orphan --ignore-other-worktrees 1)'{-c,--create}'[create and swipe to a new branch]:branch:->branches' \
    '(-c --create -C --force-create -d --detach --orphan --ignore-other-worktrees 1)'{-C,--force-create}'[create/reset and swipe to a branch]:branch:->branches' \
    "(--guess --orphan 2)--no-guess[don't second guess 'git swipe <no-such-branch>']" \
    "(--no-guess -t --track -d --detach --orphan 2)--guess[second guess 'git swipe <no-such-branch> (default)]" \
    '(-f --force --discard-changes -m --merge --conflict)'{-f,--force,--discard-changes}'[throw away local modifications]' \
    '(-q --quiet --no-progress)'{-q,--quiet}'[suppress feedback messages]' \
    '--recurse-submodules=-[control recursive updating of submodules]::checkout:__git_commits' \
    '(-q --quiet --progress)--no-progress[suppress progress reporting]' \
    '--progress[force progress reporting]' \
    '(-m --merge --discard-changes --orphan)'{-m,--merge}'[perform a 3-way merge with the new branch]' \
    '(--discard-changes --orphan)--conflict=[change how conflicting hunks are presented]:conflict style [merge]:(merge diff3)' \
    '(-d --detach -c --create -C --force-create --ignore-other-worktrees --orphan --guess --no-guess 1)'{-d,--detach}'[detach HEAD at named commit]' \
    '(-t --track --no-track --guess --orphan 1)'{-t,--track}'[set upstream info for new branch]' \
    "(-t --track --guess --orphan 1)--no-track[don't set upstream info for a new branch]" \
    '(-c --create -C --force-create -d --detach --ignore-other-worktrees -m --merge --conflict -t --track --guess --no-track -t --track)--orphan[create new unparented branch]: :__git_branch_names' \
    '!--overwrite-ignore' \
    "(-c --create -C --force-create -d --detach --orphan)--ignore-other-worktrees[don't check if another worktree is holding the given ref]" \
    '1: :->branches' \
    '2:start point:->start-points' && ret=0

  case $state in
    branches)
      if [[ -n ${opt_args[(i)--guess]} ]]; then
	# --guess is the default but if it has been explicitly specified,
	# we'll only complete remote branches
	__git_remote_branch_names_noprefix && ret=0
      else
	_alternative \
	  'branches::__git_branch_names' \
	  'remote-branch-names-noprefix::__git_remote_branch_names_noprefix' && ret=0
      fi
    ;;
    start-points)
      if [[ -n ${opt_args[(I)-t|--track|--no-track]} ]]; then
	# with an explicit --track, stick to remote branches
	# same for --no-track because it'd be meaningless with anything else
	__git_heads_remote && ret=0
      else
	__git_revisions && ret=0
      fi
    ;;
  esac

  return ret
}