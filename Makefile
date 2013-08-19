all: update

preview:
	jekyll build && jekyll serve --watch

update:
	jekyll build && \
	git add .; \
	git commit -am "site update $$(date +%Y-%m-%d)"; \
	git push origin gh-pages

