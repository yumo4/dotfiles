{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnumake
    jq
    # c
    clang-tools
    gcc

    # go
    go
    go-migrate
    gofumpt
    goimports-reviser
    golines
    gopls
    gotools

    # java
    google-java-format
    java-language-server
    jdt-language-server
    zulu

    # js/ts
    bun
    nodePackages.jsdoc
    nodejs_22
    prettier
    prettierd
    typescript
    typescript-language-server
    astro-language-server
    vue-language-server
    oxfmt
    oxlint

    # nix
    alejandra
    nil
    nixd

    # html/css
    jsbeautifier
    stylelint
    tailwindcss
    tailwindcss-language-server
    vscode-langservers-extracted

    # lua
    lua
    lua-language-server
    luajit
    luajitPackages.luarocks
    stylua

    # python
    python3
    pyright

    # rust
    cargo

    # php
    # intelephense
    php
    php84Packages.composer
    php84Packages.php-cs-fixer
    phpactor
    phpdocumentor
    pretty-php

    # sql
    sqls
  ];
}
