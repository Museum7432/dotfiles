# generate secrets in /nix/persist/<user> folder, will ignore if file already exist
# default user password is "test", change it after boot
# default gnome keyring password is random (just cat it after boot).
# gnome_keyring.nix will use this file to unlock on startup
# (this only add security if you do full disk encrytion and need to backup the keyrings, don't store this file in the same backup)
# I use ssd's hardware encrytion, so luks configs are not included here.

# check /run/current-system/activate on the boot system, the bootstrap_secrets snippet should be before the users snippet but after specialfs for this to work

{ config, lib, pkgs, ... }:
let
  user = "arch";
  user_id = "1000";
  dir = "/nix/persist/secrets/${user}";
  loginPw = "${dir}/login-hash";
  keyringPw = "${dir}/keyring-password";
in
{
  system.activationScripts.bootstrap_secrets = {
    deps = [ "specialfs" ];
    text = ''
      install -d -m 0711 -o 0 -g 0 ${dir}

      if [ ! -s ${loginPw} ]; then
        echo 'test' \
          | ${pkgs.mkpasswd}/bin/mkpasswd -m sha-512 -s > ${loginPw}
        chown 0:0 ${loginPw}
        chmod 0600 ${loginPw}
      fi

      if [ ! -s ${keyringPw} ]; then
        ${pkgs.openssl}/bin/openssl rand -base64 48 | tr -d '\n' > ${keyringPw}
        chown 0:${user_id} ${keyringPw}
        chmod 0440 ${keyringPw}
      fi
    '';
  };

  users.users.${user}.hashedPasswordFile = loginPw;

  system.activationScripts.users.deps = [ "bootstrap_secrets" ];
}
