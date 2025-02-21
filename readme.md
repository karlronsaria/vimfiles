# vimfiles

## setup

1. initialize submodules

   ```powershell
   git submodule update --init --recursive
   ```

2. install ``packer.vim``
   - link
     - url: <https://github.com/wbthomason/packer.nvim>
     - retrieved: 2023-09-28
   - howto
     - Windows

       ```powershell
       git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
       ```

3. install other dependencies

   ```powershell
   choco install -y lua-language-server
   ```

## credit

- github.com/DBremen for ``Open-Registry.ps1``
- link
  - url: <https://github.com/DBremen/PowerShellScripts/blob/master/Utils/Open-Registry.ps1>
  - retrieved: 2023-02-02

## link

- Vimscript is dead - How to configure Nvim with Lua!
  - url: <https://www.youtube.com/watch?v=-esgEOqwzVg&t=253s>
  - retrieved: 2022-07-30
- From init.vim to init.lua - a crash course
  - url: <https://www.notonlycode.org/neovim-lua-config/>
  - retrieved: 2023-09-28
- vimfiles
  - url: <https://www.youtube.com/watch?v=-esgEOqwzVg&t=253s>
  - retrieved: 2022-07-30

---
[PowerShell Files (pwsh)](./pwsh/readme.md)
[Issues Page](./doc/issue.md)
[Wishlist Page](./doc/wish.md)
