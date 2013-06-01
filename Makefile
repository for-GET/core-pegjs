SOURCES := $(wildcard src/*/*.pegjs)
PEG := $(patsubst src%, lib%, $(SOURCES))
PEGjs := $(PEG:.pegjs=.js)

.PHONY: all pegs js clean prepublish

all: index.js pegs

index.js: index.coffee
	@$(eval input := $<)
	coffee -c $(input)

pegs: $(PEG)

js: $(PEGjs)

$(PEG): $(1)

$(PEGjs): $(1)

lib/%.pegjs: src/%.pegjs
	@$(eval input := $<)
	@$(eval output := $@)
	@mkdir -p `dirname $(output)`
	@cat `bin/tree.sh $(input) src/` > $(output)

lib/%.js: lib/%.pegjs
	@$(eval input := $<)
	@$(eval output := $@)
	@mkdir -p `dirname $(output)`
	@pegjs $(input) $(output)

clean:
	@rm -f  $(PEG) $(PEGjs)

prepublish: clean all
