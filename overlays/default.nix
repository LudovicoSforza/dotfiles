# This file defines overlays
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      patchPhase = ''
        substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"hyprctl dispatch workspace \" + name_; system(command.c_str());"
      '';
    });
    ungoogled-chromium = prev.ungoogled-chromium.override {
      commandLineArgs = toString [
        # Ungoogled features
        "--disable-search-engine-collection"
        "--extension-mime-request-handling=always-prompt-for-install"
        "--fingerprinting-canvas-image-data-noise"
        "--fingerprinting-canvas-measuretext-noise"
        "--fingerprinting-client-rects-noise"
        "--popups-to-tabs"
        "--show-avatar-button=incognito-and-guest"

        # Experimental features
        "--enable-features=${
          final.lib.concatStringsSep "," [
            "BackForwardCache:enable_same_site/true"
            "CopyLinkToText"
            "OverlayScrollbar"
            "TabHoverCardImages"
            "VaapiVideoDecoder"
          ]
        }"

        # Aesthetics
        "--force-dark-mode"

        # Performance
        "--enable-gpu-rasterization"
        "--enable-oop-rasterization"
        "--enable-zero-copy"
        "--ignore-gpu-blocklist"
      ];
    };
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
}
