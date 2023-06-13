local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use({ "wbthomason/packer.nvim", commit = "1d0cf98a561f7fd654c970c49f917d74fafe1530" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim", commit = "253d34830709d690f013daf2853a9d21ad7accab" }) -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs", commit = "e755f366721bc9e189ddecd39554559045ac0a18" }) -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim", commit = "8d3aa5c22c2d45e788c7a5fe13ad77368b783c20" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "729d83ecb990dc2b30272833c213cc6d49ed5214" })
  use({ "nvim-tree/nvim-web-devicons", commit = "95b1e300699be8eb6b5be1758a9d4d69fe93cc7f" })
  use({ "nvim-tree/nvim-tree.lua", commit = "a8a4834e1af9fb85710bc1307298a45fae4e561c" })
  use({ "akinsho/bufferline.nvim", commit = "3677aceb9a72630b0613e56516c8f7151b86f95c" })
  use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
  use({ "nvim-lualine/lualine.nvim", commit = "e99d733e0213ceb8f548ae6551b04ae32e590c80" })
  use({ "akinsho/toggleterm.nvim", commit = "9a595ba699837c4333c4296634feed320f084df2" })
  use({ "ahmedkhalf/project.nvim", commit = "1c2e9c93c7c85126c2197f5e770054f53b1926fb" })
  use({ "lewis6991/impatient.nvim", commit = "c90e273f7b8c50a02f956c24ce4804a47f18162e" })
  use({ "lukas-reineke/indent-blankline.nvim", commit = "018bd04d80c9a73d399c1061fa0c3b14a7614399" })
  use({ "goolord/alpha-nvim", commit = "dafa11a6218c2296df044e00f88d9187222ba6b0" })

  -- Sergei's personal plugins
  use({ "rest-nvim/rest.nvim", commit = "0fdb69f328529b34a2279c14be63b3325dc52740" })
  use({ "gbprod/cutlass.nvim", commit = "31a2099627cd1ef8898f442ee6a58c7400111395" })
  use({ "tversteeg/registers.nvim", commit = "0a461e635403065b3f9a525bd77eff30759cfba0" })
  use({ "nvim-zh/colorful-winsep.nvim", commit = "bb06c8678b1f879f14264aaba721098cc5495768" })
  use({ "j-hui/fidget.nvim", commit = "688b4fec4517650e29c3e63cfbb6e498b3112ba1" })
  use({ "alexghergh/nvim-tmux-navigation", commit = "84a72a1f7655a2b2ced53abc7aea21f05019642a" })

  -- Colorschemes
  use({ "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" })
  use({ "Mofiqul/dracula.nvim", commit = "798274ba3c454a9aa3cd71f95a86ea55cbbbb142" })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }) -- buffer completions
  use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }) -- path completions
  use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
  use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

  -- snippets
  use({ "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }) --snippet engine
  use({ "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }) -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" }) -- enable LSP
  use({ "williamboman/mason.nvim", commit = "bfc5997e52fe9e20642704da050c415ea1d4775f" })
  use({ "williamboman/mason-lspconfig.nvim", commit = "0eb7cfefbd3a87308c1875c05c3f3abac22d367c" })
  use({ "jose-elias-alvarez/null-ls.nvim", commit = "f8ffcd7cb8fb3325c711d459152ef132b5b65aed" }) -- for formatters and linters
  use({ "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" })
  use({
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    commit = "343e07de11b15f93e44ebd47eb98dce6b7da2e6b",
  })
  use({ "folke/trouble.nvim", commit = "2ae7237c2917d661f458443c9a88680f8ca2d7b2" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim", commit = "3c2e5fb23e9f6ca1aa682ae16bac3319bfe03e38" })
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    commit = "7447fe780fed23402a3e0c3a227b549d7506ed38",
    run = "make",
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    commit = "da7f886ab5dde87b7c9bbae1c1eb99aa63a74e55",
    run = ":TSUpdate",
  })
  use({ -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    commit = "582cbb5a4cb50f6161cac8cc01f55aeaff6d836a",
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim", commit = "ca473e28382f1524aa3d2b6f04bcf54f2e6a64cb" })

  -- DAP
  use({ "mfussenegger/nvim-dap", commit = "6b12294a57001d994022df8acbe2ef7327d30587" })
  use({ "rcarriga/nvim-dap-ui", commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13" })
  use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })

  -- Mini.nvim plugins
  use({ "echasnovski/mini.trailspace", branch = "stable" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
