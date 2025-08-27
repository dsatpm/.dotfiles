#!/usr/bin/env bash
set -euo pipefail

composer --version >/dev/null

# Ensure global config and key tools
composer global config --no-interaction allow-plugins.dealerdirect/phpcodesniffer-composer-installer true
composer global require --no-interaction \
  drush/drush:^13 \
  wp-coding-standards/wpcs:^3 \
  drupal/coder:^8 \
  phpstan/phpstan:^1 \
  mglaman/phpstan-drupal:^1 \
  szepeviktor/phpstan-wordpress:^1

COMPOSER_HOME="$(composer config --global home)"
PHPCS_BIN="$COMPOSER_HOME/vendor/bin/phpcs"
if [ -x "$PHPCS_BIN" ]; then
  "$PHPCS_BIN" --config-set installed_paths \
    "$COMPOSER_HOME/vendor/wp-coding-standards/wpcs", \
    "$COMPOSER_HOME/vendor/drupal/coder/code_sniffer"
fi

echo "Composer global packages installed successfully. PHPCS standards linked."
