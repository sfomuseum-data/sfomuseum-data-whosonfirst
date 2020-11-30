OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')

# metafiles:
# 	utils/$(OS)/wof-build-metafiles -out meta .

fetch:
	utils/$(OS)/wof-fetch -retries 3 -strict -belongs-to country -writer 'writer=repo root=.' -reader 'reader=github repo=whosonfirst-data' -mode ids $(IDS)

refresh:
	@make refresh-whosonfirst
	@make refresh-sfomuseum

refresh-whosonfirst:
	# utils/$(OS)/wof-fetch -retries 3 -strict -belongs-to region -belongs-to country -writer 'writer=repo root=.' -reader 'reader=github repo=whosonfirst-data' -reader 'reader=github repo=whosonfirst-data-postalcode-us' -mode repo .
	/Users/asc/whosonfirst/go-whosonfirst-fetch/bin/fetch -retries 3 -belongs-to region -belongs-to country -writer-uri stdout:// -mode repo .

refresh-sfomuseum:
	@make ensure-sfomuseum
	python2 utils/python/merge-properties -p properties -d data

ensure-sfomuseum:
	python2 utils/python/ensure-sfomuseum-properties -p properties -d data

prune:
	git gc --aggressive --prune

rm-empty:
	find data -type d -empty -print -delete

scrub: rm-empty prune

stats:
	if test ! -d docs/stats; then mkdir -p docs/stats; fi
	utils/$(OS)/wof-stats-counts -pretty -custom 'properties.sfomuseum:placetype' -out docs/stats/counts.json ./
	utils/$(OS)/wof-stats-du -pretty > docs/stats/diskusage.json ./
