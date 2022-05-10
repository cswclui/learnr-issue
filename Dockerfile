FROM rocker/shiny-verse


RUN apt-get update && apt-get install -y \
    libssl-dev \
    git \
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/ \ 
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
    
RUN install2.r --error \ 
    -r 'http://cran.rstudio.com' \
    remotes \
    NHANES \
    && Rscript -e "remotes::install_github(c('rstudio/learnr', 'rstudio-education/gradethis'))" \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

ADD sample.Rmd /srv/shiny-server

RUN sudo chown -R shiny /srv/shiny-server

