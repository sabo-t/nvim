for _, pluginName in ipairs(util.generate_plugin_names()) do
    package.loaded[pluginName] = nil
end

plugins = {
    require('plugin_treesitter'),
    require('plugin_cmp'),
    require('plugin_telescope'),
    require('plugin_focus'),
    require('plugin_comment'),
    require('plugin_colorschemes'),
    require('plugin_lsp'),
    require('plugin_navic'),
    require('plugin_term'),
    require('plugin_devicons'),
    require('plugin_gitsigns'),
    require('plugin_lualine'),
    require('plugin_dashboard'),
    require('plugin_repeat'),
    require('plugin_leap'),
    require('plugin_sniprun'),
    require('plugin_surround'),
    require('plugin_autopairs'),
    require('plugin_marks'),
    require('plugin_aerial'),
    -- require('plugin_visualmulti'),
    require('plugin_undotree'),
    require('plugin_fidget'),
    -- require('plugin_indentblankline'),
}

plugins = util.flatten_2(plugins)

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    for _, plugin in ipairs(plugins) do
        use(plugin) -- call 'use' function with the plugin table as an argument
    end
    if packer_bootstrap then require('packer').sync() end
end)
