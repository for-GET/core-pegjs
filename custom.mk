# Setup
SOURCES := $(wildcard src/**/*.pegjs)
PEG := $(patsubst src%, lib%, $(SOURCES))
PEGjs := $(PEG:.pegjs=.js)

# PHONY
.PHONY: all pegs js clean prepublish custom.mk

all: pegs
	@$(MAKE) -f .coffee.mk/coffee.mk $@

prepublish: clean all

pegs: $(PEG)

js: $(PEGjs)

clean:
	@rm -f $(PEG) $(PEGjs)
	@$(MAKE) -f .coffee.mk/coffee.mk $@

custom.mk:
	@:

# Non PHONY
$(PEG): $(1)

$(PEGjs): $(1)

src/%.pegjs: ;

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
