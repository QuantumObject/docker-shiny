#name of container: docker-shiny
#version of container: 0.8
FROM quantumobject/docker-baseimage:20.04
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

# Update the container
# Installation of necessary packages/software for this container...
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q --no-install-recommends r-base  \
                    r-base-dev lsb-release \
                    gdebi-core \  
                    libapparmor1 \
                    sudo \
                    libssl1.1 \
                    libcurl4-openssl-dev \
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*
                    
RUN R -e "install.packages(c('shiny','rmarkdown'), repos='http://cran.rstudio.com/', clean=TRUE)" \
          && update-locale  \
          && wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.16.958-amd64.deb \
          && dpkg -i --force-depends shiny-server-1.5.16.958-amd64.deb \
          && rm shiny-server-1.5.16.958-amd64.deb \
          && mkdir -p  /srv/shiny-server/examples; sync \
          && cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/examples/. 
          
##startup scripts  
#Pre-config scrip that may be needed to be run one time only when the container run the first time .. using a flag to don't 
#run it again ... use for conf for service ... when run the first time ...
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

##Adding daemons to containers
RUN mkdir /etc/service/shiny-server ; sync 
COPY shiny-server.sh /etc/service/shiny-server/run
RUN chmod +x /etc/service/shiny-server/run  \
    && cp /var/log/cron/config /var/log/shiny-server/ \
    && chown -R shiny /var/log/shiny-server \
    && sed -i '113 a <h2><a href="./examples/">Other examples of Shiny application</a> </h2>' /srv/shiny-server/index.html \
    && mkdir -p /var/backup ; sync \
    && cp -Rp /srv/shiny-server  /var/backup
     
#volume for Shiny Apps and static assets. Here is the folder for index.html (link) and sample apps.
VOLUME /srv/shiny-server

# to allow access from outside of the container to the container service
# at the ports to allow access from firewall if accessing from outside the server. 
EXPOSE 3838

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
