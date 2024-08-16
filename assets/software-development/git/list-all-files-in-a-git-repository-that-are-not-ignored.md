# List All Files in a Git Repository That Are Not Ignored

The following command will list all files in a git repository that are not ignored by a `.gitignore`.

```sh
git ls-files --others --exclude-standard --cached
```