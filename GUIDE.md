# Neovim Config Guide

Based on jdhao's configuration. Leader key is `,` (comma).

## Essential Quick Start

These are the most useful features you should learn first:

### Understanding What Code Does (No Jumping Required)
```
K               Hover doc - shows definition/type/docstring under cursor
<C-k>           Signature help - shows function parameters while typing
```

### Navigation Between Files/Buffers
```
,fb             Switch buffers (fuzzy find open files)
gb / gB         Next/previous buffer (like cycling tabs)
,ff             Find files in project
,fg             Grep search entire project
<space>s        Toggle file tree sidebar
```

### Code Intelligence
```
gd              Go to definition
gD              Go to definition (vertical split)
,gd             Go to definition (horizontal split)
gr              Show all references/usages
<space>rn       Rename symbol everywhere
,ft             Show tags/outline of current file
[d / ]d         Jump between errors/warnings
```

### Essential Editing
```
gcc             Comment/uncomment line
<A-j> / <A-k>   Move line up/down
,w              Save file
\d              Close current buffer (keeps window layout)
*               Search word under cursor (doesn't jump)
```

### Git Basics
```
,gs             Git status
,gc             Git commit
,hb             Git blame current line
]c / [c         Next/previous change in file
```

## Complete Quick Reference

### LSP
```
gd              Go to definition
gD              Go to definition (vertical split)
<leader>gd      Go to definition (horizontal split)
gr              Show references
K               Hover documentation
<C-k>           Signature help
<space>rn       Rename symbol
<space>ca       Code actions
<space>f        Format code
[d / ]d         Previous/next diagnostic
<space>qb       Buffer diagnostics to quickfix
:CopyDiagnostic Copy error message to clipboard
```

### File Navigation
```
<leader>ff      Find files
<leader>fg      Grep project
<leader>fb      Switch buffers
<leader>fr      Recent files
<leader>fh      Search vim help
<leader>ft      Buffer tags
<space>s        Toggle file tree
f               Jump to 2-char combo (nvim-hop)
```

### Git
```
<leader>gs      Git status
<leader>gc      Git commit
<leader>gw      Git add current file
<leader>gpl     Git pull
<leader>gpu     Git push
<leader>gbn     Create new branch
<leader>hb      Git blame line
<leader>hp      Preview hunk
]c / [c         Next/previous hunk
```

### Buffer Management
```
gb / gB         Next/previous buffer
<space>bp       Pick buffer
\d              Delete buffer (keep window)
\D              Delete all other buffers
\x              Close quickfix/location lists
<leader>w       Save buffer
<leader>q       Save and quit
<leader>Q       Force quit all
```

### Window/Split Management
```
<C-w>v          Vertical split
<C-w>s          Horizontal split
<C-w>c          Close current window
<C-w>o          Close all other windows
<C-w>>          Increase width
<C-w><          Decrease width
<C-w>+          Increase height
<C-w>-          Decrease height
<C-w>=          Equalize all splits
<C-w>|          Maximize width
<C-w>_          Maximize height
<arrow keys>    Navigate between windows
```

### Search
```
/               Search (very magic mode)
n / N           Next/previous match (shows count)
*               Search word under cursor (no move)
#               Search word backward (no move)
```

### Text Manipulation
```
gcc             Comment line
gc + motion     Comment motion
<A-j> / <A-k>   Move line down/up
J / gJ          Join lines (keep cursor pos)
<leader>p       Paste below line
<leader>P       Paste above line
<leader>v       Reselect pasted text
```

### Yank History
```
p / P           Paste with history
[y / ]y         Cycle yank history
<leader>y       Yank entire buffer
```

### Insert Mode
```
<Tab> / <S-Tab> Navigate completion
<C-j> / <C-k>   Snippet expand/jump
<C-u>           UPPERCASE word
<C-t>           Title case word
<C-a> / <C-e>   Line start/end (bash-like)
<C-d>           Delete char right
, . ! ? ; :     Break undo sequence
```

### Editing
```
<space>o / O    Insert blank line below/above
<leader>cd      Change to file directory
<leader><space> Strip trailing whitespace
c / C / cc      Change (uses black hole register)
H / L           Line start/end
iu / au         URL text object
iB              Buffer text object
```

### Quickfix Lists
```
[q / ]q         Previous/next quickfix item
[Q / ]Q         First/last quickfix item
[l / ]l         Previous/next location item
[L / ]L         First/last location item
```

### Config
```
<leader>ev      Edit init.lua
<leader>sv      Reload config
;               Enter command mode (no shift)
```

### Utilities
```
<space>u        Toggle undo tree
<space>t        Toggle tags outline
<F9>            Run file (Python/C++)
<F11>           Toggle spell check
<leader>st      Show syntax group
<leader>cb      Blink cursor
<leader>cl      Toggle cursor column
```

### Markdown
```
+               Add bullets to lines
\               Add hard line breaks
^^              Insert footnote
@@              Return from footnote
ic / ac         Code block text object
<M-m>           Preview (Mac)
```

### Commands
```
:Datetime       Show/parse timestamp
:ToPDF          Convert markdown to PDF
:JSONFormat     Format JSON selection
:Redir <cmd>    Capture command output
:Man            View man pages
:Rename         Rename file
:Delete         Delete file
```

### Command Abbreviations
```
:pi             :Lazy install
:pud            :Lazy update
:pc             :Lazy clean
:ps             :Lazy sync
:git            :Git
```

## Feature Details

### LSP Configuration

Language servers configured:
- `ruff` - Python linting/formatting
- `clangd` - C/C++ (uses clang-format for formatting)
- `lua-language-server` - Lua
- `bash-language-server` - Bash
- `ltex-ls` - Grammar checking (LaTeX, Markdown)
- `vim-language-server` - VimScript

Diagnostics auto-float on cursor hold. Signs: ❌ (error), 🫨 (warn), 🤔 (info), 💡 (hint).

### Completion

Sources: LSP, UltiSnips, file paths, buffer words. TeX files use omni completion.

Custom snippets in `my_snippets/` directory.

### Git Integration

Fugitive handles git commands. Gitsigns shows changes in sign column with word-diff enabled.

### Search Behavior

`/` uses very magic mode (`\v`) automatically. hlslens shows match counts (e.g., "1/10"). `*` and `#` don't move cursor.

### Buffer vs Tabs

Config uses buffers, not vim tabs. Bufferline shows buffers at top like tabs. Navigate with `gb`/`gB` or fuzzy finder (`<leader>fb`).

### Register Handling

`c`, `C`, `cc` operations use black hole register (`"_`) to avoid polluting default register. Visual paste doesn't contaminate register.

### Yank History

Yanky plugin provides yank history. After pasting, cycle through previous yanks with `[y`/`]y`.

### Text Objects

Custom: `iu`/`au` (URL), `iB` (buffer), `ic`/`ac` (markdown code block).

Plugins provide: targets.vim (pairs), vim-indent-object (`ii`/`ai`), vim-pythonsense (Python functions/classes).

### Motion Enhancements

`j`/`k` handle wrapped lines automatically. `H`/`L` jump to line start/end. nvim-hop (`f`) jumps to any visible 2-char combo.

### Insert Mode Enhancements

Bash-like navigation (`<C-a>`, `<C-e>`). Punctuation (`,`, `.`, `!`, `?`, `;`, `:`) creates undo breakpoints for granular undo.

### Terminal Integration

`<Esc>` exits terminal mode. Python `<F9>` runs file in iPython (vertical split). C++ `<F9>` compiles and runs (clang++ or g++).

### Auto-features

Auto-pairs for brackets/quotes. Auto-save on insert leave. Better escape handling.

### File Finding

LeaderF uses ripgrep backend. No cache, shows hidden files. Ignores git dirs, pycache, compiled files.

### Markdown Features

Bulletize lines with `+` motion. Add hard breaks with `\` motion. Footnote navigation (`^^`/`@@`). Preview available on Mac (`<M-m>`).

### Code Execution

Python: `<F9>` runs in iPython split.
C++: `<F9>` compiles with `-Wall -O2` and runs.
TeX: `<F9>` compiles document.

### Undo History

Mundo provides visual undo tree. Access with `<space>u` or `:MundoToggle`.

### Tag Navigation

Vista shows file outline/tags. Toggle with `<space>t`.

### Configuration Management

Edit config: `<leader>ev` opens init.lua in new tab.
Reload config: `<leader>sv` sources and reloads immediately.

### Diagnostic Display

Underline disabled. Virtual text disabled. Float on hover enabled. Severity-sorted.

### Custom Commands

`Datetime` - Show current time or parse unix timestamp.
`ToPDF` - Convert markdown to PDF via pandoc.
`JSONFormat` - Format selected JSON.
`Redir` - Capture command output to register.

## Implementation Notes

C/C++ files use clang-format with `-style=file` option (reads `.clang-format` if present).

Search uses very magic mode to simplify regex patterns.

Change/delete operations don't pollute registers (use `"_` internally).

Cursor position preserved during join operations.

Location and quickfix lists have enhanced navigation with `[]` prefixes.

LeaderF configured with popup display mode, gruvbox_material colorscheme.

## Dependencies

Required:
- `python3` - Python support
- `ripgrep` - File searching (LeaderF backend)

Optional:
- `pandoc` - Markdown to PDF
- `clang-format` - C/C++ formatting
- `ctags` - Tag generation
- `tmux` - Terminal multiplexer support

Language servers listed above are optional but recommended for full LSP functionality.

## File Locations

| Feature | File |
|---------|------|
| Main keybindings | lua/mappings.lua |
| LSP setup | lua/config/lsp.lua |
| Completion | lua/config/nvim-cmp.lua |
| Git (fugitive) | lua/config/fugitive.lua |
| Git (gitsigns) | lua/config/gitsigns.lua |
| LeaderF | viml_conf/plugins.vim |
| Markdown | after/ftplugin/markdown.vim |
| Python | after/ftplugin/python.vim |
| C++ | after/ftplugin/cpp.vim |
| Plugins | lua/plugin_specs.lua |
| Commands | plugin/command.vim |

Config location: `/home/magomed_fadliov/.config/nvim/`
