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
					expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.utkar.options',
				},
				home_manager = {
					expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.utkar.options.home-manager.users.utkar.type.getSubOptions []",
				},
			},
		},
	},
})
