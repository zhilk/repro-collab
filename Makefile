PROJECT := reprocollab
WORKDIR := $(CURDIR)

.PHONY: renv

renv:
	Rscript -e "renv::restore()"

publish/:
	mkdir -p $@
	cp -r $^ $@

publish/:  self-paced/ assets/ steven/ presentation.html xaringan-themer.css

presentation.html: presentation.Rmd
	Rscript -e 'rmarkdown::render("$<", "all")'

self-paced/: self-paced-source/ renv
	Rscript -e "bookdown::render_book('self-paced-source')"

steven/: steven-source/app.R renv
	Rscript -e "shinylive::export(appdir = 'steven-source', destdir = 'steven')"

