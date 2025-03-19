{
  pkgs,
  inputs,
  ...
}: {
  #environment.systemPackages = [
  #  pkgs.stable.davinci-resolve
  #];
  # Enable openGL and install Rocm
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages_5.clr.icd
      rocmPackages_5.clr
      rocmPackages_5.rocminfo
      rocmPackages_5.rocm-runtime
    ];
  };
  # This is necesery because many programs hard-code the path to hip
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages_5.clr}"
  ];
  environment.variables = {
    # As of ROCm 4.5, AMD has disabled OpenCL on Polaris based cards. So this is needed if you have a 500 series card.
    ROC_ENABLE_PRE_VEGA = "1";
  };
}
