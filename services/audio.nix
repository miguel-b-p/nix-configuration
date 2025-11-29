{ config, pkgs, ... }:

{
  boot = {
    kernelModules = [
      "snd-seq"
      "snd-rawmidi"
    ];
    kernelParams = [ "threadirqs" ];
  };
  security.rtkit.enable = true;
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        configPackages = [
          (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/11-bluetooth-policy.conf" ''
            bluetooth.autoswitch-to-headset-profile = false
          '')
          (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/12-gaming-audio.conf" ''
            monitor.alsa.rules = [
              {
                matches = [
                  {
                    node.name = "~alsa_output.*"
                  }
                ]
                actions = {
                  update-props = {
                    audio.format = "S16LE"
                    audio.rate = 48000
                    api.alsa.period-size = 128
                    api.alsa.headroom = 1024
                    session.suspend-timeout-seconds = 0
                  }
                }
              }
            ]
          '')
        ];
      };
    };
  };
}
