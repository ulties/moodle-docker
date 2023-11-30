#!/bin/bash

# Set permissions for moodledata
chown -R www-data:www-data /var/www/moodledata

# Then execute the command provided as arguments to the script
exec "$@"
