{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "ayu_dark";

      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };

      editor.indent-guides = {
        render = true;
        character = "|";
        skip-levels = 1;
      };

    };

    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];

  };

  # Packages for Helix to work
  home.packages = with pkgs; [ nixfmt-rfc-style ];
}
