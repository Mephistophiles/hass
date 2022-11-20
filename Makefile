SOURCES = $(patsubst %.dhall,%.yaml,$(shell find . -name "*.dhall"))

all: $(SOURCES)

%.yaml: %.dhall
	dhall-to-yaml --file $< --output $(subst dhall/,,$@)

