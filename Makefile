REPORTER = $(if $(CI),spec,dot)

build: node_modules/
	node_modules/.bin/rollup -c
	node_modules/.bin/rollup -c rollup.legacy-config.js

test: node_modules/ build lint
	./node_modules/phantomjs-prebuilt/bin/phantomjs ./node_modules/mocha-phantomjs-core/mocha-phantomjs-core.js \
		./test/test.html $(REPORTER) '{"useColors":true}'

lint: node_modules/
	./node_modules/.bin/eslint src/ test/

node_modules/:
	npm install

clean:
	rm -rf ./dist ./node_modules

.PHONY: build clean lint test
