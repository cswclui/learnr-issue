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
    && Rscript -e "remotes::install_github(c('rstudio/learnr', 'rstudio-education/gradethis','rundel/learnrhash'))" \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds


RUN Rscript -e "remotes::install_github(c('OpenIntroStat/openintro'))" \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

ADD . /srv/shiny-server

RUN sudo chown -R shiny /srv/shiny-server

RUN useradd vlab && mkdir /home/vlab && chown -R vlab /home/vlab

ADD shiny-server.conf /etc/shiny-server/ 
