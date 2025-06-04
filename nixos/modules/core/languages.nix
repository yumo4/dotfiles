{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # c
    gcc

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
    zulu

    # js/ts
    typescript-language-server
    nodejs_22
    prettierd

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
    # luajitPackages.lua-lsp
    luajitPackages.luarocks
    stylua

    # python
    python3

    # rust
    cargo

    # php
    php
  ];
}
