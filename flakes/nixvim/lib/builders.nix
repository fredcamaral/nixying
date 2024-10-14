{ lib }:
# NOTE: use local recursion instead of accessing `lib.nixvim.builders`.
# The latter isn't a fixed shape since it may get the deprecated functions meregd in,
# which would lead to infinite recursion.
lib.fix (builders: {
  # Curry a nixpkgs instance into the *With functions below, dropping the `With` suffix
  withPkgs =
    pkgs:
    lib.concatMapAttrs (
      name: fn:
      let
        match' = builtins.match "(.*)With" name;
        name' = builtins.head match';
      in
      lib.optionalAttrs (match' != null) {
        ${name'} = fn pkgs;
      }
    ) builders;

  /*
    Write a lua file to the nix store, formatted using stylua.

    # Type

    ```
    writeLuaWith :: pkgs -> String -> String -> Derivation
    ```

    # Arguments

    - [pkgs] A nixpkgs instance
    - [name] The name of the derivation
    - [text] The content of the lua file
  */
  writeLuaWith =
    pkgs: name: text:
    pkgs.runCommand name { inherit text; } ''
      echo -n "$text" > "$out"

      ${lib.getExe pkgs.stylua} \
        --no-editorconfig \
        --line-endings Unix \
        --indent-type Spaces \
        --indent-width 4 \
        "$out"
    '';

  /*
    Write a byte compiled lua file to the nix store.

    # Type

    ```
    writeByteCompiledLuaWith :: pkgs -> String -> String -> Derivation
    ```

    # Arguments

    - [pkgs] A nixpkgs instance
    - [name] The name of the derivation
    - [text] The content of the lua file
  */
  writeByteCompiledLuaWith =
    pkgs: name: text:
    pkgs.runCommandLocal name { inherit text; } ''
      echo -n "$text" > "$out"

      ${lib.getExe' pkgs.luajit "luajit"} -bd -- "$out" "$out"
    '';

  /*
    Get a source lua file and write a byte compiled copy of it
    to the nix store.

    # Type

    ```
    byteCompileLuaFileWith :: pkgs -> String -> String -> Derivation
    ```

    # Arguments

    - [pkgs] A nixpkgs instance
    - [name] The name of the derivation
    - [src] The path to the source lua file
  */
  byteCompileLuaFileWith =
    pkgs: name: src:
    pkgs.runCommandLocal name { inherit src; } ''
      ${lib.getExe' pkgs.luajit "luajit"} -bd -- "$src" "$out"
    '';

  # Setup hook to byte compile all lua files in the output directory.
  # Invalid lua files are ignored.
  byteCompileLuaHookWith =
    pkgs:
    pkgs.makeSetupHook { name = "byte-compile-lua-hook"; } (
      let
        luajit = lib.getExe' pkgs.luajit "luajit";
      in
      pkgs.writeText "byte-compile-lua-hook.sh" # bash
        ''
          byteCompileLuaPostFixup() {
              # Target is a single file
              if [[ -f $out ]]; then
                  if [[ $out = *.lua ]]; then
                      tmp=$(mktemp)
                      ${luajit} -bd -- "$out" "$tmp"
                      mv "$tmp" "$out"
                  fi
                  return
              fi

              # Target is a directory
              while IFS= read -r -d "" file; do
                  tmp=$(mktemp -u "$file.XXXX")
                  # Ignore invalid lua files
                  if ${luajit} -bd -- "$file" "$tmp"; then
                      mv "$tmp" "$file"
                  else
                      echo "WARNING: Ignoring byte compiling error for '$file' lua file" >&2
                  fi
              done < <(find "$out" -type f,l -name "*.lua" -print0)
          }

          postFixupHooks+=(byteCompileLuaPostFixup)
        ''
    );

  /*
    Returns an overridden derivation with all lua files byte compiled.

    # Type

    ```
    byteCompileLuaDrvWith :: pkgs -> Derivation -> Derivation
    ```

    # Arguments

    - [pkgs] A nixpkgs instance
    - [drv] Input derivation
  */
  byteCompileLuaDrvWith =
    pkgs: drv:
    drv.overrideAttrs (
      prev:
      {
        nativeBuildInputs = prev.nativeBuildInputs or [ ] ++ [
          (lib.nixvim.builders.byteCompileLuaHookWith pkgs)
        ];
      }
      // lib.optionalAttrs (prev ? buildCommand) {
        buildCommand = ''
          ${prev.buildCommand}
          runHook postFixup
        '';
      }
    );
})
