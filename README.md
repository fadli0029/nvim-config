# Neovim Config

Personal Neovim configuration based on [jdhao/nvim-config](https://github.com/jdhao/nvim-config).

Leader key is `,`.

## Quick Start

These are some essential keybindings.

**Code Understanding**
- `K` - Hover documentation for symbol under cursor
- `<C-k>` - Signature help while typing

**Navigation**
- `,fb` - Switch buffers (fuzzy search)
- `gb` / `gB` - Next/previous buffer
- `,ff` - Find files in project
- `,fg` - Grep search project
- `<space>s` - Toggle file tree

**Code Intelligence**
- `gd` - Go to definition
- `gD` - Go to definition (vertical split)
- `,gd` - Go to definition (horizontal split)
- `gr` - Show all references
- `<space>rn` - Rename symbol
- `[d` / `]d` - Navigate diagnostics

**Editing**
- `gcc` - Comment/uncomment line
- `<A-j>` / `<A-k>` - Move line up/down
- `,w` - Save file
- `\d` - Close buffer (keep window)
- `*` - Search word under cursor (no jump)

**Git**
- `,gs` - Git status
- `,gc` - Git commit
- `,hb` - Git blame line
- `]c` / `[c` - Next/previous hunk

## Complete Reference

### LSP
```
gd              Go to definition
gD              Go to definition (vertical split)
,gd             Go to definition (horizontal split)
gr              Show references
K               Hover documentation
<C-k>           Signature help
<space>rn       Rename symbol
<space>ca       Code actions
<space>f        Format code
[d / ]d         Previous/next diagnostic
<space>qb       Buffer diagnostics to quickfix
:CopyDiagnostic Copy error to clipboard
```

### File Navigation
```
,ff             Find files
,fg             Grep project
,fb             Switch buffers
,fr             Recent files
,fh             Search vim help
,ft             Buffer tags
<space>s        Toggle file tree
f               Jump to 2-char combo
```

### File Tree (nvim-tree)
```
a               Create file (add / suffix for folder)
d               Delete
r               Rename
c               Copy
x               Cut
p               Paste
```

### Git
```
,gs             Git status
,gc             Git commit
,gw             Git add current file
,gpl            Git pull
,gpu            Git push
,gbn            Create new branch
,hb             Git blame line
,hp             Preview hunk
]c / [c         Next/previous hunk
```

### Buffer Management
```
gb / gB         Next/previous buffer
<space>bp       Pick buffer
\d              Delete buffer (keep window)
\D              Delete all other buffers
\x              Close quickfix/location lists
,w              Save buffer
,q              Save and quit
,Q              Force quit all
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
*               Search word under cursor (no jump)
#               Search word backward (no jump)
```

### Text Manipulation
```
gcc             Comment line
gc + motion     Comment motion
<A-j> / <A-k>   Move line down/up
J / gJ          Join lines (keep cursor)
,p              Paste below line
,P              Paste above line
,v              Reselect pasted text
```

### Yank History
```
p / P           Paste with history
[y / ]y         Cycle yank history
,y              Yank entire buffer
```

### Insert Mode
```
<Tab> / <S-Tab> Navigate completion
<C-j> / <C-k>   Snippet expand/jump
<C-u>           UPPERCASE word
<C-t>           Title case word
<C-a> / <C-e>   Line start/end
<C-d>           Delete char right
, . ! ? ; :     Break undo sequence
```

### Editing
```
<space>o / O    Insert blank line below/above
,cd             Change to file directory
,<space>        Strip trailing whitespace
c / C / cc      Change (black hole register)
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
,ev             Edit init.lua
,sv             Reload config
;               Enter command mode (no shift)
```

### Utilities
```
<space>u        Toggle undo tree
<space>t        Toggle tags outline
<F9>            Run file (Python/C++)
<F11>           Toggle spell check
,st             Show syntax group
,cb             Blink cursor
,cl             Toggle cursor column
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

## Features

### LSP
Language servers configured for Python (ruff), C/C++ (clangd), Lua, Bash, LaTeX/Markdown (ltex-ls), and VimScript. Diagnostics show in sign column and auto-float on cursor hold.

### Completion
nvim-cmp provides completion from LSP, UltiSnips, file paths, and buffer words. Custom snippets in `my_snippets/`.

### Git
Fugitive handles git commands. Gitsigns shows changes in sign column with word-diff enabled.

### Search
Search uses very magic mode (`\v`). hlslens shows match counts. `*` and `#` search without moving cursor.

### Buffers vs Tabs
Config uses buffers instead of vim tabs. Bufferline displays buffers at top. Navigate with `gb`/`gB` or fuzzy finder.

### Registers
Change/delete operations use black hole register to avoid polluting default register. Visual paste doesn't contaminate register.

### Yank History
Yanky provides yank history. After pasting, cycle through previous yanks with `[y]`/`]y`.

### Text Objects
Custom: `iu`/`au` (URL), `iB` (buffer), `ic`/`ac` (markdown code block). Plugins add more: targets.vim (pairs), vim-indent-object, vim-pythonsense.

### Motions
`j`/`k` handle wrapped lines. nvim-hop (`f`) jumps to any visible 2-char combo.

### Terminal
`<Esc>` exits terminal mode. Python `<F9>` runs file in iPython split. C++ `<F9>` compiles and runs.

### File Finding
LeaderF uses ripgrep backend. No cache, shows hidden files, ignores git dirs and compiled files.

### Markdown
Bulletize lines with `+` motion. Add hard breaks with `\` motion. Footnote navigation with `^^`/`@@`. Preview on Mac with `<M-m>`.

### Other
Auto-pairs for brackets. Auto-save on insert leave. Mundo undo tree. Vista tag outline. Better escape handling.

## Dependencies

Required:
- `python3`
- `ripgrep`

Optional:
- `pandoc` - Markdown to PDF
- `clang-format` - C/C++ formatting
- `ctags` - Tag generation
- Language servers: ruff, clangd, lua-language-server, bash-language-server, ltex-ls, vim-language-server

## File Structure

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

## Notes

C/C++ formatting uses clang-format with `-style=file` (reads `.clang-format`).

Search automatically enables very magic mode for simpler regex.

Cursor position preserved during join operations.

LeaderF uses popup display with gruvbox_material colorscheme.
