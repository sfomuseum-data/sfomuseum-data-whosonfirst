OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')

# metafiles:
# 	utils/$(OS)/wof-build-metafiles -out meta .

sfo:
	utils/$(OS)/wof-fetch-ids -reader 'type=github repo=whosonfirst-data' -reader 'type=github repo=whosonfirst-data-postalcode-us' -target data 102527513

prune:
	git gc --aggressive --prune

rm-empty:
	find data -type d -empty -print -delete

scrub: rm-empty prune
