{ pkgs, self, ... }:
let
  inherit (self) theme;
  wallpaper = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/mix/Powerline.png";
    hash = "sha256-pXlwsQrcfIXFMoLBAvViaStQY/BozRuLHLgxoAbu0SI=";
  };
  wallpaper2 = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/gruvbox_astro.jpg";
    hash = "sha256-YTxyI+vaC5CGQzqMm1enfPh9/1YoqNXAX7TmAscz1U0=";
  };
  wallpaperDir = pkgs.runCommand "wallpaper-dir" { } ''
    mkdir -p $out
    cp ${wallpaper} $out
    cp ${wallpaper2} $out
  '';
in
{
  appLauncher = {
    autoPasteClipboard = false;
    clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
    clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
    clipboardWrapText = true;
    customLaunchPrefix = "";
    customLaunchPrefixEnabled = false;
    density = "comfortable";
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
    terminalCommand = "wezterm -e";
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
  bar = {
    autoHideDelay = 500;
    autoShowDelay = 150;
    backgroundOpacity = 0.9;
    barType = "simple";
    capsuleColorKey = "none";
    capsuleOpacity = 0.9;
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
    position = "bottom";
    screenOverrides = [ ];
    showCapsule = false;
    showOutline = false;
    useSeparateOpacity = false;
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
          iconColor = "none";
          id = "KeepAwake";
          textColor = "none";
        }
        {
          compactMode = true;
          diskPath = "/";
          iconColor = "none";
          id = "SystemMonitor";
          showCpuFreq = true;
          showCpuTemp = true;
          showCpuUsage = true;
          showDiskAvailable = false;
          showDiskUsage = false;
          showDiskUsageAsPercent = false;
          showGpuTemp = true;
          showLoadAverage = true;
          showMemoryAsPercent = true;
          showMemoryUsage = true;
          showNetworkStats = false;
          showSwapUsage = false;
          textColor = "none";
          useMonospaceFont = true;
          usePadding = true;
        }
        {
          compactMode = true;
          compactShowAlbumArt = true;
          compactShowVisualizer = false;
          hideMode = "hidden";
          hideWhenIdle = false;
          id = "MediaMini";
          maxWidth = 145;
          panelShowAlbumArt = true;
          panelShowVisualizer = true;
          scrollingMode = "hover";
          showAlbumArt = true;
          showArtistFirst = true;
          showProgressRing = true;
          showVisualizer = true;
          textColor = "none";
          useFixedWidth = false;
          visualizerType = "wave";
        }
      ];
      right = [
        {
          displayMode = "onhover";
          iconColor = "none";
          id = "Network";
          textColor = "none";
        }
        {
          displayMode = "onhover";
          iconColor = "none";
          id = "Bluetooth";
          textColor = "none";
        }
        {
          displayMode = "onhover";
          iconColor = "none";
          id = "Volume";
          middleClickCommand = "pwvucontrol || pavucontrol";
          textColor = "none";
        }
        {
          hideWhenZero = false;
          hideWhenZeroUnread = false;
          iconColor = "none";
          id = "NotificationHistory";
          showUnreadBadge = true;
          unreadBadgeColor = "primary";
        }
        {
          deviceNativePath = "__default__";
          displayMode = "graphic-clean";
          hideIfIdle = false;
          hideIfNotDetected = true;
          id = "Battery";
          showNoctaliaPerformance = true;
          showPowerProfiles = false;
        }
        {
          clockColor = "none";
          customFont = "";
          formatHorizontal = "hh:mm A";
          formatVertical = "hh mm A";
          id = "Clock";
          tooltipFormat = "hh:mm A ddd, MMM dd";
          useCustomFont = false;
        }
      ];
    };
  };
  brightness = {
    brightnessStep = 5;
    enableDdcSupport = false;
    enforceMinimum = true;
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
    predefinedScheme = "";
    schedulingMode = "off";
    useWallpaperColors = false;
  };
  controlCenter = {
    cards = [
      {
        enabled = true;
        id = "profile-card";
      }
      {
        enabled = true;
        id = "shortcuts-card";
      }
      {
        enabled = true;
        id = "audio-card";
      }
      {
        enabled = false;
        id = "brightness-card";
      }
      {
        enabled = true;
        id = "weather-card";
      }
      {
        enabled = true;
        id = "media-sysmon-card";
      }
    ];
    diskPath = "/";
    position = "close_to_bar_button";
    shortcuts = {
      left = [
        { id = "WallpaperSelector"; }
        { id = "NoctaliaPerformance"; }
      ];
      right = [
        { id = "Notifications"; }
        { id = "NightLight"; }
      ];
    };
  };
  desktopWidgets = {
    enabled = false;
    gridSnap = false;
    monitorWidgets = [ ];
  };
  dock = {
    animationSpeed = 1;
    backgroundOpacity = 0.9;
    colorizeIcons = true;
    deadOpacity = 0.6;
    displayMode = "auto_hide";
    dockType = "floating";
    enabled = true;
    floatingRatio = 1;
    inactiveIndicators = false;
    monitors = [ ];
    onlySameOutput = true;
    pinnedApps = [ ];
    pinnedStatic = false;
    position = "bottom";
    showFrameIndicator = true;
    sitOnFrame = false;
    size = 1;
  };
  general = {
    allowPanelsOnScreenWithoutBar = true;
    allowPasswordWithFprintd = false;
    animationDisabled = false;
    animationSpeed = 1;
    autoStartAuth = false;
    avatarImage = "/home/krish/.face";
    boxRadiusRatio = 1;
    clockFormat = "hh\\nmm";
    clockStyle = "digital";
    compactLockScreen = false;
    dimmerOpacity = 0.2;
    enableLockScreenCountdown = true;
    enableShadows = true;
    forceBlackScreenCorners = false;
    iRadiusRatio = 1;
    keybinds = {
      keyDown = [
        "Down"
        "Ctrl+N"
      ];
      keyEnter = [ "Return" ];
      keyEscape = [
        "Esc"
        "Ctrl+G"
      ];
      keyLeft = [
        "Left"
        "Ctrl+B"
      ];
      keyRemove = [ "Del" ];
      keyRight = [
        "Right"
        "Ctrl+F"
      ];
      keyUp = [
        "Up"
        "Ctrl+P"
      ];
    };
    language = "";
    lockOnSuspend = true;
    lockScreenAnimations = true;
    lockScreenBlur = 0;
    lockScreenCountdownDuration = 10000;
    lockScreenMonitors = [ ];
    lockScreenTint = 0;
    radiusRatio = 1;
    reverseScroll = false;
    scaleRatio = 1;
    screenRadiusRatio = 1;
    shadowDirection = "bottom_right";
    shadowOffsetX = 2;
    shadowOffsetY = 3;
    showChangelogOnStartup = true;
    showHibernateOnLockScreen = false;
    showScreenCorners = false;
    showSessionButtonsOnLockScreen = true;
    telemetryEnabled = false;
  };
  hooks = {
    darkModeChange = "";
    enabled = false;
    performanceModeDisabled = "";
    performanceModeEnabled = "";
    screenLock = "";
    screenUnlock = "";
    session = "";
    startup = "";
    wallpaperChange = "";
  };
  location = {
    analogClockInCalendar = false;
    firstDayOfWeek = -1;
    hideWeatherCityName = false;
    hideWeatherTimezone = false;
    name = "Kolkata";
    showCalendarEvents = true;
    showCalendarWeather = true;
    showWeekNumberInCalendar = true;
    use12hourFormat = true;
    useFahrenheit = false;
    weatherEnabled = false;
    weatherShowEffects = true;
  };
  network = {
    airplaneModeEnabled = false;
    bluetoothDetailsViewMode = "grid";
    bluetoothHideUnnamedDevices = false;
    bluetoothRssiPollIntervalMs = 60000;
    bluetoothRssiPollingEnabled = false;
    disableDiscoverability = false;
    wifiDetailsViewMode = "grid";
    wifiEnabled = true;
  };
  nightLight = {
    autoSchedule = false;
    dayTemp = "6500";
    enabled = true;
    forced = false;
    manualSunrise = "06:30";
    manualSunset = "18:30";
    nightTemp = "4000";
  };
  notifications = {
    backgroundOpacity = 0.9;
    clearDismissed = true;
    criticalUrgencyDuration = 15;
    density = "default";
    enableBatteryToast = true;
    enableKeyboardLayoutToast = true;
    enableMarkdown = false;
    enableMediaToast = false;
    enabled = true;
    location = "top_right";
    lowUrgencyDuration = 3;
    monitors = [ ];
    normalUrgencyDuration = 8;
    overlayLayer = true;
    respectExpireTimeout = false;
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
  };
  osd = {
    autoHideMs = 2000;
    backgroundOpacity = 0.9;
    enabled = true;
    enabledTypes = [
      0
      1
      2
      3
    ];
    location = "bottom";
    monitors = [ ];
    overlayLayer = true;
  };
  plugins = {
    autoUpdate = false;
  };
  sessionMenu = {
    countdownDuration = 10000;
    enableCountdown = true;
    largeButtonsLayout = "single-row";
    largeButtonsStyle = true;
    position = "center";
    powerOptions = [
      {
        action = "lock";
        enabled = true;
        keybind = "1";
      }
      {
        action = "suspend";
        enabled = true;
        keybind = "2";
      }
      {
        action = "hibernate";
        enabled = true;
        keybind = "3";
      }
      {
        action = "reboot";
        enabled = true;
        keybind = "4";
      }
      {
        action = "logout";
        enabled = true;
        keybind = "5";
      }
      {
        action = "shutdown";
        enabled = true;
        keybind = "6";
      }
      {
        action = "rebootToUefi";
        enabled = true;
      }
    ];
    showHeader = true;
    showKeybinds = true;
  };
  settingsVersion = 0;
  systemMonitor = {
    batteryCriticalThreshold = 5;
    batteryWarningThreshold = 20;
    cpuCriticalThreshold = 90;
    cpuWarningThreshold = 80;
    criticalColor = "";
    diskAvailCriticalThreshold = 10;
    diskAvailWarningThreshold = 20;
    diskCriticalThreshold = 90;
    diskWarningThreshold = 80;
    enableDgpuMonitoring = false;
    externalMonitor = "missioncenter";
    gpuCriticalThreshold = 90;
    gpuWarningThreshold = 80;
    memCriticalThreshold = 90;
    memWarningThreshold = 80;
    swapCriticalThreshold = 90;
    swapWarningThreshold = 80;
    tempCriticalThreshold = 90;
    tempWarningThreshold = 80;
    useCustomColors = false;
    warningColor = "";
  };
  templates = {
    activeTemplates = [ ];
    enableUserTheming = false;
  };
  ui = {
    bluetoothDetailsViewMode = "grid";
    bluetoothHideUnnamedDevices = false;
    boxBorderEnabled = false;
    fontDefault = "Maple Mono NF";
    fontDefaultScale = 1;
    fontFixed = "Maple Mono NF";
    fontFixedScale = 1;
    networkPanelView = "wifi";
    panelBackgroundOpacity = 0.9;
    panelsAttachedToBar = true;
    settingsPanelMode = "attached";
    tooltipsEnabled = true;
    wifiDetailsViewMode = "grid";
  };
  wallpaper = {
    automationEnabled = false;
    directory = wallpaperDir;
    enableMultiMonitorDirectories = false;
    enabled = true;
    favorites = [ ];
    fillColor = "#000000";
    fillMode = "crop";
    hideWallpaperFilenames = false;
    monitorDirectories = [ ];
    overviewBlur = 0.4;
    overviewEnabled = false;
    overviewTint = 0.6;
    panelPosition = "follow_bar";
    randomIntervalSec = 300;
    setWallpaperOnAllMonitors = true;
    showHiddenFiles = false;
    skipStartupTransition = false;
    solidColor = theme.base00;
    sortOrder = "date_desc";
    transitionDuration = 1500;
    transitionEdgeSmoothness = 0.05;
    transitionType = "random";
    useSolidColor = false;
    useWallhaven = false;
    viewMode = "single";
    wallhavenApiKey = "";
    wallhavenCategories = "111";
    wallhavenOrder = "desc";
    wallhavenPurity = "100";
    wallhavenQuery = "";
    wallhavenRatios = "";
    wallhavenResolutionHeight = "";
    wallhavenResolutionMode = "atleast";
    wallhavenResolutionWidth = "";
    wallhavenSorting = "relevance";
    wallpaperChangeMode = "random";
  };
}
