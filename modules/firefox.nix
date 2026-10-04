{
  # Persoonlijke Firefox-configuratie en policies.
  programs.firefox = {
    enable = true;

    # Taal
    languagePacks = [ "nl" ];

    policies = {
      # Opstarten en onboarding
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;

      # Locales
      RequestedLocales = [
        "nl"
        "en-US"
      ];

      # Homepage
      Homepage = {
        URL = "https://studio.bitsoft.nl";
        Locked = true;
      };

      FirefoxHome = {
        Locked = true;
        Weather = false;
        SponsoredTopSites = false;
        SponsoredStories = false;
        Stories = false;
      };

      # Aanbevelingen en suggesties
      UserMessaging = {
        Locked = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
      };

      FirefoxSuggest = {
        Locked = true;
        WebSuggestions = false;
        SponsoredSuggestions = false;
        OnlineEnabled = false;
      };

      # Privacy en beveiliging
      DisableTelemetry = true;
      DisableFirefoxStudies = true;

      EnableTrackingProtection = {
        Value = true;
        Locked = false;
        Cryptomining = true;
        Fingerprinting = true;
      };

      HttpsOnlyMode = "enabled";
      IPProtectionAvailable = false;

      # Wachtwoorden
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;

      # AI en vertalingen
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

      Preferences = {
        "browser.translations.neverTranslateLanguages" = {
          Value = "en";
          Status = "locked";
        };
      };

      # Zoekmachines
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

      # Extensies
      ExtensionSettings = {
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };

        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };
    };
  };
}
