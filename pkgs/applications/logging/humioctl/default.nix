{ buildGoModule, fetchFromGitHub, installShellFiles, lib }:

let
  humioCtlVersion = "0.28.4";
  sha256 = "sha256-X2pc15InfCzVbZ2fmBdr+GKgOySIruA1yD61HcLO164=";
  vendorSha256 = "sha256-867x33Aq27D2m14NqqsdByC39pjjyJZbfX3jmwVU2yo=";
in buildGoModule {
    name = "humioctl-${humioCtlVersion}";
    pname = "humioctl";
    version = humioCtlVersion;

    vendorSha256 = vendorSha256;

    doCheck = false;

    src = fetchFromGitHub {
      owner = "humio";
      repo = "cli";
      rev = "v${humioCtlVersion}";
      sha256 = sha256;
    };

    buildFlagsArray = "-ldflags=-X main.version=${humioCtlVersion}";

    nativeBuildInputs = [ installShellFiles ];

    postInstall = ''
      $out/bin/humioctl completion bash > humioctl.bash
      $out/bin/humioctl completion zsh > humioctl.zsh
      installShellCompletion humioctl.{bash,zsh}
    '';

    meta = with lib; {
      homepage = "https://github.com/humio/cli";
      description = "A CLI for managing and sending data to Humio";
      license = licenses.asl20;
      maintainers = with maintainers; [ lucperkins ];
    };
  }
