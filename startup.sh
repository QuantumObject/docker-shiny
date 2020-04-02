#!/bin/bash

set -e

#in case Volume are empty
if [ "$(ls -A /srv/shiny-server)" ]; then
    echo "shiny-server folder with data"    
else
    cp -Rp /var/backup/shiny-server/* /srv/shiny-server/ 
fi


if [ -f /etc/configured ]; then
        echo 'already configured'
else
      #code that need to run only one time ....
      chown -R shiny:shiny /srv/shiny-server
      chown -R shiny:shiny /var/lib/shiny-server
        
        #needed for fix problem with ubuntu and cron
        update-locale 
        date > /etc/configured
fi
