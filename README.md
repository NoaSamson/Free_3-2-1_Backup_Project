# 3-2-1 Backup sustav s Restic + Rclone (Windows)

## Opis projekta

Ovaj projekt demonstrira implementaciju **3-2-1 strategije sigurnosnih kopija** na Windows sustavu koristeći open‑source alate Restic i Rclone.

Cilj projekta nije samo napraviti kopiju podataka, nego dokazati da je moguće:

* automatizirati backup
* zaštititi podatke od ransomwarea i grešaka korisnika
* provesti potpunu obnovu sustava (disaster recovery)

---

## 3‑2‑1 pravilo

3‑2‑1 strategija nalaže:

* **3 kopije podataka** (original + 2 sigurnosne)
* **2 različita medija** (lokalni disk + eksterni disk)
* **1 off‑site kopija** (cloud)

U ovom projektu:

* Original: korisnički podaci na računalu
* Lokalna kopija: eksterni hard disk
* Off‑site kopija: Google Drive

---

## Arhitektura sustava

Komponente:

* Restic → backup i enkripcija podataka
* Rclone → pristup Google Driveu
* Windows Task Scheduler → automatizacija

Tijek:

1. Restic šifrira podatke lokalno
2. Kopija ide na eksterni disk
3. Druga kopija ide u cloud preko Rclonea
4. Disk se drži offline radi zaštite od ransomwarea

---

## Tehnologije

* Restic – deduplicirani i enkriptirani backup
* Rclone – povezivanje s cloud storageom
* Google Drive – off‑site kopija
* Windows Task Scheduler – periodično pokretanje skripti
* PowerShell – automatizacija

---

## Postavljanje sustava

### 1. Inicijalizacija repozitorija

Lokalni disk:

```
restic init --repo E:\restic-backup
```

Cloud:

```
restic -r rclone:gdrive:restic-backup init
```

### 2. Automatski backup

Pokretanje skripte putem Task Scheduler‑a jednom dnevno.

Skripta:

* provjerava postoji li eksterni disk
* radi lokalni backup ako je dostupan
* uvijek radi cloud backup
* briše stare verzije (retention policy)

---

## Sigurnosne mjere

* End‑to‑end enkripcija (Restic)
* Disk offline kada se ne koristi
* Lozinka spremljena u zaštićenom password fileu
* Google račun zaštićen 2FA autentifikacijom
* Periodični `restic check`

Zašto offline disk?
Ransomware šifrira sve dostupne diskove. Offline kopija ostaje netaknuta.

---

## Disaster recovery scenariji

### 1. Obrisan dokument

* pronaći snapshot
* vratiti datoteku pomoću restic restore

### 2. Pokvaren disk računala

* reinstall Windows
* instalirati restic + rclone
* restore iz clouda

### 3. Ransomware

* format diska
* restore zadnje zdrave verzije

---

## Testiranje

Projekt uključuje testne scenarije:

* vraćanje jedne datoteke
* vraćanje cijelog direktorija
* potpuni oporavak sustava

Backup koji nije testiran ne smatra se pouzdanim.

---

## Zaključak

Projekt pokazuje kako kombinacija lokalne i cloud kopije omogućuje:

* zaštitu od hardverskog kvara
* zaštitu od slučajnog brisanja
* zaštitu od malwarea

3‑2‑1 backup strategija predstavlja minimalni standard sigurnosti podataka u stvarnom sustavu.
