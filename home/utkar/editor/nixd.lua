local flake = '(builtins.getFlake "/home/utkar/dotfiles")'

vim.lsp.config("nixd", {
	root_dir = vim.fs.dirname(vim.fs.find({ "flake.nix", ".git" }, { upward = true })[1]),

	settings = {
		nixd = {
			formatting = {
				command = { "alejandra" },
			},

			nixpkgs = {
				expr = "import " .. flake .. ".inputs.nixpkgs { }",
			},

			options = {
				nixos = {
					expr = flake .. ".nixosConfigurations.utkar.options",
				},

				home_manager = {
					expr = flake .. ".nixosConfigurations.utkar.options.home-manager.users.type.getSubOptions []",
				},
			},
		},
	},
})

vim.cmd.colorscheme("dms")

vim.lsp.enable("nixd")
