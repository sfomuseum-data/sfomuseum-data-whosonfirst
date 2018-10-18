OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')

# metafiles:
# 	utils/$(OS)/wof-build-metafiles -out meta .

refresh:
	@make refresh-wof

refresh-wof:
	utils/$(OS)/wof-fetch -writer 'writer=repo root=.' -reader 'reader=github repo=whosonfirst-data' -reader 'reader=github repo=whosonfirst-data-postalcode-us' -mode repo .

prune:
	git gc --aggressive --prune

rm-empty:
	find data -type d -empty -print -delete

scrub: rm-empty prune
