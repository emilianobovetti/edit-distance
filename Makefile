# directories
base_dir := $(CURDIR)
test_dir := $(base_dir)/tests
node_dir := $(base_dir)/node_modules
node_bin := $(node_dir)/.bin
build_dir := $(base_dir)/build
examples_dir := $(base_dir)/examples
# node_modules executables
elm_bin := $(build_dir)/elm
elm_test := $(node_bin)/elm-test
elm_analyse := $(node_bin)/elm-analyse

define stripname
	$(notdir $(basename $(1)))
endef

examples := $(call stripname,$(wildcard $(examples_dir)/*.elm))

all: docs test analyse examples

.PHONY: yarn-check
yarn-check :
ifeq ("$(wildcard $(node_bin))", "")
	@yarn
endif

.PHONY: docs
docs : yarn-check
	@mkdir -p $(build_dir)
	@$(elm_bin) make --docs=$(build_dir)/documentation.json

.PHONY: test
test : yarn-check
	@$(elm_test) --compiler $(node_dir)/elm/binwrappers/elm-make

.PHONY: analyse
analyse : yarn-check
	@$(elm_analyse) --elm-format-path $(node_dir)/elm-format/bin/elm-format

%.html :
	@cd $(examples_dir) && $(elm_bin) make $(call stripname,$@).elm --output=$@

.PHONY: examples
examples : yarn-check
	@mkdir -p $(build_dir)
	@rm -f $(build_dir)/*.html
	@make $(addsuffix '.html',$(addprefix $(build_dir)/,$(examples)))

.PHONY: clean
clean :
	@rm -rf elm-stuff $(node_dir) $(build_dir)
