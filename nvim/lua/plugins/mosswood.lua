return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin-mocha",
        },
    },
    {
        -- Snacks terminal (Ctrl+/) reapplies its own winhighlight on every
        -- toggle, overriding our autocmd. Catppuccin links SnacksNormal -> Normal
        -- (base), so the focused terminal shows base instead of mantle. Set the
        -- winhighlight directly on the terminal window style so snacks applies it
        -- itself on every show.
        "folke/snacks.nvim",
        opts = {
            styles = {
                terminal = {
                    wo = {
                        winhighlight = "Normal:NormalFloat,NormalNC:NormalFloat,SignColumn:SignColumnSB",
                    },
                },
            },
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "mocha",
            color_overrides = {
                mocha = {
                    -- Background layers
                    crust    = "#0f0e0d", -- darkest: tabline, separators, borders
                    mantle   = "#121110", -- sidebars, floats, popups, terminal
                    base     = "#191817", -- code window background

                    -- Surface / UI chrome
                    surface0 = "#2e2d29", -- cursorline, selection, colorcolumn
                    surface1 = "#39372f", -- active line numbers, window borders
                    surface2 = "#504b3b", -- inactive elements, fold markers

                    -- Overlays
                    -- overlay0 = "#8a8278", -- comments (neutral gray, minimal warmth)
                    overlay0 = "#565350", -- comments (neutral gray, minimal warmth)
                    overlay1 = "#94885f", -- inactive line numbers
                    -- overlay2 = "#675f47", -- punctuation, operators
                    overlay2 = "#665c54", -- punctuation, operators

                    -- Text hierarchy
                    subtext0 = "#c1b077",
                    subtext1 = "#d7c483",
                    text     = "#e5d5a0",

                    -- Accents
                    rosewater = "#b16878", -- pink (special chars, rare)
                    flamingo  = "#ba8a8f", -- muted rose (deprecated)
                    pink      = "#c88493", -- pink (rare)
                    mauve     = "#6e937f", -- keywords (fn, let, impl) → forest green
                    red       = "#b36d43", -- errors, deletes
                    maroon    = "#a65b2e", -- secondary errors
                    peach     = "#b87e40", -- numbers, attributes, macros
                    yellow    = "#c9a554", -- warnings, classes, constants
                    green     = "#78824b", -- strings, diff add (olive)
                    teal      = "#538369", -- constructors, tags (blue-green)
                    sky       = "#a97147", -- enum variants, lifetimes (reddish terra cotta)
                    sapphire  = "#739673", -- types, interfaces (bright green, kitty color10)
                    blue      = "#c88493", -- functions, modules (sage)
                    lavender  = "#4b764b", -- parameters, props (neutral aqua)
                },
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            -- Terminal windows use mantle (#121110) instead of base.
            -- winhighlight is window-local, so reapply it whenever a terminal
            -- buffer is shown in / focused on a window, not just at TermOpen.
            vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter", "WinEnter" }, {
                callback = function()
                    if vim.bo.buftype == "terminal" then
                        vim.wo.winhighlight = "Normal:NormalFloat,SignColumn:SignColumnSB"
                    end
                end,
            })
        end,
    },
}
