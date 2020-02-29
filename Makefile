lsc := npx lsc
lsfiles := $(wildcard *.ls)
uglify = npx uglifyjs $(1) -c -m -o $(1)

start: serve watch
	npx http-server & $(lsc) -wc $(lsfiles)

compile:
	$(lsc) -c $(lsfiles)

minify:
	$(foreach jsfile,$(wildcard *.js),$(call uglify,$(jsfile));)

build: compile minify

.PHONY:  start serve watch compile minify
