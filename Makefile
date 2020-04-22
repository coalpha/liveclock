lsc := npx lsc

lsfiles := $(wildcard src/*.ls)
cssfiles := $(wildcard src/*.css)

jsfiles = $(wildcard dist/*.js)

start:
	npx http-server & $(lsc) -cwo dist $(lsfiles)

compile:
	$(lsc) -co dist $(lsfiles)

minify-js:
	$(foreach jsfile,$(jsfiles),npx uglifyjs $(jsfile) -cmo $(jsfile);)

minify-css:
	$(foreach cssfile,$(cssfiles),npx uglifycss $(cssfile) --output dist/$(notdir $(cssfile));)

minify: minify-js minify-css

release: compile minify

.PHONY: start compile minify
