{ config }:
{
  # This function accepts a directory containing a repo directory containing config files.
  # It needs the path twice since the relative path used by `readDir` must be a path type,
  # while the absolute path used by `mkOutOfStoreSymlink` must be a string to avoid copying
  # the config to the store.
  # What's happening:
  #  - readDir reads all the subdirs from the passed `configsPath` into a set like:
  # { dirname1 = path; dirname2 = path; } etc.
  # - attrNames creates a list of just the dirNames
  # - map applies the `mkSymlink` function to the list, which returns:
  #   a list of sets, each set containing the attributes name, value.source for a config dir.
  # - Finally, listToAttrs takes a list of attr sets with the attrs being name, value.
  # [
  #   {
  #     name = "kitty";
  #     value = {
  #       source = "/home/kev/NixOS/home/dot-config/kitty";
  #     };
  #   }
  #   {
  #     name = "helix";
  #     value = {
  #       source = "/home/kev/NixOS/home/dot-config/helix";
  #     };
  #   }
  # ]
  #
  # It constructs an attr set using name,value from the list. In this case, the attr set
  # is in the format xdg.configFile is expecting:
  # {
  #   kitty = {
  #     source = "/home/kev/NixOS/home/dot-config/kitty";
  #   };
  #   helix = {
  #     source = "/home/kev/NixOS/home/dot-config/helix";
  #   };
  # }

  configSymlinks =
    configsPath: configsAbsolutePath:
    let
      inherit (config.lib.file) mkOutOfStoreSymlink;

      mkSymlink = name: {
        name = name;
        value.source = mkOutOfStoreSymlink "${configsAbsolutePath}/${name}";
      };
    in
    builtins.listToAttrs (map mkSymlink (builtins.attrNames (builtins.readDir configsPath)));
}
