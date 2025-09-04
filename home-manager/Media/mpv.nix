{
  lib,
  pkgs,
  ...
}:
{
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv-unwrapped.wrapper {
        # If using the 'package' option,
        # Must use the scripts option inside the wrapper function
        # Not outside.
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
          mpris
          thumbfast
        ];
        mpv = pkgs.mpv-unwrapped.override {
          bluraySupport = false;
          x11Support = false;
          waylandSupport = true;
          vdpauSupport = false;
          dvdnavSupport = false;
          ffmpeg = pkgs.ffmpeg-full;
        };
      }
    );

    config = {
      save-position-on-quit = true;
      ytdl-format = "bestvideo+bestaudio";
      sub-auto = "fuzzy";
      sub-visibility = false;
      sub-file-paths-append = "ass:srt:sub:subs:subtitles";

      video-sync = "display-resample";
      interpolation = true;
      profile = "gpu-hq";
      vo = "gpu";
      hwdec = "auto-safe";
      gpu-api = "vulkan";

      input-ipc-server = "/tmp/mpv.sock";

      audio-file-auto = "fuzzy";

      # UOSC integration
      osd-bar = false;
      border = false;

      # term-osd-bar = true;
      screenshot-template = "~/Downloads/%{filename/no-ext}/%P";

      osd-duration = 2500;

      cursor-autohide = 1000;
      cursor-autohide-fs-only = true;
    };

    scriptOpts = {
      uosc = {
        # this is from uosc.conf
        # see https://github.com/tomasklaen/uosc/releases/latest/download/uosc.conf
        timeline_style = "line";
        timeline_line_width = 2;
        timeline_size = 40;
        timeline_persistency = "paused";
        timeline_border = 1;
        timeline_step = 5;
        timeline_cache = true;

        progress = "windowed";
        progress_size = 2;
        progress_line_width = 20;

        controls = lib.concatStrings [
          "menu,"
          "gap,"
          "<video,audio>subtitles,"
          "<has_many_audio>audio,"
          "<has_many_video>video,"
          "<has_many_editions>editions,"
          "<stream>stream-quality,"
          "gap,"
          "space,"
          "<video,audio>speed,"
          "space,"
          "shuffle,"
          "loop-playlist,"
          "loop-file,"
          "gap,"
          "prev,"
          "items,"
          "next,"
          "gap,"
          "fullscreen"
        ];
        controls_size = 32;
        controls_margin = 8;
        controls_spacing = 2;
        controls_persistency = "paused";

        volume = "right";
        volume_size = 40;
        volume_border = 1;
        volume_step = 1;
        # volume_persistency is not set

        speed_step = 0.1;
        speed_step_is_factor = false;
        # speed_persistency is not set

        menu_item_height = 36;
        menu_min_width = 260;
        menu_padding = 4;

        menu_type_to_search = true;

        top_bar = "border";
        top_bar_size = 40;
        top_bar_controls = "right";
        top_bar_title = true;
        # top_bar_alt_title is not set
        top_bar_alt_title_place = "below";
        top_bar_flash_on = "video,audio";
        #top_bar_persistency is not set

        window_border_size = 1;

        autoload = false;
        shuffle = false;

        scale = 1;
        scale_fullscreen = 1.3;
        font_scale = 1;
        text_border = 1.2;
        border_radius = 4;
        # color is not set
        # opacity is not set
        # refine is not set
        animation_duration = 100;
        flash_duration = 100;
        proximity_in = 40;
        proximity_out = 120;
        font_bold = false;
        destination_time = "playtime-remaining";
        time_precision = 0;
        buffered_time_threshold = 60;
        autohide = false;
        pause_indicator = "flash";
        stream_quality_options = lib.concatStrings [
          "4320,"
          "2160,"
          "1440,"
          "1080,"
          "720,"
          "480,"
          "360,"
          "240,"
          "144"
        ];

        video_types = lib.concatStrings [
          "3g2,"
          "3gp,"
          "asf,"
          "avi,"
          "f4v,"
          "flv,"
          "h264,"
          "m2ts,"
          "m4v,"
          "mkv,"
          "mov,"
          "mp4,"
          "mp4v,"
          "mpeg,"
          "mpg,"
          "ogm,"
          "ogv,"
          "rm,"
          "rmvb,"
          "ts,"
          "vob,"
          "webm,"
          "wmv,"
          "y4m"
        ];

        audio_types = lib.concatStrings [
          "aac,"
          "ac3,"
          "aiff,"
          "ape,"
          "au,"
          "cue,"
          "dsf,"
          "dts,"
          "flac,"
          "m4a,"
          "mid,"
          "midi,"
          "mka,"
          "mp3,"
          "mp4a,"
          "oga,"
          "ogg,"
          "opus,"
          "spx,"
          "tak,"
          "tta,"
          "wav,"
          "weba,"
          "wma,"
          "wv"
        ];

        image_types = lib.concatStrings [
          "apng,"
          "avif,"
          "bmp,"
          "gif,"
          "j2k,"
          "jp2,"
          "jfif,"
          "jpeg,"
          "jpg,"
          "jxl,"
          "mj2,"
          "png,"
          "svg,"
          "tga,"
          "tif,"
          "tiff,"
          "webp"
        ];

        subtitle_types = lib.concatStrings [
          "aqt,"
          "ass,"
          "gsub,"
          "idx,"
          "jss,"
          "lrc,"
          "mks,"
          "pgs,"
          "pjs,"
          "psb,"
          "rt,"
          "sbv,"
          "slt,"
          "smi,"
          "sub,"
          "sup,"
          "srt,"
          "ssa,"
          "ssf,"
          "ttxt,"
          "txt,"
          "usf,"
          "vt,"
          "vtt"
        ];

        playlist_types = lib.concatStrings [
          "m3u,"
          "m3u8,"
          "pls,"
          "url,"
          "cue"
        ];

        load_types = "video,audio,image";

        default_directory = "~/";
        show_hidden_files = false;
        use_trash = true;
        adjust_osd_margins = true;

        chapter_ranges = "openings:30abf964,endings:30abf964,ads:c54e4e80";
        chapter_range_patterns = "openings:オープニング;endings:エンディング";

        languages = "slang,en";
        subtitles_directory = "~~/subtitles";

        # disable_elements is not set
      };
    };
  };
}
