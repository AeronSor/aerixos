{ config, lib, pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [
    # Nerd fonts
    nerd-fonts.terminess-ttf

    noto-fonts-cjk-serif
    hackgen-nf-font
    ipafont
    kochi-substitute
    source-code-pro
    dejavu_fonts
  ];
}
