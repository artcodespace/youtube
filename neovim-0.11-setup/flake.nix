{
  description = "neovim-0.11-setup flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = inputs: let
    # Define some variables to make handling platform specifics easier.
    linux = {
      displayName = "linux";
      architecture = "x86_64-linux";
    };
    mac = {
      displayName = "mac";
      architecture = "aarch64-darwin";
    };

    # Helper function. Call it with one of the above objects.
    # It will call the system specific`buildEnv` function with a name
    # reflecting the profile being built and system specific packages.
    buildPackage = {
      displayName,
      architecture,
    } @ platform: let
      pkgs = inputs.nixpkgs.legacyPackages.${architecture};
    in {
      default = pkgs.buildEnv {
        name = "neovim-0.11-setup-nix-profile-" + displayName;
        paths = with pkgs;
          [
            neovim
            fzf
            nodejs_22
            typescript
            nodePackages.typescript-language-server
            prettierd
          ]
          ++ (
            # NOTE there is pkgs.stdenv.isDarwin
            if platform == mac
            then
              # MAC SPECIFIC
              []
            else []
          )
          ++ (
            # NOTE there is pkgs.stdenv.isLinux
            if platform == linux
            then
              # LINUX SPECIFIC
              [zig]
            else []
          );
      };
    };
  in {
    packages = {
      ${linux.architecture} = buildPackage linux;
      ${mac.architecture} = buildPackage mac;
    };
  };
}
