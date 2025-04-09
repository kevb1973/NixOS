{
  inputs,
  pkgs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [inputs.spicetify-nix.nixosModules.spicetify];
  programs.spicetify = {
    enable = true;
    experimentalFeatures = true;
    enabledExtensions = with spicePkgs.extensions; [
      beautifulLyrics
      betterGenres
      fullAlbumDate
      hidePodcasts
      keyboardShortcut
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
    # theme = spicePkgs.themes.hazy;
  };
}
