{
  description = "cjnucette's neovim confguration flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    conform-src = {
      url = "github:stevearc/conform.nvim";
      flake = false;
    };

    oil-nvim-src = {
      url = "github:stevearc/oil.nvim";
      flake = false;
    };

    statuscol-nvim-src = {
      url = "github:luukvbaal/statuscol.nvim";
      flake = false;
    };

    nvim-ufo-src = {
      url = "github:kevinhwang91/nvim-ufo";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, neovim, ... }@inputs:
    let
      system = "x86_64-linux";

      nvimPluginsOverlay = prev: final: {
        neovim = neovim.packages.${system}.neovim;

        vimPlugins = final.vimPlugins // {
          oil-nvim = prev.vimUtils.buildVimPlugin {
            name = "oil-nvim";
            src = inputs.oil-nvim-src;
            dontBuild = true;
          };

          conform = prev.vimUtils.buildVimPlugin {
            name = "conform";
            src = inputs.conform-src;
            dontBuild = true;
          };

          statuscol-nvim = prev.vimUtils.buildVimPlugin {
            name = "statuscol-nvim";
            src = inputs.statuscol-nvim-src;
          };

          nvim-ufo = prev.vimUtils.buildVimPlugin {
            name = "nvim-ufo";
            src = inputs.nvim-ufo-src;
          };
        };
      };

      overlayNeovimIde = prev: final: {
        nvim-ide = import ./neovim.nix {
          pkgs = final;
        };
      };

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nvimPluginsOverlay overlayNeovimIde ];
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      packages.${system}.default = pkgs.nvim-ide;
      apps.${system}.default = {
        type = "app";
        program = "${pkgs.nvim-ide}/bin/nvim";
      };
    };
}
