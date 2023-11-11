{ pkgs }:
{
  nodeDeps = with pkgs.nodePackages; [
    typescript-language-server
    prettier
  ];
  rootDeps = with pkgs; [
    lazygit
    shfmt
    typescript
    lua-language-server
    rnix-lsp
    vscode-langservers-extracted
    rust-analyzer
  ];
}
