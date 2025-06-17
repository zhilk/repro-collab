FROM rocker/verse:4.5.0
WORKDIR /home/rstudio
RUN apt-get update -y && apt-get install -y rsync
RUN mkdir -p renv
COPY renv.lock /home/rstudio/renv.lock
COPY .Rprofile /home/rstudio/.Rprofile
COPY renv/activate.R /home/rstudio/renv/activate.R
COPY renv/settings.json /home/rstudio/renv/settings.json
RUN R -e "renv::restore()"
