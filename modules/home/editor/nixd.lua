local nvim_lsp = vim.lsp
nvim_lsp.config("nixd", {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
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
					expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.utkar.options",
				},
				home_manager = {
					expr = '(builtins.getFlake (toString ./.)).homeConfigurations."utkar@utkar".options',
				},
			},
		},
	},
})
nvim_lsp.enable("nixd")
