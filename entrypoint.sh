#!/bin/bash

# Your custom command
chown -R www-data:www-data /var/www/moodledata

# Execute the default entrypoint of the base image
exec docker-php-entrypoint "$@"
