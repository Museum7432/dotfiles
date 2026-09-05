# generate secrets in /persist/<user> folder, will ignore if file already exist
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
  dir = "/persist/secrets/${user}";
  loginPw = "${dir}/login-hash";
  keyringPw = "${dir}/keyring-password";
in
{
  system.activationScripts.bootstrap_secrets = {
    deps = [ "specialfs" ];
    text = ''
      install -d -m 0711 -o 0 -g 0 ${dir}


      pw_file=${dir}/login-hash

      if [ ! -s $pw_file ]; then
        echo 'test' \
          | ${pkgs.mkpasswd}/bin/mkpasswd -m sha-512 -s > $pw_file
        chown 0:0 $pw_file
        chmod 0600 $pw_file
      fi

      keyring_pw_file=${dir}/keyring-password
      if [ ! -s $keyring_pw_file ]; then
        ${pkgs.openssl}/bin/openssl rand -base64 48 | tr -d '\n' > $keyring_pw_file
        chown 0:${user_id} $keyring_pw_file
        chmod 0440 $keyring_pw_file
      fi

      # storing credentials for restic
      restic_env_file=${dir}/restic.env
      if [ ! -s $restic_env_file ]; then

        # echo "# restic env placeholder file" > $restic_env_file

        echo -e "# placeholder file\nexport AWS_ACCESS_KEY_ID=\nexport AWS_SECRET_ACCESS_KEY=\nexport RESTIC_REPOSITORY=\nexport RESTIC_PASSWORD=" > $restic_env_file
        chown 0:${user_id} $restic_env_file
        chmod 0440 $restic_env_file
      fi
    '';
  };

  users.users.${user}.hashedPasswordFile = loginPw;

  system.activationScripts.users.deps = [ "bootstrap_secrets" ];
}
