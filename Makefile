show-help: help

install: ## Install / Rebuild the binary
	cp git-wip /usr/local/bin
	cp git-unwip /usr/local/bin
	cp git-swap /usr/local/bin

uninstall: ## Remove 
	rm /usr/local/bin/git-wip
	rm /usr/local/bin/git-unwip 
	rm /usr/local/bin/git-swap 

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-19s\033[0m %s\n", $$1, $$2}'

hist-alias: ## Cfeate pretty git hist alias
	git config --global alias.hist "log --pretty=format:'%C(yellow)[%ad]%C(reset) %C(green)[%h]%C(reset) | %C(red)%s %C(bold red)%an%C(reset) %C(blue)%d%C(reset)' --graph --date=short"