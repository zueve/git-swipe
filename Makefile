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

