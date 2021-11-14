this is nvim plugin to copy your code and paste to markdown file.
I strongly suggest you to use this plugin with vimwiki as it will help you to take note of your code in you daily works easier 
**Requirement**
- nvim > 0.5 
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)  
**Setup**
  - Using [packer.nvim](https://github.com/wbthomason/packer.nvim)
  ```lua
  use {
    'lavixta/capturecodemd',
    requires = { {'nvim-telescope/telescope.nvim'} },
  }

  ```
  then you add your file path ( where you store all of your md files ):
  ```lua
   require("capturecodemd").setup({
   path ="your md path" 
   })
  ```
