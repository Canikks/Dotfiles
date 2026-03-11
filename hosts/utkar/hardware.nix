{pkgs, ...}: {
  hardware = {
    facter.reportPath = ./facter.json;
    intelgpu.vaapiDriver = "intel-media-driver";
    intelgpu.computeRuntime = "legacy";
    intelgpu.enableHybridCodec = true;
    intelgpu = {
      loadInInitrd = true;
    };
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
      extraPackages = with pkgs; [intel-media-driver mesa mesa_glu mesa-gl-headers mesa vpl-gpu-rt];
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
