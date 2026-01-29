local nvim_lsp = require("lspconfig")
nvim_lsp.nixd.setup({
	root_dir = nvim_lsp.util.root_pattern("flake.nix", ".git"),
	cmd = { "nixd" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import (builtins.getFlake "/home/utkar/dotfiles").inputs.nixpkgs { }   ',
			},
			formatting = {
				command = { "alejandra" },
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake "/home/utkar/dotfiles").nixosConfigurations.utkar.options',
				},
				home_manager = {
					expr = '(builtins.getFlake "/home/utkar/dotfiles").nixosConfigurations.utkar.options.home-manager.users.type.getSubOptions []',
				},
			},
		},
	},
})
