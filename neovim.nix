{ pkgs }:
let
  plugins = import ./plugins.nix { inherit pkgs; };
  runtimeDeps = import ./runtimeDeps.nix { inherit pkgs; };

  neovimNpmDeps = pkgs.symlinkJoin {
    name = "neovimNpmDeps";
    paths = runtimeDeps.nodeDeps;
  };
  neovimRootDeps = pkgs.symlinkJoin {
    name = "neovimRootDeps";
    paths = runtimeDeps.rootDeps;
  };

  myNeovimUnwrapped = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      enable = true;
      withNodeJs = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraLuaConfig = builtins.readFile ./nvim_settings.lua;
      packages.all.start = plugins;
    };
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ neovimNpmDeps neovimRootDeps ];
  text = ''
    ${myNeovimUnwrapped}/bin/nvim "$@"
  '';
}
