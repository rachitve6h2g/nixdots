{ inputs, ... }:
{
  flake.homeModules.noctalia =
    { pkgs, ... }:
    let
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rachitve6h2g/Wallpapers/main/Shinchan.png";
        hash = "sha256-CP9uGyslZ19wCaglMb1UG+NmcU/GxN5HDXSdrO5jAlw=";
      };
    in
    {
      imports = [ inputs.noctalia.homeModules.default ];

      home = {
        file.".face".source = image;
        packages = [
          pkgs.mission-center # For a system monitor
          pkgs.kdePackages.qttools # For kdeconnect plugin
          # Use it to just see the diff and move the differences here.
          (pkgs.writeShellScriptBin "noctalia-diff" ''
            nix shell nixpkgs#jq nixpkgs#colordiff \
            -c bash -c "colordiff -u --nobanner \
            <(jq -S . ~/.config/noctalia/settings.json) \
            <(noctalia-shell ipc call state all | jq -S .settings)"
          '')
        ];
      };

      programs.noctalia-shell = {
        enable = true;
        systemd.enable = true;

        # Plugins
        plugins = {
          sources = [
            {
              enabled = true;
              name = "Official Noctalia Plugins";
              url = "https://github.com/noctalia-dev/noctalia-plugins";
            }
          ];
          states = {
            niri-overview-launcher = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
            pomodoro = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
            kde-connect = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
          };
        };

        pluginSettings = {
          pomodoro = {
            autoStartBreaks = true;
            autoStartWork = true;
            compactMode = true;
            longBreakDuration = 15;
            playSound = true;
            sessionsBeforeLongBreak = 4;
            shortBreakDuration = 5;
            workDuration = 25;
          };
        };

        # Settings
        settings = {
          appLauncher = {
            autoPasteClipboard = false;
            clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
            clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
            clipboardWrapText = true;
            customLaunchPrefix = "";
            customLaunchPrefixEnabled = false;
            density = "default";
            enableClipPreview = true;
            enableClipboardHistory = true;
            enableSessionSearch = true;
            enableSettingsSearch = true;
            enableWindowsSearch = true;
            iconMode = "tabler";
            ignoreMouseInput = false;
            overviewLayer = false;
            pinnedApps = [ ];
            position = "center";
            screenshotAnnotationTool = "";
            showCategories = true;
            showIconBackground = false;
            sortByMostUsed = true;
            terminalCommand = "kitty -e";
            useApp2Unit = false;
            viewMode = "list";
          };

          audio = {
            cavaFrameRate = 30;
            mprisBlacklist = [ ];
            preferredPlayer = "";
            visualizerType = "wave";
            volumeFeedback = true;
            volumeOverdrive = false;
            volumeStep = 5;
          };

          controlCenter = {
            shortcuts = {
              right = [
                { id = "Notifications"; }
                { id = "NightLight"; }
              ];

              left = [
                { id = "WallpaperSelector"; }
                { id = "NoctaliaPerformance"; }
              ];
            };
          };

          bar = {
            autoHideDelay = 500;
            autoShowDelay = 150;
            # backgroundOpacity = 1;   # Stylix Manages it
            barType = "simple";
            capsuleColorKey = "none";
            # capsuleOpacity = 1;
            density = "mini";
            displayMode = "always_visible";
            floating = false;
            frameRadius = 12;
            frameThickness = 8;
            hideOnOverview = false;
            marginHorizontal = 4;
            marginVertical = 4;
            monitors = [ ];
            outerCorners = true;
            position = "right";
            screenOverrides = [ ];
            showCapsule = false;
            showOutline = false;
            useSeparateOpacity = false;

            general = {
              avatarImage = "/home/krish/.face";
              radiusRatio = 0.2;
              lockScreenAnimations = true;
              clockFormat = "hh\\nmm";
              clockStyle = "digital";
              animationDisabled = false;
            };

            dock = {
              colorizeIcons = true;
            };

            widgets = {
              center = [
                {
                  characterCount = 2;
                  colorizeIcons = true;
                  emptyColor = "secondary";
                  enableScrollWheel = true;
                  focusedColor = "primary";
                  followFocusedScreen = false;
                  groupedBorderOpacity = 1;
                  hideUnoccupied = true;
                  iconScale = 0.8;
                  id = "Workspace";
                  labelMode = "none";
                  occupiedColor = "secondary";
                  pillSize = 0.6;
                  showApplications = false;
                  showBadge = true;
                  showLabelsOnlyWhenOccupied = true;
                  unfocusedIconsOpacity = 1;
                }

                {
                  id = "KeepAwake";
                }
              ];

              left = [
                {
                  colorizeDistroLogo = false;
                  colorizeSystemIcon = "none";
                  customIconPath = "";
                  enableColorization = false;
                  icon = "noctalia";
                  id = "ControlCenter";
                  useDistroLogo = true;
                }
                {
                  id = "Network";
                  displayMode = "onhover";
                  iconColor = "none";
                  textColor = "none";
                }
                {
                  id = "Bluetooth";
                  displayMode = "onhover";
                  iconColor = "none";
                  textColor = "none";
                }
                { id = "Volume"; }
                { id = "NotificationHistory"; }
              ];

              right = [
                {
                  alwaysShowPercentage = false;
                  deviceNativePath = "__default__";
                  displayMode = "graphic-clean";
                  hideIfIdle = false;
                  hideIfNotDetected = true;
                  id = "Battery";
                  showNoctaliaPerformance = true;
                  warningThreshold = 40;
                  showPowerProfiles = false;
                }
                {
                  clockColor = "none";
                  customFont = "";
                  formatHorizontal = "hh:mm A";
                  formatVertical = "hh mm A";
                  id = "Clock";
                  useMonospacedFont = true;
                  usePrimaryColor = true;
                  tooltipFormat = "hh:mm A ddd, MMM dd";
                  useCustomFont = false;
                }

                { id = "plugin:pomodoro"; }

                { id = "plugin:kde-connect"; }
              ];
            };
          };

          brightness = {
            brightnessStep = 5;
            enableDdcSupport = false;
            enforceMinimum = true;
          };

          location = {
            analogClockInCalendar = false;
            name = "Kolkata";
            showWeekNumberInCalendar = true;
            weatherEnabled = false;
          };

          calendar = {
            cards = [
              {
                enabled = true;
                id = "calendar-header-card";
              }
              {
                enabled = true;
                id = "calendar-month-card";
              }
              {
                enabled = true;
                id = "weather-card";
              }
            ];
          };

          colorSchemes = {
            darkMode = true;
            generationMethod = "tonal-spot";
            manualSunrise = "06:30";
            manualSunset = "18:30";
            monitorForColors = "";
            predefinedScheme = "Noctalia (default)";
            schedulingMode = "off";
            useWallpaperColors = false;
          };

          dock = {
            animationSpeed = 1;
            # backgroundOpacity = 1;   # Stylix Manages it
            colorizeIcons = false;
            deadOpacity = 0.6;
            displayMode = "auto_hide";
            enabled = true;
            floatingRatio = 1;
            inactiveIndicators = false;
            monitors = [ ];
            onlySameOutput = true;
            pinnedApps = [ ];
            pinnedStatic = false;
            position = "bottom";
            size = 1;
          };

          ui = {
            bluetoothDetailsViewMode = "grid";
            bluetoothHideUnnamedDevices = false;
            boxBorderEnabled = false;
            fontDefaultScale = 1;
            fontFixedScale = 1;
            networkPanelView = "wifi";
            panelsAttachedToBar = true;
            settingsPanelMode = "attached";
            tooltipsEnabled = true;
            wifiDetailsViewMode = "grid";
          };

          notifications = {
            saveToHistory = {
              critical = true;
              low = true;
              normal = true;
            };
            sounds = {
              criticalSoundFile = "";
              enabled = true;
              excludedApps = "discord,firefox,chrome,chromium,edge";
              lowSoundFile = "";
              normalSoundFile = "";
              separateSounds = true;
              volume = 0.5;
            };
            criticalUrgencyDuration = 15;
            density = "default";
            enableBatteryToast = true;
            enableKeyboardLayoutToast = true;
            clearDismissed = true;
            enableMediaToast = false;
            enabled = true;
            location = "top_right";
            lowUrgencyDuration = 3;
            monitors = [ ];
            normalUrgencyDuration = 8;
            overlayLayer = true;
            respectExpireTimeout = false;
          };

          nightLight = {
            enabled = true;
          };

          osd = {
            autoHideMs = 2000;
            # backgroundOpacity = 0.9; # stylix value
            enabled = true;
            enabledTypes = [
              0
              1
              2
            ];
            location = "top_right";
            monitors = [ ];
            overlayLayer = true;
          };

          settingsVersion = 53;
        };
      };
    };
}
