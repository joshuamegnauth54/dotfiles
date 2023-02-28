-- Dependencies for other packages or packages common to every environment
-- In other words, packages I can't fit anywhere else

return {
    -- Useful functions that a lot of plugins depend on
    {
        "nvim-lua/plenary.nvim",
        lazy = true
    },
    -- File manager
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        cmd = "NvimTreeToggle",
        config = true
    },
    -- Better status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = true
    },
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        config = function()
            local tele = require("telescope")
            tele.setup({
                extensions = {
                    heading = {
                        treesitter = true,
                    },
                    undo = {
                        -- This delta: https://github.com/dandavison/delta
                        -- ...which I tend to have installed anyway
                        use_delta = true
                    }
                }
            })

            -- Note: Not every extension must be loaded like this
            local extensions = {
                "dap",
                "fzf",
                "heading",
                "undo"
            }

            for _, ext in pairs(extensions) do
                tele.load_extension(ext)
            end
        end
    },
    -- Faster fuzzy searching with native fzf
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        cmd = "Telescope",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },
    -- Search for emoji with Telescope
    {
        "nvim-telescope/telescope-symbols.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-telescope/telescope.nvim" },
        -- I'm not sure why the plugin doesn't do this itself
        build = "git clone https://github.com/nvim-telescope/telescope-symbols.nvim /tmp/lazy/telescope-symbols && cp -r /tmp/lazy/telescope-symbols/data ~/.config/nvim"
    },
    -- Search through tabs with telescope
    {
        "LukasPietzschmann/telescope-tabs",
        cmd = "Telescope",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },
    -- Search through headings in LaTeX and Markdown
    {
        "crispgm/telescope-heading.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },
    {
        "debugloop/telescope-undo.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-telescope/telescope.nvim" }
    },
    -- Show tagged outline of source code (i.e. structs and functions)
    {
        "preservim/tagbar",
        cmd = "TagbarToggle"
    },
    -- Indentation guidelines
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            show_current_context = true,
            show_current_context_start = true,
        },
        config = true
    },
    -- Show git status signs
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                -- Actions
                map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                map('n', '<leader>hS', gs.stage_buffer)
                map('n', '<leader>hu', gs.undo_stage_hunk)
                map('n', '<leader>hR', gs.reset_buffer)
                map('n', '<leader>hp', gs.preview_hunk)
                map('n', '<leader>hb', function() gs.blame_line{full=true} end)
                map('n', '<leader>tb', gs.toggle_current_line_blame)
                map('n', '<leader>hd', gs.diffthis)
                map('n', '<leader>hD', function() gs.diffthis('~') end)
                map('n', '<leader>td', gs.toggle_deleted)

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        },
        config = true
    },
    -- Automatically close pairs (brackets, parenthesis)
    {
        "windwp/nvim-autopairs",
        opts = {
            enable_check_bracket_line = false,
            -- Ignore alphanumeric and .
            ignored_next_char = "[%w%.]"
        },
        config = true
    }
}
