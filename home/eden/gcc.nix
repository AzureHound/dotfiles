{ config, ... }:

{
  programs.gcc = {
    inherit (config.pixel.profiles.development) enable;

    colors = {
      error = "01;38;2;237;135;150";
      warning = "01;38;2;238;212;159";
      note = "01;38;2;138;173;244";
      caret = "01;38;2;166;218;149";
      locus = "01;38;2;202;211;245";
      quote = "01;38;2;244;219;214";
    };
  };
}
