SHELL := /bin/bash

FLUTTER ?= flutter
API_BASE_URL ?= http://192.168.0.104:18088
BUILD_NAME ?=
BUILD_NUMBER ?=

DART_DEFINES := --dart-define=API_BASE_URL=$(API_BASE_URL)
VERSION_ARGS :=
ifneq ($(strip $(BUILD_NAME)),)
VERSION_ARGS += --build-name=$(BUILD_NAME)
endif
ifneq ($(strip $(BUILD_NUMBER)),)
VERSION_ARGS += --build-number=$(BUILD_NUMBER)
endif

.PHONY: help deps gen-l10n analyze test check debug release apk-debug apk-release appbundle ios-debug ios-release clean

help:
	@echo "Mateclaw build targets:"
	@echo "  make debug       Build Android debug APK"
	@echo "  make release     Build Android release APK"
	@echo "  make appbundle   Build Android release App Bundle"
	@echo "  make ios-debug   Build iOS debug app without codesign"
	@echo "  make ios-release Build iOS release app without codesign"
	@echo "  make check       Run project rules, analyzer, custom_lint, and tests"
	@echo ""
	@echo "Variables:"
	@echo "  API_BASE_URL=http://host:port"
	@echo "  BUILD_NAME=1.0.0"
	@echo "  BUILD_NUMBER=1"

deps:
	$(FLUTTER) pub get

gen-l10n: deps
	$(FLUTTER) gen-l10n

analyze: gen-l10n
	$(FLUTTER) analyze
	dart run custom_lint

test: gen-l10n
	$(FLUTTER) test

check: gen-l10n
	dart run scripts/check_project_rules.dart
	$(FLUTTER) analyze
	dart run custom_lint
	$(FLUTTER) test

debug: apk-debug

release: apk-release

apk-debug: gen-l10n
	$(FLUTTER) build apk --debug $(DART_DEFINES)

apk-release: gen-l10n
	$(FLUTTER) build apk --release $(DART_DEFINES) $(VERSION_ARGS)

appbundle: gen-l10n
	$(FLUTTER) build appbundle --release $(DART_DEFINES) $(VERSION_ARGS)

ios-debug: gen-l10n
	$(FLUTTER) build ios --debug --no-codesign $(DART_DEFINES)

ios-release: gen-l10n
	$(FLUTTER) build ios --release --no-codesign $(DART_DEFINES) $(VERSION_ARGS)

clean:
	$(FLUTTER) clean
