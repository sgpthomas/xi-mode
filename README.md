# Xi Mode
This provides simple syntax highlighting and indentation for Xi in Emacs.

## Installation
Clone this repository to a location of your choice. Add it to the laod path, and then require `xi-mode`. 
For Spacemacs, this looks like adding the following lines to `dotspacemacs/user-config` in your `.spacemacs` file:
```
(push "~/.emacs.d/private/xi-mode" load-path)
(require 'xi-mode)
```
I imagine it looks very similar for pure emacs, but haven't actually tried it myself.

## Known Bugs
 - The indentation code isn't aware of comments which means that a lone bracket in a comment will throw off indentation.
 - `If` and `While` statements that don't use brackets won't have indented bodies. This is more of an issue that the first so I will probably fix this soon.
