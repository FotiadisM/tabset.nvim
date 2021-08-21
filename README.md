# tabset.nvim

## What is tabset.nvim?

`tabset.nvim` is a very simple plugin to easily control the width of `Tab` between different file types.

## Table of Contents

- [Requirements](#requirements)
- [Why](#why)
- [Installation](#installation)
- [Configuration](#configuration)

## Requirements

[Neovim v0.5](https://github.com/neovim/neovim/releases/tag/v0.5.0) or newer is required for `tabset` to work

## Why

Mostly for fun, since it's my first plugin. However, I have seen most people creating files under the `ftplugin` folder to control the behaviour of tab. I wanted to avoid creating a file for every file type so I made this plugin. Do we really need a plugin for something like this? I don't know, maybe note, but I made it anyway.

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "FotiadisM/tabset.nvim",
    config = function()
        require("tabset").setup()
    end
}
```

## Configuration

You can define a default tab width with `tabwidth` in the `defaults` area, this sets the `tabstop` and `shiftwidth` settings in Neovim, as well as the option to `expandtab`. This settings apply to all file types unless a custom configuration has been given in the `languages` department, then the default settings are overwritten for that language.

### Tabset Defaults

```lua
{
    defaults = {
        tabwidth = 4,
        expandtab = true
    },
    languages = {
        go = {
            tabwidth = 4,
            expandtab = false
        }
    }
}
```

### Example Configuration

```lua
require("tabset").setup({
    defaults = {
        tabwidth = 4,
        expandtab = true
    },
    languages = {
        go = {
            tabwidth = 4,
            expandtab = false
        },
        {
            filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml" },
            config = {
                tabwidth = 2
            }
        }
    }
})
```

As you can see in the above example, if you want you can specify the same settings for multiple file types easily. Also, if a value is missing from `config`, then is populated with the default value. For example, `expandtab` is set to true for `javascript`, `typescript`, ... in the above example because the value was not specified.
