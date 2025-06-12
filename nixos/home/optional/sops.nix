{
  inputs,
  meta,
  ...
}: let
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];
  sops = {
    age.keyFile = "/home/max/.config/sops/age/keys.txt";
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "private_keys/${meta.hostname}" = {
        path = "/home/max/.ssh/id_${meta.hostname}";
      };
    };
  };
  # home.file.".ssh/id_${meta.hostname}.pub" = {
  #   source = ../../modules/keys/id_${meta.hostname}.pub;
  # };
}
