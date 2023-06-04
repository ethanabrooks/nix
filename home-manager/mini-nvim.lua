local config = function()
	-- Enhanced textobjects and pairs
	require("mini.ai").setup()
	require("mini.animate").setup()
	-- require("mini.basics").setup()
	require("mini.comment").setup()
	-- Move selected text around
	require("mini.move").setup()
	require("mini.pairs").setup()
	require("mini.surround").setup()
end

config()
