# Linux Task 03 — User Management, Log Analysis & Permissions

**Portfolio project | Git Bash workflow | Linux lab activity**

This repository documents the Linux Task 03 practical: user and group management, mock system-log creation and filtering, file permissions and ownership, and temporary-user administration.

> **Important environment note:** Git Bash on Windows is not a full Linux system. Commands such as `useradd`, `usermod`, `chown`, Linux groups, and Linux file permission demonstrations must be run in a Linux VM (such as Kali/Ubuntu) or another authorized Linux lab. Use Git Bash for Git commands and pushing the repository to GitHub. You can edit files and manage the Git repository in Git Bash.

## Repository structure

```text
Linux-Task-03/
├── README.md
├── commands_used.txt
├── .gitignore
├── docs/
│   ├── task-summary.md
│   └── reflection.md
├── logs/
│   ├── sys_events.log
│   └── error_report.txt
├── reports/
│   └── log_analysis_report.md
├── scripts/
│   └── create_mock_logs.sh
└── evidence/
    ├── README.md
    ├── screenshots/
    └── terminal-outputs/
```

## Activity workflow

### Part 1 — Create the forensic user

Run in the Linux lab with sudo privileges, not in Windows Git Bash:

```bash
sudo useradd -m -s /bin/bash forensic01
sudo usermod -aG sudo forensic01
sudo passwd forensic01
id forensic01
getent passwd forensic01
```

If `forensic01` already exists, inspect it with `id forensic01` before attempting to create it again.

### Part 2 — Create and analyse the mock log

The sample log is included in `logs/sys_events.log`. To create it in the required user's home directory on Linux:

```bash
sudo install -d -o forensic01 -g forensic01 /home/forensic01/logs
sudo cp logs/sys_events.log /home/forensic01/logs/sys_events.log
sudo chown forensic01:forensic01 /home/forensic01/logs/sys_events.log
su - forensic01
cd /home/forensic01/logs
wc -l sys_events.log
grep "ERROR" sys_events.log
grep -E "root|user01" sys_events.log
grep "ERROR" sys_events.log | less
grep -E "root|user01" sys_events.log | less
grep "ERROR" sys_events.log > error_report.txt
head -n 5 sys_events.log
tail -n 5 sys_events.log
cat sys_events.log
```

Press `q` to exit `less`. Copy the report back into this repository if you want to include the result:

```bash
exit
sudo cp /home/forensic01/logs/error_report.txt logs/error_report.txt
sudo chown "$USER":"$USER" logs/error_report.txt
```

If you run `chown` from a different account, replace `$USER` with the username that should own the repository file.

### Part 3 — Permissions and ownership

Run as `forensic01` in the Linux lab:

```bash
cd /home/forensic01/logs
touch confidential.txt
chmod 600 confidential.txt
ls -l confidential.txt
sudo chown root:root confidential.txt
ls -l confidential.txt
cat confidential.txt
```

The final `cat` should return “Permission denied” when the file is root-owned and mode `600`, because only the owner has read/write permission. This is a controlled demonstration; do not use `sudo cat` for the access test.

### Part 4 — Temporary users

Run from an authorized sudo account in the Linux lab:

```bash
sudo useradd -m guest1
sudo useradd -m guest2
sudo usermod -aG sudo guest1
id guest1
groups guest1
sudo userdel -r guest2
```

`userdel -r guest2` removes the account and its home directory. Verify the account names first, and do not run these commands on a production system.

## Evidence checklist

Capture your own screenshots and save them under `evidence/screenshots/`:

1. `01-forensic01-user-setup.png` — user creation and `id forensic01`.
2. `02-log-file-and-line-count.png` — log file and `wc -l`.
3. `03-grep-error-results.png` — `grep "ERROR"`.
4. `04-grep-root-user01-results.png` — `grep -E "root|user01"`.
5. `05-head-tail-results.png` — first and last five lines.
6. `06-permissions-before-after.png` — `ls -l` before and after `chown`.
7. `07-confidential-permission-denied.png` — failed read as `forensic01`.
8. `08-guest-user-management.png` — `id guest1`, group membership and guest2 removal.

Use real screenshots from your own lab. Do not create fake evidence or include passwords, tokens, or unrelated personal information. `evidence/terminal-outputs/` is available for plain-text output captures if your instructor accepts them.

## Required submission notes

- `commands_used.txt` — record the exact commands you actually executed.
- `docs/task-summary.md` — task overview.
- `docs/reflection.md` — complete the reflection using what you observed.
- `reports/log_analysis_report.md` — analysis notes.
- `logs/` — sample log and error report.
- `evidence/screenshots/` — your own screenshots.

### Short command explanations

- **grep:** searches text and prints lines matching a pattern.
- **chown:** changes the owner and/or group of a file or directory.
- **usermod:** modifies an existing user account; `-aG` appends a supplementary group without replacing existing supplementary groups.

## Push to GitHub using Git Bash

### 1. Install/check Git

Open Git Bash and run:

```bash
git --version
```

### 2. Extract this project ZIP

Extract the ZIP file, then in Git Bash change to the extracted project directory. Example (edit the path to match your computer):

```bash
cd "/c/Users/YOUR-WINDOWS-USERNAME/Downloads/Linux-Task-03-GitHub-Professional"
```

Tip: In File Explorer, open the extracted folder, right-click an empty area, and choose **Open Git Bash here** if that option is available.

### 3. Create an empty GitHub repository

On GitHub, create a repository named `Linux-Task-03` (or another name you prefer). For the simplest first push, do not initialize it with a README, license, or `.gitignore`, because these are already included locally. Copy the HTTPS repository URL.

### 4. Commit and push

Run these commands from the project folder in Git Bash:

```bash
git init
git add .
git status
git commit -m "Complete Linux Task 03 project documentation"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/Linux-Task-03.git
git push -u origin main
```

Replace `YOUR-USERNAME` and the repository URL with your own. If Git says `remote origin already exists`, run:

```bash
git remote set-url origin https://github.com/YOUR-USERNAME/Linux-Task-03.git
git push -u origin main
```

If Git asks you to authenticate, follow GitHub's browser or device login prompt. Do not put passwords or access tokens in this repository.

### 5. Verify the upload

Refresh your GitHub repository page and confirm that `README.md`, `commands_used.txt`, `docs/`, `logs/`, `reports/`, `scripts/`, and `evidence/` appear.

## Final checklist

- [ ] Completed Linux commands in an authorized Linux lab.
- [ ] Recorded exact commands in `commands_used.txt`.
- [ ] Added genuine screenshots to `evidence/screenshots/`.
- [ ] Updated the reflection to match actual observations.
- [ ] Reviewed `git status` before committing.
- [ ] Pushed successfully and checked the repository online.
