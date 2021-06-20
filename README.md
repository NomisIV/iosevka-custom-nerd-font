# Custom Iosevka with Nerd Font patches

Since I discovered [this icons-only nerd font](https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf) I will now deprecate this font, since I see no purpose in having the icons directly patched to any font.

## Dependencies

- [nodejs](https://nodejs.org/en/)
- [ttfautohint](https://www.freetype.org/ttfautohint/)
- [fontforge](https://fontforge.org/en-US/)

## Configuration

`iosevka-config.toml` can be generated at https://typeof.net/Iosevka/customizer

## Building and installing

- `make`
- `make install`

## Using Nix

- `nix-shell`
- `make`
