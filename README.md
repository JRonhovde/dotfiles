# dotfiles
Dotfile synchronization.

Credit to Michael Smalley for 
[inspiration](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/).    
I followed the instructions found at the link above, with a few minor deviations.    

1. **The Install Script**
  * Modify the `files` variable to match the files/dirs you actually want to create symbolic links for. 
  * If you copied `makesymlinks.sh` directly from the [Github link](https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh),
  and don't want zshell installed remove everything from the `install_zsh() {` line to the end of the file. **Note: You will need to do this
   if you don't have Root/Super User priveleges.**
2. **Creating Our Local Git Repo**
  * The `git remote add origin` instructions would not work for me. Instead, I followed GitHub's instructions for 
  [creating a new repository](https://help.github.com/articles/create-a-repo/)(named dotfiles) and 
  [importing/cloning a repository](https://help.github.com/articles/importing-a-git-repository-using-the-command-line/) 
  to create a local 'dotfiles' repo.
3. **Nested repositories(vim plugins)**
  * If you happen to have any git repositories nested inside a 'dot' directory(`.vim/` for example), you'll need to take a few extra steps to get them working once you've moved `~/.vim/` to `~/dotfiles/vim/`. Each nested repository will have to be converted into a git [submodule](http://git-scm.com/docs/git-submodule). 
    * Remove any nested repositories, and commit the changes.
    * Clone the removed repositories as submodules.
    * All of my repositories were vim plugins located in the `vim/bundle/` directory, so my git submodule commands looked like this: `git submodule add git@github.com:tpope/vim-fugitive.git vim/bundle/vim-fugitive`
    * Once you've done this for all your nested repositories, commit and push and you should be good to go.
