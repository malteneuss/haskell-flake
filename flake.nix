{
  description = "A `flake-parts` module for Haskell development";
  outputs = { ... }: {
    flakeModule = ./nix/modules;

    templates.default = {
      description = "A simple flake.nix using haskell-flake";
      path = builtins.path { path = ./example; filter = path: _: baseNameOf path == "flake.nix"; };
    };
    templates.example = {
      description = "Example Haskell project using haskell-flake";
      path = builtins.path { path = ./example; filter = path: _: baseNameOf path != "test.sh"; };
    };

    # https://github.com/srid/nixci
    nixci = let overrideInputs = { "haskell-flake" = ./.; }; in {
      dev.dir = "dev";
      example = { inherit overrideInputs; dir = "example"; };
    };
  };
}
