-- link
-- - url
--   - <https://www.lua.org/docs.html>
--   - <https://www.lua.org/manual/5.4/>
--   - <https://neovim.io/doc/user/lua.html>
--   - <https://neovim.io/doc/user/options.html>
--   - <https://github.com/nanotee/nvim-lua-guide>
-- - retrieved: 2022_07_30

require('package')
require('define')
require('setting')
require('datetime')
require('os-custom-variable')
require('todolist')
require('psmarkdown')
require('pscalendar')
require('markdown')
require('shortcut')
require('link')
require('drawingboard')
require('ast')

source('nvim/vim/setting.vim')
source('nvim/vim/zettel.vim')
source('nvim/vim/drawingboard.vim')
