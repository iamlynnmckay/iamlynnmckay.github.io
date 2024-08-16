# Completely Remove a Git Submodule From a Git Repo

To completely remove a git submodule from a git repo, do the following:

```bash
submodule=path/to/submodule
git rm $submodule
rm -rf .git/modules/$submodule
git config --remove-section submodule.$submodule
```

See also https://stackoverflow.com/questions/1260748/how-do-i-remove-a-submodule.