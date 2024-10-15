{ config, pkgs, lib, ... }:
  
{ 
  # DO NOT CHANGE
  home.stateVersion = "23.05"; 
 
  home.username = "a125x";
  #

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
    ];

  home.packages = with pkgs; [
    cowsay
    fortune
    yabai
    eza
    gh
    kitty
    skhd
    tree
    ncdu
    neofetch
    neovim 
    bottom
    inconsolata-lgc
    bat
    discord
    toipe
    sketchybar
    ninja
    cmake
    lazygit
    yarn
    nerdfonts
    yazi
    ffmpegthumbnailer
    jq
    poppler
    fd
    #rg
    fzf
    zoxide
    xclip
    #(nerdfonts.override { fonts = [ "Inconsolata LGC Nerd Font" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
 ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  
  # You can also manage environment variables but you will have to manually
  # source
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  #  /etc/profiles/per-user/a125x/etc/profile.d/hm-session-vars.sh

  programs.git = {
    enable = true;
    userName = "a125x";
    userEmail = "alexander.andr.shat@gmail.com";
    aliases = {
      prettylog = "...";
    };
    extraConfig = {
      core = {
        editor = "nvim";
      };
      color = {
        ui = true;
      };
      push = {
        default = "simple";
      };
      pull = {
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
    };
    ignores = [
      ".DS_Store"
      "*.pyc"
    ];
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./.zshrc;
  };

  programs.fzf = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
