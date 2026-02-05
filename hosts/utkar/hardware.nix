{pkgs, ...}: {
  hardware = {
    intelgpu.vaapiDriver = "intel-media-driver";
    intel-gpu-tools = {
      enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      package = pkgs.mesa;
      extraPackages = with pkgs; [intel-media-driver mesa mesa_glu mesa-gl-headers mesa];
      # extraPackages32 = with pkgs.pkgsi686Linux; [intel-media-driver intel-vaapi-driver mesa_i686];
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
