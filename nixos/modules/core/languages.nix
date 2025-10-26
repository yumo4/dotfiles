{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnumake
    # c
    gcc
    clang-tools

    # go
    go
    go-migrate
    gofumpt
    goimports-reviser
    golines
    gotools
    gopls

    # java
    java-language-server
    google-java-format
    jdt-language-server
    zulu

    # js/ts
    typescript-language-server
    nodejs_22
    prettierd
    prettier
    bun

    # nix
    alejandra
    nil
    nixd

    # html/css
    tailwindcss
    tailwindcss-language-server
    stylelint
    jsbeautifier
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
    php
    # intelephense
    php84Packages.composer
    phpactor
    php84Packages.php-cs-fixer
    pretty-php

    # qml
    # qt6.full
  ];
}
