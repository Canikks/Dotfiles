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

  # --- Chaotic Mesa Git ---
  chaotic = {
    mesa-git.enable = true;
    mesa-git.extraPackages = with pkgs; [mesa_git.opencl libdrm_git intel-media-driver intel-ocl intel-vaapi-driver];
    mesa-git.extraPackages32 = with pkgs.pkgsi686Linux; [pkgs.mesa32_git.opencl libdrm32_git intel-media-driver intel-vaapi-driver];
  };
}
