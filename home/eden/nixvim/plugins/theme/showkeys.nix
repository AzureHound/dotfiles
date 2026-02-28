{ pkgs, ... }:

{
  extraPlugins = [ pkgs.vimPlugins.showkeys ];

  extraConfigLua = ''
    require('lz.n').load({
      "showkeys",
      cmd = { "ShowkeysToggle" },
    })
  '';
}
