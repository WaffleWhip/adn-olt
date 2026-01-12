# ADN OLT - Autonomous Driven Network for OLT Management

![Status](https://img.shields.io/badge/Status-Operational-green)
![Security](https://img.shields.io/badge/Security-AES256%20Encrypted-blue)
![Architecture](https://img.shields.io/badge/Architecture-Agentic%20AI-orange)
![AI](https://img.shields.io/badge/AI-Google%20Gemini-4285F4)

## 📋 Executive Summary
**ADN OLT** (**Autonomous Driven Network** for OLT Management) adalah sistem otomatisasi jaringan cerdas berbasis **Google Gemini AI** yang dirancang untuk menyederhanakan pengelolaan infrastruktur OLT Multi-Vendor (Huawei, ZTE, Nokia, Fiberhome).

Sistem ini menghilangkan kompleksitas perintah CLI manual dengan menyediakan **Antarmuka Bahasa Manusia (Natural Language Interface)**. Berbeda dengan software monitoring biasa, ADN OLT bertindak sebagai "Digital Engineer" yang mampu mengeksekusi konfigurasi, memperbaiki logika koneksi sendiri (*Self-Healing*), dan menjaga keamanan kredensial dengan standar industri.

---

## 🤖 AI-Powered Development Workflow

Sistem ini dikembangkan menggunakan pendekatan **AI-Driven Development** dengan **Google Gemini** sebagai co-developer:

### Cara Kerja:
1. **AI membaca `PLANNING.md`** → Dokumen blueprint berisi spesifikasi teknis, arsitektur, dan requirement sistem
2. **AI menghasilkan kode** → Berdasarkan planning, Gemini auto-generate file Python:
   - `src/main.py` → Orchestrator utama sistem
   - `src/connector.py` → Driver koneksi SSH/Telnet untuk setiap vendor OLT
   - `src/security.py` → Module enkripsi AES-256 untuk credential
   - `src/database.py` → Handler SQLite untuk inventory management
3. **Human review & iterate** → Developer review, testing, dan feedback untuk perbaikan

### Natural Language Interface
User tidak perlu menghafal perintah CLI Linux. Cukup berikan instruksi dalam **Bahasa Indonesia/Inggris**, dan Gemini Agent akan menerjemahkannya menjadi eksekusi kode Python yang aman.

---

## 💬 Contoh Skenario Penggunaan

#### Skenario 1: Registrasi Perangkat Baru
**User:**
> "Tolong tambahkan OLT Huawei baru dengan IP 10.14.35.114. Usernya 'huawei' dan passwordnya 'huawei123'. Langsung cek koneksinya."

**AI Response:**
```
Siap. Sedang memproses enkripsi kredensial dan registrasi...
(AI menjalankan script src/main.py add di background)

✅ Laporan:
• Target: 10.14.35.114 (Huawei)
• Protokol: SSH (Port 22) - Connected
• Status: ONLINE
• Uptime: 2 Hari 5 Jam

Perangkat berhasil disimpan ke database inventory.
```

---

#### Skenario 2: Monitoring & Health Check
**User:**
> "Coba scan semua OLT sekarang dan tampilkan tabel statusnya. Apakah ada yang offline?"

**AI Response:**
```
Melakukan scanning ke seluruh database inventory...

📊 ADN OLT Inventory Status:
┌──────────────────┬──────────┬──────────┬──────────┬──────────┐
│ IP Address       │ Vendor   │ Protocol │ Status   │ Uptime   │
├──────────────────┼──────────┼──────────┼──────────┼──────────┤
│ 10.14.35.115     │ Nokia    │ SSH      │ 🟢 ONLINE│ 45d 12h  │
│ 10.14.35.118     │ ZTE      │ Telnet   │ 🟢 ONLINE│ 12d 4h   │
│ 10.14.35.116     │ Huawei   │ SSH      │ 🟢 ONLINE│ 2d 5h    │
└──────────────────┴──────────┴──────────┴──────────┴──────────┘

Kesimpulan: Semua 7 perangkat terpantau SEHAT (Online). 
Tidak ada insiden yang terdeteksi.
```

---

#### Skenario 3: Troubleshooting Cerdas
**User:**
> "Tadi OLT Fiberhome sempat gagal connect. Tolong cek log error-nya dan jelaskan kenapa."

**AI Response:**
```
Menganalisa log error terakhir untuk Fiberhome...

⚠️ Temuan Error: NetmikoTimeoutException pada Port 22 (SSH)
📌 Analisa: Perangkat menolak koneksi SSH
🔄 Tindakan Otomatis: Sistem telah melakukan Fallback ke Telnet (Port 23)
   dan koneksi berhasil dipulihkan.

Status Saat Ini: Online (via Telnet). Tidak perlu tindakan manual.
```

---

## 🚀 Key Capabilities

### 1. 🔌 Universal Multi-Vendor Support
Satu sistem terpusat untuk mengelola berbagai merk tanpa pusing memikirkan perbedaan sintaks CLI:
- **Huawei** → Fitur *Anti-Paging Fix* (mengatasi error login `screen-length`)
- **ZTE** → Deteksi otomatis port SSH/Telnet (Auto-Switching)
- **Nokia & Fiberhome** → Driver khusus yang dioptimalkan

### 2. 🔒 Enterprise-Grade Security
- **Enkripsi AES-256** → Password database tidak bisa dibaca manusia (Ciphertext)
- **Strict Folder Policy** → Mencegah kebocoran file log/script ke direktori root
- **Audit Trail** → Semua aktivitas tercatat di folder `logs/`

### 3. Clean Architecture
Sistem dibangun modular agar mudah dirawat dan dikembangkan. File-file ini akan di-generate oleh AI berdasarkan `PLANNING.md`:

```text
adn-olt/
├── src/               # 🧠 BRAIN (Logika Python)
│   ├── main.py        #   → Orchestrator - Auto-generated by AI
│   ├── connector.py   #   → Driver OLT SSH/Telnet - Auto-generated by AI
│   ├── security.py    #   → Modul Enkripsi AES-256 - Auto-generated by AI
│   └── database.py    #   → SQLite Handler - Auto-generated by AI
│
├── data/              # 💾 MEMORY (Database)
│   ├── adn.db         #   → Inventory & Logs (SQLite)
│   └── secret.key     #   → Kunci Enkripsi Rahasia
│
├── logs/              # 📋 AUDIT (Rekaman Aktivitas)
│
├── PLANNING.md        # 🤖 AI Blueprint (dibaca oleh Gemini)
├── README.md          # 📖 Dokumentasi
├── requirements.txt   # 📦 Dependencies Python
├── setup.sh           # ⚙️ Auto-installer Script
└── gemini.sh          # 🔧 Gemini CLI Installer (Proxmox LXC)
```

---

## 🛠️ Deployment Guide

Sistem ini menggunakan metode deployment **"Single Script"** dengan integrasi **Gemini CLI**.

### Prerequisites: Install Gemini CLI (Opsional - jika belum ada)

#### 🔧 Opsi 1: Automated Setup via Proxmox Container (Recommended)

Jika Anda menggunakan Proxmox, gunakan script otomatis `gemini.sh` untuk membuat LXC container secara otomatis:

```bash
chmod +x gemini.sh
./gemini.sh
```

**Apa yang dilakukan `gemini.sh`:**
1. ✅ Update template database Proxmox
2. ✅ Deteksi Debian template terbaru secara otomatis
3. ✅ Buat LXC Container dengan konfigurasi:
   - **ID Container**: 100 (dapat disesuaikan di script)
   - **OS**: Debian Latest
   - **RAM**: 4GB
   - **CPU**: Unlimited (default sistem)
   - **Storage**: Auto-detect
   - **Network**: DHCP (automatic IP assignment)
   - **Root Password**: `telkom123` (dapat disesuaikan)
4. ✅ Install SSH server untuk akses remote
5. ✅ Install Node.js (latest version)
6. ✅ Install Gemini CLI via npm
7. ✅ Enable auto-start on boot

**Output setelah sukses:**
```
SUCCESS: Gemini-CLI is ready!
Container ID  : 100
RAM           : 4GB
CPU           : Unlimited (Host Default)
Persistence   : Enabled (Start on boot)
Container IP  : 10.x.x.x (auto-assigned)
SSH Command   : ssh root@10.x.x.x
Gemini Command: gemini
```

**Akses container:**
```bash
# Via SSH
ssh root@<container-ip>

# Via Proxmox console
pct exec 100 bash
```

---

#### 🐧 Opsi 2: Manual Installation (jika tidak pakai Proxmox)

```bash
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
apt install -y nodejs

# Install Gemini CLI
npm install -g @google/gemini-cli
```

---

#### 📝 Customizing `gemini.sh`:

Edit file `gemini.sh` untuk menyesuaikan konfigurasi:
```bash
CTID="100"              # Container ID (ubah jika 100 sudah digunakan)
HOSTNAME="Gemini-CLI"   # Nama hostname container
BRIDGE="vmbr0"          # Network bridge (sesuaikan dengan Proxmox Anda)
PASSWORD="telkom123"    # Root password
RAM="4096"              # RAM dalam MB (4096 = 4GB)
```

---

### Langkah Instalasi ADN OLT:

1. **Clone repository:**
   ```bash
   git clone https://github.com/WaffleWhip/adn-olt.git
   cd adn-olt
   ```

2. **Setup Python environment:**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Aktifkan virtual environment:**
   ```bash
   source venv/bin/activate
   ```

4. **Login Gemini AI (first time only):**
   ```bash
   gemini --yolo
   ```
   
   **Proses login:**
   - CLI akan menampilkan link login Google
   - Buka link di browser dan login dengan Google Account
   - Copy token yang muncul setelah login
   - Paste token ke CLI
   - Login berhasil ✅

5. **Jalankan AI Agent untuk generate code:**
   ```bash
   gemini
   ```
   
   **Instruksi ke AI:**
   > "Tolong baca file PLANNING.md dan generate semua file Python yang diperlukan sesuai spesifikasi. Implementasikan semua fitur yang ada di blueprint tersebut."
   
   AI akan otomatis membuat:
   - `src/main.py` → CLI orchestrator
   - `src/connector.py` → Multi-vendor OLT driver
   - `src/security.py` → AES-256 encryption module
   - `src/database.py` → SQLite inventory handler

---

*Developed for Network Operations Automation*