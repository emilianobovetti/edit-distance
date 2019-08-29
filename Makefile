# directories
build_dir := build
node_bin := node_modules/.bin
# target files
docs_target := $(build_dir)/documentation.json
# node_modules executables
elm_bin := $(node_bin)/elm
elm_test := $(node_bin)/elm-test
elm_analyse := $(node_bin)/elm-analyse

.PHONY: all test analyse clean

all: $(docs_target) analyse test

$(build_dir) :
	mkdir -p $(build_dir)

$(node_bin) :
	yarn

$(docs_target) : $(build_dir) $(node_bin)
	$(elm_bin) make --docs=$(docs_target)

test : $(node_bin)
	$(elm_test)

analyse : $(node_bin)
	$(elm_analyse)

clean :
	rm -rf node_modules elm-stuff $(build_dir)
