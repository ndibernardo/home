HOST=$(shell hostname)

default: switch

switch:
	nix run home-manager -- switch --flake .#${HOST} -b backup

update:
	nix flake update
