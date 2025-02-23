flake:
{ config, lib, pkgs, ... }:

let
  inherit (lib)
    all filterAttrs hasAttr isStorePath literalExpression optional optionalAttrs
    types;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.modules) mkIf mkMerge;

  cfg = config.programs.network_manager_ui;
in {
    options.programs.network_manager_ui = {
        enable = mkEnableOption "network_manager_ui";

        rofiPkg = mkOption {
            type = types.package;
            example = literalExpression "pkgs.wofi";
            default = pkgs.rofi;
            description = ''
            Which 'rofi' to use e.g. rofi, rofi-wayland
            '';
            apply = val: lib.getExe val;
        };

        dmenu = {
            pinentry = mkOption {
                type = types.package;
                example = literalExpression "pkgs.pinentry-rofi";
                default = pkgs.pinentry-rofi;
                description = ''
                    Which pinentry interface to use.
                '';
                # we want the program in the config
                apply = val: lib.getExe val;
            };
        };

        pinentry.prompt = mkOption {
            type = types.str;
            default = "Password:";
            description = "Pinentry prompt"; 
        };

        editor.terminal = mkOption {
            type = types.str;
            default = "${pkgs.kitty}/bin/kitty";
            description = "Default terminal to run.";
            example = "alacritty";
        };
    };

    config = lib.mkIf cfg.enable {
        xdg.configFile."networkmanager/config.ini".text = pkgs.lib.generators.toINI {} {
            dmenu = {
                dmenu_command = "${cfg.rofiPkg} -dmenu -theme ${./wifi}/config.rasi -i -no-history -matching fuzzy -no-tokenize -hover-select";

                pinentry = cfg.dmenu.pinentry;
                wifi_icons = "󰤯󰤟󰤢󰤥󰤨";
                format = "{name} {icon}";
                list_saved = "False";
            };

            pinentry = {
                prompt = cfg.pinentry.prompt;
            };

            editor = {
                terminal = cfg.editor.terminal;
            };
        };

        home.packages = [ flake.packages.${pkgs.stdenv.system}.network_manager_ui ];
    };
}