{
  pkgs,
  ...
}:
{
  hardware.maccel = {
    enable = true;
    enableCli = true;
    parameters = {
      mode = "linear";
      sensMultiplier = 1.0;
      acceleration = 0.3;
      offset = 2.0;
      outputCap = 2.0;
    };
  };
}
