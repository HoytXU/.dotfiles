# Common operations for this dotfiles repo.
# Run `make` (no args) to see available targets.

.DEFAULT_GOAL := help
.PHONY: help install update submodules-init

help:
	@echo "Targets:"
	@echo "  make install          Run dotbot to symlink configs (./install)"
	@echo "  make submodules-init  Initialize all submodules (first-time setup)"
	@echo "  make update           Pull, refresh submodules, then re-install"
	@echo "  make help             Show this help (default)"

install:
	./install

submodules-init:
	git submodule update --init --recursive

update:
	git pull --ff-only
	git submodule update --init --recursive
	./install
