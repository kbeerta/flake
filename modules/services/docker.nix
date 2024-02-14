{ lib, pkgs, user, ... }: with lib; {
  virtualisation.docker.enable = true;

  users.groups.docker.members = [ "${user}" ];

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
}

