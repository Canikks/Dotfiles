{pkgs, ...}: {
  hardware = {
    # --- General ---
    ksm.enable = true;
    enableRedistributableFirmware = true;

    # --- GPU & Graphics ---
    intelgpu = {
      vaapiDriver = "intel-media-driver";
      computeRuntime = "legacy";
      enableHybridCodec = true;
      loadInInitrd = true;
    };
    intel-gpu-tools.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      package = pkgs.mesa;
      package32 = pkgs.pkgsi686Linux.mesa;
      extraPackages = with pkgs; [
        intel-media-driver
        mesa
        mesa_glu
        mesa-gl-headers
        vpl-gpu-rt
      ];
    };

    # --- CPU ---
    cpu.intel.sgx = {
      enableDcapCompat = true;
      provision.enable = true;
    };

    # --- Bluetooth ---
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
          KernelExperimental = true;
        };
        Policy = {
          AutoEnable = false;
        };
      };
    };
  };
}
