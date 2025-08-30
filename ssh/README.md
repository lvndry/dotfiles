## Add a new SSH key for GitHub (step-by-step)

1. Generate and copy key to clipboard:

```bash
./ssh/github.sh
```

2. Add the key to GitHub:
- Open GitHub → Settings → SSH and GPG keys → New SSH key
- Title: something like "personal-mac"
- Key type: Authentication key
- Paste the clipboard contents → Add SSH key

3. Test the connection:

```bash
ssh -T git@github.com
```

4. Configure git (if not already):

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

Notes:
- Keys are saved under `~/.ssh/<key_name>` and `~/.ssh/<key_name>.pub`.
- The script adds your private key to the SSH agent automatically.
