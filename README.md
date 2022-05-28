# Winbar.nvim

![winbar2](sources/winbar2.png)

[Reference ChristianChiarulli/nvim](https://github.com/ChristianChiarulli/nvim)

## Installation

Note: winbar.nvim requires [Neovim nightly](https://github.com/neovim/neovim/releases/tag/nightly) 

[nvim-gps](https://github.com/SmiteshP/nvim-gps) and [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) are optional. nvim-gps for the symbols and web-devicons for file icons.

[Packer](https://github.com/wbthomason/packer.nvim)

```lua
use { 'fgheng/winbar.nvim' }
```

## Usage

```lua
require('winbar').setup()
```

## Configuration

```lua
require('winbar').setup({
    enabled = true,

    show_file_path = true,
    show_symbols = true,

    colors = {
        path = '', -- You can customize colors like #c946fd
        file_name = '',
        symbols = '',
    },

    icons = {
        seperator = '>',
        editor_state = '●',
        lock_icon = '',
    },

    exclude_filetype = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
    }
})
```

## Todo

- [ ] Mode support
- [ ] Monitor whether the file is read-only
- [ ] Click support while neovim support click
