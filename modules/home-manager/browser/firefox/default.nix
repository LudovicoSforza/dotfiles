{ pkgs, ... }: {
  home.file = {
    ".mozilla/firefox/ludovico/chrome/includes" = {
      source = ./includes;
      recursive = true;
    };
  };

  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      bitwarden
      fastforward
    ];
    profiles.ludovico = {
      id = 0;
      isDefault = true;
      name = "Ludovico";
      bookmarks = [
        {
          name = "ANIME"; # Bookmark Folder
          bookmarks = [
            {
              name = "ANIMEPAHE";
              url = "https://animepahe.com";
            }
            {
              name = "KICKASSANIME";
              url = "https://kickassanime.ro";
            }
            {
              name = "9Anime";
              url = "https://9anime.gs";
            }
          ];
        }
        {
          name = "NixOS";
          bookmarks = [
            {
              name = "Nix Package";
              url = "https://search.nixos.org/packages?channel=unstable";
            }
            {
              name = "Nix Options";
              url = "https://search.nixos.org/options?channel=unstable";
            }
            {
              name = "Home-Manager";
              url = "https://rycee.gitlab.io/home-manager/options.html";
            }
          ];
        }
      ];
      search = {
        default = "DuckDuckGo";
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Home-Manager" = {
            urls = [
              {
                template = "https://rycee.gitlab.io/home-manager/options.html";
              }
            ];
            definedAliases = [ "@hm" ];
          };
          "NixOS Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };

          "NixOS Wiki" = {
            urls = [
              {
                template = "https://nixos.wiki/index.php?search={searchTerms}";
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nw" ];
          };
        };
      };
      settings = {
        "browser.search.region" = "AU";
        "browser.search.isUS" = false;
        "distribution.searchplugins.defaultLocale" = "en-AU";
        "general.useragent.locale" = "en-AU";
        "browser.bookmarks.showMobileBookmarks" = true;
      };
      userChrome = ''
        @import 'includes/cascade-config.css';
        @import 'includes/cascade-macchiato.css';

        @import 'includes/cascade-layout.css';
        @import 'includes/cascade-responsive.css';
        @import 'includes/cascade-floating-panel.css';

        @import 'includes/cascade-tcr.css';
        @import 'includes/cascade-nav-bar.css';

        #webrtcIndicator {
          display: none !important;
        }'';
      userContent = ''
        @import url("userChrome.css");

        /* Removes white loading page */
        @-moz-document url(about:blank), url(about:newtab), url(about:home) {
            html:not(#ublock0-epicker), html:not(#ublock0-epicker) body, #newtab-customize-overlay {
              background: var(--mff-bg) !important;
            }
          }
          /* Hide scrollbar */
          :root{
            scrollbar-width: none !important;
          }
          @-moz-document url(about:privatebrowsing) {
          :root{
            scrollbar-width: none !important;
          }
          }'';
    };
  };
}
