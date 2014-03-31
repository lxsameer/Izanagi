mode = {
   ["default"] = {
      ["tags"] = {
	 ["1:www"] = {
	    ["layout"] = "awful.layout.suit.tile",
	    ["clients"] = {
	       {
		  ["exec"] = "~/bin/firefox/firefox",
		  ["use_exists"] = true,
	       },
	       {
		  ["exec"] = "chromium",
		  ["use_exists"] = true,
	       }
	    },
	 },
	 ["2:dev"] = {
	    ["layout"] = "awful.layout.suit.max",
	 },
	 ["3:terms"] = {
	    ["layout"] = "awful.layout.suit.spiral",
	    ["clients"] = {
	       {
		  ["exec"] = "rxvt",
	       },
	       {
		  ["exec"] = "rxvt",
	       },
	       {
		  ["exec"] = "rxvt",
	       },
	    },
	 },
	 ["4:music"] = {
	 },
	 ["5:shit"] = {
	 },
      },
   },
}