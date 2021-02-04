.PHONY: build install zip clean

IOSEVKA_VERSION=5.0.0-beta.3
IOSEVKA_FOLDER=Iosevka-$(IOSEVKA_VERSION)
IOSEVKA_OUTPUT=$(IOSEVKA_FOLDER)/dist/iosevka-custom/ttf

NERD_FONTS_VERSION=2.1.0
NERD_FONTS_FOLDER=nerd-fonts-$(NERD_FONTS_VERSION)
NERD_FONTS_OUTPUT=iosevka-custom-nerd-font

OUTPUT_FOLDER=~/.local/share/fonts/

# Copy the files from nerd-fonts/patched-fonts
build: $(NERD_FONTS_OUTPUT)/*.ttf

install: $(NERD_FONTS_OUTPUT)/*.ttf
	mkdir -p $(OUTPUT_FOLDER)
	cp -u $(NERD_FONTS_OUTPUT)/* $(OUTPUT_FOLDER)

zip: $(NERD_FONTS_OUTPUT).zip

$(NERD_FONTS_OUTPUT).zip: $(NERD_FONTS_OUTPUT)/*.ttf
	zip -ru $(NERD_FONTS_OUTPUT).zip $(NERD_FONTS_OUTPUT)

clean:
	rm -rf $(IOSEVKA_OUTPUT) $(NERD_FONTS_OUTPUT)

# Patch Iosevka
$(NERD_FONTS_OUTPUT)/%.ttf: $(NERD_FONTS_FOLDER)/font-patcher $(IOSEVKA_OUTPUT)/*.ttf
	mkdir -p $(NERD_FONTS_OUTPUT)
	find $(IOSEVKA_OUTPUT)/*.ttf -exec $< -c -o $(NERD_FONTS_OUTPUT) {} \;

# Download Nerd Fonts
$(NERD_FONTS_FOLDER)/font-patcher:
	curl -L "https://github.com/ryanoasis/nerd-fonts/archive/$(NERD_FONTS_VERSION).tar.gz" | tar xz

# Build Iosevka
$(IOSEVKA_OUTPUT)/%.ttf: $(IOSEVKA_FOLDER)/package.json $(IOSEVKA_FOLDER)/private-build-plans.toml
	cd $(IOSEVKA_FOLDER) && npm run build -- ttf::iosevka-custom

# Download Iosevka
$(IOSEVKA_FOLDER)/package.json:
	curl -L https://github.com/be5invis/Iosevka/archive/v$(IOSEVKA_VERSION).tar.gz | tar xz
	cd $(IOSEVKA_FOLDER) && npm i

# Configure Iosevka
$(IOSEVKA_FOLDER)/private-build-plans.toml: iosevka-config.toml
	cp $< $@

