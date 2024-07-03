deploy:
	nix build .#darwinConfigurations.mac-air.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#mac-air
