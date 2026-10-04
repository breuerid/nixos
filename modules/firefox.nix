{
  #
  programs.firefox = {
    enable = true;
    languagePacks = [ "nl" ];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;

      EnableTrackingProtection = {
        Value = true;
        Locked = false;
        Cryptomining = true;
        Fingerprinting = true;
      };
      FirefoxHome = {
        Weather = false;
        SponsoredTopSites = false;
        SponsoredStories = false;
        Stories = false;
        Locked = true;
      };

      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        OnlineEnabled = false;
        Locked = true;
      };

      RequestedLocales = [
        "nl"
        "en-US"
      ];
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;

      # Bitwarden bewaard logins
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      #HTTPS Standaard, maar uitzonderingen blijven mogelijk
      HttpsOnlyMode = "enabled";

      IPProtectionAvailable = false;
      AIControls = {
        Default = {
          Value = "blocked";
          Locked = true;
        };
        Translations = {
          Value = "available";
          Locked = false;
        };
      };

      #Minder aanbevelingen en mozilla promites
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = false;
      };

      Preferences = {
        "browser.translations.neverTranslateLanguages" = {
          Value = "en";
          Status = "locked";
        };
      };

      Homepage = {
        URL = "https://studio.bitsoft.nl";
        Locked = true;
      };

      SearchEngines = {
        Default = "Startpage";
        Remove = [
          "Google"
          "Bing"
          "Perplexity"
          "Ecosia"
          "Qwant"
          "eBay"
          "Wikipedia (en)"
        ];
      };

      ExtensionSettings = {
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };
    };
  };
}
