# NOTE: THIS IS ON A SYSTEM / HOSTLEVEL
# (for the home / user level see home/optional/sops.nix)
{
  inputs,
  config,
  meta,
  ...
}: let
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    # NOTE: this "enables" decrypting/encryipting
    age = {
      # imports SSH keys as age keys
      sshKeyPaths = ["etc/ssh/ssh_host_ed25519_key"];
      # this expects an age key to be present
      keyFile = "var/lib/sops-nix/key.txt";
      # generates new key if the key above does not exist
      generateKey = true;
    };
    # secrets will be output to /run/secrets
    # secrets = {
    # "duckdns-env" = {};
    # "duckdns-token" = {};
    # };
  };
}
