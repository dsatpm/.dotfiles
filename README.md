# Dotfiles (Drupal & WordPress) – macOS (Apple Silicon)

Tools: Homebrew, Lando, PHP 8.x, Composer, WP-CLI, PHPCS (Drupal + WPCS), PHPStan (+ Drupal + WP extensions), Node (fnm), Prettier, Starship.

## Quick start

1. Review `Brewfile` and `scripts/*` to fit your needs.
2. Install everything:
   brew bundle --file="$HOME/dotfiles/Brewfile"
   "$HOME/dotfiles/scripts/node-setup.zsh"
   "$HOME/dotfiles/scripts/composer-global.sh"
3. Link shell/editor:
   ln -sf "$HOME/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
   ln -sf "$HOME/dotfiles/node/.editorconfig" "$HOME/.editorconfig"

## Project usage

- Drupal PHPCS: cp php/phpcs-drupal.xml ./phpcs.xml
- WP PHPCS: cp php/phpcs-wordpress.xml ./phpcs.xml
- PHPStan: cp php/phpstan.neon ./phpstan.neon
- JS formatting (themes/plugins): copy `node/.prettierrc` into your project.

## Lando

- Drupal: copy lando/drupal9.lando.yml to project as `.lando.yml`
- WordPress: copy lando/wordpress.lando.yml to project as `.lando.yml`

## Notes

- Global Composer cache/config/vendor should not live in this repo. Use `scripts/composer-global.sh` to install global tools (Drush, PHPCS standards, PHPStan + extensions).
- ESLint config for React has been removed intentionally. If you need React in a specific project, manage it within that project only.
