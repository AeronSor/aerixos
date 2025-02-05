{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    let

      # Rstudio Libraries
      RStudio-with-my-packages = rstudioWrapper.override {
        packages = with rPackages; [
          dplyr
          tidyr
          stringr
          lubridate
          httr
          ggvis
          ggplot2
          shiny
          rio
          rmarkdown
          tidyverse
          EnvStats
        ];
      };

    in [
      #Overrides
      RStudio-with-my-packages

      # Base
      wget
      git
      alsa-utils
      networkmanagerapplet
      dunst
      mtpfs
      jmtpfs
      wireplumber
      gcc
      fuse
      ntfs3g
      lxqt.lxqt-policykit
      ripgrep

      # Utils
      lshw
      bcc
      p7zip
      zip
      unzip
      unrar
    ];
}
