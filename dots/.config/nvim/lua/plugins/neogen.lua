return {
  "danymat/neogen",
  config = function()
    require("neogen").setup({
      languages = {
        ["php.phpdoc"] = require("neogen.configurations.php"),
        ["lua.emmylua"] = require("neogen.configurations.lua"),
        ["typescript.jsdoc"] = require("neogen.configurations.javascript"),
        ["javascript.jsdoc"] = require("neogen.configurations.javascript"),
        ["typescriptreact.jsdoc"] = require("neogen.configurations.javascript"),
        ["javascriptreact.jsdoc"] = require("neogen.configurations.javascript"),
        ["vue.jsdoc"] = require("neogen.configurations.javascript"),
        ["go.godoc"] = require("neogen.configurations.javascript"),
      },
      { snippet_engine = "luasnip" },
    })
  end,
}
