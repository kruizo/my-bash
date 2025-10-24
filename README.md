![Demo](sample_demo/demo.gif)

## Features
- with Fuzzy Search (Ctrl+Space)
- Custom pronpt (with git)
- Transparency effect on bash terminal
- other shortcuts (git operations, opening vim, docker, etc)
- contains minimal vim config with shortcuts

## Newly Added Features

- **Improved Fuzzy Search Navigation**  
  - Open the fuzzy search menu anytime by pressing <kbd>Ctrl</kbd> + <kbd>Space</kbd>.  
  - Use the **→ (Right Arrow)** to enter a directory, or **← (Left Arrow)** to go back.  
  This makes file exploration smooth and fast — no need to type full paths!

- **Quick Vim Access**  
  - Press <kbd>Ctrl</kbd> + <kbd>e</kbd> in your terminal to instantly open **Vim**.  
  - Inside Vim, press <kbd>Space</kbd> + <kbd>e</kbd> to **browse files and directories** seamlessly.

---

## How to use
1. Clone the repository.
```
  git clone https://github.com/kruizo/my-bash
```
2. CD into the directory.
```
  cd my-bash
```
3. Make the script executable.
```
  chmod +x install.sh
```
4. Run the script.
```
  ./install.sh
```

Note: Your exisitng bash and vim configurations will be backed up in the same directory followed by a timestamp. To revert, remove the existing .bashrc and .vimrc and rename the backed up configs to '.bashrc' and '.vimrc'.
