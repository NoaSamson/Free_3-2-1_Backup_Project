# 3-2-1 Backup System using Restic + Rclone (Windows)

## Project Overview

This project demonstrates the implementation of a **3-2-1 backup strategy** on Windows using open‑source tools. The goal is to provide a reproducible, automated and secure backup solution capable of recovering data after accidental deletion, hardware failure or malware infection.

The system creates:

* a local offline backup on an external drive
* an off‑site encrypted cloud backup
* automated periodic execution

---

## What is the 3-2-1 rule?

The 3‑2‑1 backup strategy requires:

* **3 copies of data** (original + 2 backups)
* **2 different storage media** (internal + external disk)
* **1 off‑site copy** (cloud)

Implementation in this project:

* Original data → user files on PC
* Local backup → external hard drive
* Off‑site backup → Google Drive

---

## Technologies Used

* **Restic** – encrypted, deduplicated backups
* **Rclone** – cloud storage interface (Google Drive)
* **Windows Task Scheduler** – automation
* **PowerShell** – scripting

All tools are free and open‑source.

---

## System Architecture

1. Restic encrypts files locally before leaving the computer
2. Backup is written to an external drive
3. A second backup is uploaded to Google Drive via Rclone
4. The external drive is normally kept disconnected for ransomware protection

---

## Setup Guide

### 1. Configure Rclone (Google Drive)

```
rclone config
```

Create a new remote and authenticate in browser.

### 2. Initialize repositories

External drive:

```
restic init --repo E:\restic-backup
```

Cloud repository:

```
restic -r rclone:gdrive:restic-backup init
```

### 3. Password file (recommended)

```
echo strongpassword > C:\Users\USER\.restic-password
```

---

## Backup Script (PowerShell)

The script performs:

* detection of external drive
* local backup if present
* cloud backup always
* retention policy cleanup

The script is executed by Task Scheduler.

---

## Automation with Windows Task Scheduler

Create a scheduled task:

**Triggers**

* Daily (e.g. 02:00)
* At log on
* Run task as soon as possible after a missed start

**Action**

```
powershell -ExecutionPolicy Bypass -File C:\scripts\backup.ps1
```

This ensures:

* backup runs even if the PC was off at night
* automatic execution without user interaction
* external disk backup runs whenever the disk is connected

---

## Security Considerations

* End‑to‑end encryption before upload
* Offline external disk protects against ransomware
* Password stored in restricted file permissions
* Cloud account protected with 2FA

---

## Recovery Scenarios

The system supports recovery of:

* individual files
* entire directories
* full system after reinstall

Backups should be periodically tested using restore operations.

---

## Conclusion

This project demonstrates a practical and reproducible implementation of a secure 3‑2‑1 backup strategy using open‑source tools, combining automation, encryption and offline storage for reliable data protection.
 
 
*A portion of the text in this project was generated with the assistance of a large language model (ChatGPT) to facilitate faster content structuring and stylistic refinement. All examples, formulations, and guidelines were carefully reviewed and edited by the author.*
