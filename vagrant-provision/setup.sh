#!/bin/bash

if [ ! -d /vagrant/drupal ]; then
    echo "installing drupal 8, please wait...."
    composer create-project drupal-composer/drupal-project:8.x-dev /vagrant/drupal --no-interaction
    echo "done installing drupal, please open your browser on http://localhost"
fi
