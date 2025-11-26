{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
      mangohud
      mesa-demos
    ];
    programs.mangohud = {
        enable = true;
        enableSessionWide = true;
        settingsPerApplication = {
          mpv = {
            no_display = true;
          };
        };
        settings = {
          no_display = true; # Hide hud by default (Show by holding right-shift then press F12)
          fps_limit = [0 100 144 165 240];
          fps_limit_method = "early"; # early = low input lag and cpu usage but less smooth, late = more smooth
          # testing for gl_vsync: 1.045

          # keybinds
          toggle_hud = "Shift_R+F12";
          # toggle_hud_position="Shift_R+F11";
          toggle_fps_limit = "Shift_R+F1";
          # toggle_logging="Shift_L+F2";
          # reload_cfg="Shift_L+F4";
          # upload_log="Shift_L+F3";

          # SYSTEM
          fps = true;
          show_fps_limit = true;
          frametime = true;
          frame_timing = true;
          present_mode = true;
          core_load = false;
          ram = true;
          # swap
          # core_load_change

          # CPU
          cpu_stats = true;
          cpu_temp = true;
          cpu_power = true;
          cpu_text = "CPU";
          cpu_mhz = true;

          # GPU
          throttling_status = true;
          gpu_stats = true;
          gpu_temp = true;
          gpu_core_clock = true;
          gpu_mem_clock = true;
          gpu_power = true;
          gpu_text = "GPU";
          vram = true;
          # gpu_load_change
          # gpu_load_value=60,90
          # gpu_load_color=39F900,FDFD09,B22222
        };
      };
}