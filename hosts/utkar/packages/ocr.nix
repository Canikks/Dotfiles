{pkgs, lib, config, ...}: {
     ocrScreenshot = pkgs.writeShellScriptBin "ocr-screenshot" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    dms screenshot | tesseract stdin stdout | dms cl copy
  '';
}
