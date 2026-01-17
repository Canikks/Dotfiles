{...}: {
  hardware = {
    intelgpu.vaapiDriver = "intel-media-driver";
    graphics = {
      enable = true;
      enable32Bit = true;
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
