# GIT SWIPE (https://github.com/zueve/git-swipe)
# based on https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
_git_swipe ()
{
	local dwim_opt="$(__git_checkout_default_dwim_mode)"

	case "$prev" in
	-c|-C|--orphan)
		# Complete local branches (and DWIM branch
		# remote branch names) for an option argument
		# specifying a new branch name. This is for
		# convenience, assuming new branches are
		# possibly based on pre-existing branch names.
		__git_complete_refs $dwim_opt --mode="heads"
		return
		;;
	*)
		;;
	esac

	case "$cur" in
	--conflict=*)
		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
		;;
	--*)
		__gitcomp_builtin swipe
		;;
	*)
		# Unlike in git checkout, git swipe --orphan does not take
		# a start point. Thus we really have nothing to complete after
		# the branch name.
		if [ -n "$(__git_find_on_cmdline "--orphan")" ]; then
			return
		fi

		# At this point, we've already handled special completion for
		# -c/-C, and --orphan. There are 3 main things left to
		# complete:
		# 1) a start-point for -c/-C or -d/--detach
		# 2) a remote head, for --track
		# 3) a branch name, possibly including DWIM remote branches

		if [ -n "$(__git_find_on_cmdline "-c -C -d --detach")" ]; then
			__git_complete_refs --mode="refs"
		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
			__git_complete_refs --mode="remote-heads"
		else
			__git_complete_refs $dwim_opt --mode="heads"
		fi
		;;
	esac
}