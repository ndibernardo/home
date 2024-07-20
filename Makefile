HOST=$(shell hostname)

default: switch

switch:
	nix run home-manager -- switch --flake .#${HOST}

update:
	nix flake update
