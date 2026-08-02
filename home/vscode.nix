{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-python.vscode-pylance
        ms-python.debugpy
        charliermarsh.ruff
        ms-toolsai.jupyter
      ];

      userSettings = {
        "editor.formatOnSave" = true;
        "editor.tabSize" = 4;
        "files.autoSave" = "afterDelay";

        "terminal.integrated.defaultProfile.linux" = "fish";

        "python.analysis.typeCheckingMode" = "basic";
        "python.analysis.autoImportCompletions" = true;

        "[python]" = {
          "editor.defaultFormatter" = "charliermarsh.ruff";
          "editor.formatOnSave" = true;
        };

        "notebook.lineNumbers" = "on";
      };
    };
  };

  home.packages = with pkgs; [
    python3
    ruff
    black
    python313Packages.virtualenv
  ];
}