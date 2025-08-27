prune:
	git gc --aggressive --prune=now
	git repack -Adf --depth=50 --window-memory=100m
