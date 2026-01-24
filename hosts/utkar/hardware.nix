{pkgs, ...}: {
  hardware = {
    intelgpu.vaapiDriver = "intel-media-driver";
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [intel-media-driver intel-ocl intel-vaapi-driver mesa];
    };
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = false;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = false;
        };
      };
    };
  };
}
