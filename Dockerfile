FROM rocker/verse:4.5.0
WORKDIR /home/rstudio
RUN apt-get update -y && apt-get install -y rsync
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
RUN R -e "renv::restore()"
