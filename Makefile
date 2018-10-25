OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')

# metafiles:
# 	utils/$(OS)/wof-build-metafiles -out meta .

refresh:
	@make refresh-wof
	@make refresh-sfomuseum

refresh-whosonfirst:
	utils/$(OS)/wof-fetch -retries 3 -strict -belongs-to country -writer 'writer=repo root=.' -reader 'reader=github repo=whosonfirst-data' -reader 'reader=github repo=whosonfirst-data-postalcode-us' -mode repo .

refresh-sfomuseum:
	python2 utils/python/merge-properties -p properties -d data

prune:
	git gc --aggressive --prune

rm-empty:
	find data -type d -empty -print -delete

scrub: rm-empty prune
