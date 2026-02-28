{ config, ... }:

{
  users.users.root = {
    inherit (config.users.users.${config.pixel.system.mainUser}) hashedPassword;
  };
}
