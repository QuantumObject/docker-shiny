# docker-shiny

Docker container for [shiny server 1.5.9.923][3]

"A web application framework for R"

"Turn your analyses into interactive web applications"

Shiny server: use to host and manage shiny application (R - powered web application)

## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 18.04 use the commands:

    $ sudo apt-get update
    $ sudo wget -qO- https://get.docker.com/ | sh

 To install docker in other operating systems check [docker online documentation][4]

## Usage

To run container use the command below:

    $ docker run -d -p 3838:3838 quantumobject/docker-shiny

To run the container with your own Shiny applications located in a directory on
your system, expose that directory path to the Shiny server inside the container:

    $ docker run -d -p 3838:3838 -v <LOCAL DIRECTORY PATH>:/srv/shiny-server quantumobject/docker-shiny

When modified or adding files  to \<LOCAL DIRECTORY PATH\> you need to restart the container to allow it to change the files to the right ownership and permission.  

## Accessing the Shiny Server applications:

After that check with your browser at addresses plus the port 3838 :

  - **http://host_ip:3838/**

To access it , configured and edit files inside of the container :

    $ docker exec -it container-id /bin/bash

note : it was created by using quantumobject/docker-baseimage and installing the package R and Shiny-server from rstudio.com . RStudio is a trademark of RStudio, Inc.

## More Info

About Shiny Server: [shiny.rstudio.com][1]

To help improve this container [docker-shiny][5]

Shiny Server [Administrator's Guide][6]

Example of [Shiny Server][7]

For additional info about us and our projects check our site [www.quantumobject.org][8]

[1]:http://shiny.rstudio.com
[2]:https://www.docker.com
[3]:http://www.rstudio.com/products/shiny/download-server
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-shiny
[6]:http://rstudio.github.io/shiny-server/latest
[7]:http://shiny.quantumobject.org
[8]:http://www.quantumobject.org
