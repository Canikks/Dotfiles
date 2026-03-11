{pkgs, ...}: {
  hardware = {
    intelgpu.vaapiDriver = "intel-media-driver";
    # intelgpu.mediaRuntime = "intel-media-sdk";
    intelgpu.computeRuntime = "legacy";
    intelgpu.enableHybridCodec = true;
    cpu.intel.sgx = {
      enableDcapCompat = true;
      provision.enable = true;
    };
    intel-gpu-tools = {
      enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      package = pkgs.mesa;
      package32 = pkgs.pkgsi686Linux.mesa;
      extraPackages = with pkgs; [intel-media-driver mesa mesa_glu mesa-gl-headers mesa];
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
