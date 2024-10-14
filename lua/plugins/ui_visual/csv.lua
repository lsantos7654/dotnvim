return {
	"hat0uma/csvview.nvim",
	config = function()
		require("csvview").setup({
			parser = {
				--- The number of lines that the asynchronous parser processes per cycle.
				--- This setting is used to prevent monopolization of the main thread when displaying large files.
				--- If the UI freezes, try reducing this value.
				--- @type integer
				async_chunksize = 50,

				--- The delimiter character
				--- You can specify a string, a table of delimiter characters for each file type, or a function that returns a delimiter character.
				--- e.g:
				---  delimiter = ","
				---  delimiter = function(bufnr) return "," end
				---  delimiter = {
				---    default = ",",
				---    ft = {
				---      tsv = "\t",
				---    },
				---  }
				--- @type string | {default: string, ft: table<string,string>} | fun(bufnr:integer): string
				delimiter = {
					default = ",",
					ft = {
						tsv = "\t",
					},
				},
				view = {
					--- minimum width of a column
					--- @type integer
					min_column_width = 5,

					--- spacing between columns
					--- @type integer
					spacing = 2,

					--- The display method of the delimiter
					--- "highlight" highlights the delimiter
					--- "border" displays the delimiter with `│`
					--- see `Features` section of the README.
					---@type "highlight" | "border"
					display_mode = "border",
				},
			},
		})
	end,
}
