.PHONY: build install clean

IOSEVKA_FOLDER=iosevka
IOSEVKA_OUTPUT=$(IOSEVKA_FOLDER)/dist/iosevka-custom/ttf

NERD_FONTS_FOLDER=nerd-fonts
NERD_FONTS_OUTPUT=iosevka-custom-nerd-font

OUTPUT_FOLDER=~/.local/share/fonts/

# Copy the files from nerd-fonts/patched-fonts
build: $(NERD_FONTS_OUTPUT)/%.ttf

install: build
	cp -u $(NERD_FONTS_OUTPUT)/* $(OUTPUT_FOLDER)

clean:
	rm -f $(IOSEVKA_OUTPUT)/*
	rm -f $(NERD_FONTS_OUTPUT)/*

# Patch Iosevka
$(NERD_FONTS_OUTPUT)/%.ttf: $(NERD_FONTS_FOLDER)/font-patcher $(IOSEVKA_OUTPUT)/%.ttf
	find $(IOSEVKA_OUTPUT)/* -exec $< -c -o $(NERD_FONTS_OUTPUT) {} \;

# Download Nerd Fonts
$(NERD_FONTS_FOLDER)/font-patcher:
	git clone --depth 1 "https://github.com/ryanoasis/nerd-fonts.git" $(NERD_FONTS_FOLDER)

# Build Iosevka
$(IOSEVKA_OUTPUT)/%.ttf: $(IOSEVKA_FOLDER)/package.json $(IOSEVKA_FOLDER)/private-build-plans.toml
	cd $(IOSEVKA_FOLDER) && npm run build -- ttf::iosevka-custom

# Download Iosevka
$(IOSEVKA_FOLDER)/package.json:
	git clone --depth 1 "https://github.com/be5invis/Iosevka.git" $(IOSEVKA_FOLDER)
	cd $(IOSEVKA_FOLDER) && npm i

# Configure Iosevka
$(IOSEVKA_FOLDER)/private-build-plans.toml: iosevka-config.toml
	cp iosevka-config.toml $@

