PROJECT := reprocollab
WORKDIR := $(CURDIR)

.PHONY: renv

renv:
	Rscript -e "renv::restore()"

publish/:
	mkdir -p $@
	cp -r $^ $@

publish/:  self-paced/ assets/ shiny/

self-paced/: self-paced-source/ renv
	Rscript -e "bookdown::render_book('self-paced-source')"

shiny/: steven/app.R renv
	Rscript -e "shinylive::export(appdir = 'steven', destdir = 'shiny')"

