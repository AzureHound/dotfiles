{
  mkShellNoCC,
  gitMinimal,
  just,
  sops,
  treefmt-wrapped,
}:

mkShellNoCC {
  name = "dotfiles";

  packages = [
    gitMinimal
    just
    sops
    treefmt-wrapped
  ]
  ++ treefmt-wrapped.runtimeInputs;

  env.DIRENV_LOG_FORMAT = "";

  meta.description = "Development shell";
}
