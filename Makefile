PROJECT := reprocollab
WORKDIR := $(CURDIR)

publish/:
	mkdir -p $@
	cp -r $^ $@

publish/:  self-paced/

self-paced/: self-paced-source/
	Rscript -e "bookdown::render_book('self-paced-source')"


