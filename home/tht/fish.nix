{pkgs, ...}: {
  home.packages = with pkgs; [
    grc
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      ${pkgs.starship}/bin/starship init fish | source
      function help
        ${pkgs.curl}/bin/curl cheat.sh/$argv | ${pkgs.less}/bin/less
      end
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
    ];
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -la";
      cat = "${pkgs.bat}/bin/bat --paging=never";
      cp = "${pkgs.xcp}/bin/xcp";
      #rm = "${pkgs.fuc}/bin/rmz";
      glow = "${pkgs.glow}/bin/glow --pager";
      htop = "${pkgs.bottom}/bin/btm --basic --tree --hide_table_gap --dot_marker --mem_as_value";
      ip = "${pkgs.iproute2}/bin/ip --color --brief";
      less = "${pkgs.bat}/bin/bat";
      dmesg = "${pkgs.util-linux}/bin/dmesg --human --color=always";
      tree = "${pkgs.eza}/bin/eza --tree";
      ping = "${pkgs.gping}/bin/gping";
      ask = "${pkgs.tgpt}/bin/tgpt";
    };
  };
}
