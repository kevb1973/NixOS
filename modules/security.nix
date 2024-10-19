_:
{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.extraRules = [
      {
        users = [ "kev" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
