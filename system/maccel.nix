{
  pkgs,
  ...
}:
{
  hardware.maccel = {
    enable = true;
    enableCli = true;
    parameters = {
      mode = "no_accel";
      yxRatio = 1.0;
      inputDpi = 1100.0;
      angleRotation = 4.0;
      sensMultiplier = 1.0;
    };
  };
}
