all: update

preview:
	jekyll build && jekyll serve --watch --host=172.16.121.110

update:
	jekyll build && \
	git checkout gh-pages
	git add .; \
	git commit -am "site update $$(date +%Y-%m-%d)"; \
	git push origin gh-pages

