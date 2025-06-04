# NOTE: THIS IS ON A SYSTEM / HOSTLEVEL
# (for the home / user level see home/sops.nix)
{
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = ../secrets.yaml;
    validateSopsFiles = false;

    age = {
      # imports SSH keys as age keys
      sshKeyPaths = ["etc/ssh/ssh_host_ed25519_key"];
      # this expects an age key to be present
      keyFile = "var/lib/sops-nix/key.txt";
      # generates new key if the key above does not exist
      generateKey = true;
    };
    # secrets will be output to /run/secrets
    secrets = {
    };
  };
}
