# directories
base_dir := $(CURDIR)
test_dir := $(base_dir)/tests
build_dir := $(base_dir)/build
# node_modules executables
elm_bin := elm
elm_test := elm-test
elm_analyse := elm-analyse

# TODO add analyse
all: docs test

.PHONY: docs
docs :
	@mkdir -p $(build_dir)
	@$(elm_bin) make --docs=$(build_dir)/documentation.json

.PHONY: test
test :
	@$(elm_test)

.PHONY: analyse
analyse :
	@$(elm_analyse)

.PHONY: clean
clean :
	@rm -rf elm-stuff $(build_dir)
