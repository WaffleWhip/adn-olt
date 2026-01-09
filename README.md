# ADN OLT - Autonomous Network Agent

![Status](https://img.shields.io/badge/Status-Operational-green)
![Security](https://img.shields.io/badge/Security-AES256%20Encrypted-blue)
![Architecture](https://img.shields.io/badge/Architecture-Agentic%20AI-orange)

## 📋 Executive Summary
**ADN OLT** adalah sistem otomatisasi jaringan cerdas (Autonomous Agent) yang dirancang untuk menyederhanakan pengelolaan infrastruktur OLT Multi-Vendor (Huawei, ZTE, Nokia, Fiberhome).

Sistem ini menghilangkan kompleksitas perintah CLI manual dengan menyediakan **Antarmuka Bahasa Manusia (Natural Language Interface)**. Berbeda dengan software monitoring biasa, ADN OLT bertindak sebagai "Digital Engineer" yang mampu mengeksekusi konfigurasi, memperbaiki logika koneksi sendiri (*Self-Healing*), dan menjaga keamanan kredensial dengan standar industri.

---

## 🤖 AI Interaction Workflow
Sistem ini tidak mengharuskan user menghafal perintah CLI Linux. User cukup memberikan instruksi dalam Bahasa Indonesia/Inggris, dan Agent akan menerjemahkannya menjadi eksekusi kode Python yang aman.

Berikut adalah **3 Contoh Skenario Penggunaan** sehari-hari:

### Skenario 1: Registrasi Perangkat Baru
**User Prompt:**
> "Tolong tambahkan OLT Huawei baru dengan IP 10.14.35.114. Usernya 'huawei' dan passwordnya 'huawei123'. Langsung cek koneksinya."

**AI Response (Expectation):**
> "Siap. Sedang memproses enkripsi kredensial dan registrasi...
> ... (AI menjalankan script `src/main.py add` di background) ...
>
> **✅ Laporan:**
> * **Target:** 10.14.35.114 (Huawei)
> * **Protokol:** SSH (Port 22) - *Connected*
> * **Status:** **ONLINE**
> * **Uptime:** 2 Hari 5 Jam
>
> Perangkat berhasil disimpan ke database inventory."

---

### Skenario 2: Monitoring & Health Check
**User Prompt:**
> "Coba scan semua OLT sekarang dan tampilkan tabel statusnya. Apakah ada yang offline?"

**AI Response (Expectation):**
> "Melakukan scanning ke seluruh database inventory...
>
> **📊 ADN OLT Inventory Status:**
> | IP Address | Vendor | Protocol | Status | Uptime |
> | :--- | :--- | :--- | :--- | :--- |
> | 10.14.35.115 | Nokia | SSH | 🟢 ONLINE | 45d 12h |
> | 10.14.35.118 | ZTE | Telnet | 🟢 ONLINE | 12d 4h |
> | 10.14.35.116 | Huawei | SSH | 🟢 ONLINE | 2d 5h |
>
> **Kesimpulan:** Semua 7 perangkat terpantau **SEHAT (Online)**. Tidak ada insiden yang terdeteksi."

---

### Skenario 3: Troubleshooting Cerdas
**User Prompt:**
> "Tadi OLT Fiberhome sempat gagal connect. Tolong cek log error-nya dan jelaskan kenapa."

**AI Response (Expectation):**
> "Menganalisa log error terakhir untuk Fiberhome...
>
> **⚠️ Temuan Error:** `NetmikoTimeoutException` pada Port 22 (SSH).
> **Analisa:** Perangkat menolak koneksi SSH.
> **Tindakan Otomatis:** Sistem telah melakukan *Fallback* ke Telnet (Port 23) dan koneksi berhasil dipulihkan.
>
> **Status Saat Ini:** Online (via Telnet). Tidak perlu tindakan manual."

---

## 🚀 Key Capabilities & Value

### 1. Universal Multi-Vendor Support
Satu sistem terpusat untuk mengelola berbagai merk tanpa pusing memikirkan perbedaan sintaks CLI.
* **Huawei:** Dilengkapi fitur *Anti-Paging Fix* (mengatasi error login `screen-length`).
* **ZTE:** Deteksi otomatis port SSH/Telnet (Auto-Switching).
* **Nokia & Fiberhome:** Driver khusus yang dioptimalkan.

### 2. Enterprise-Grade Security
* **Enkripsi AES-256:** Password database tidak bisa dibaca manusia (Ciphertext).
* **Strict Folder Policy:** Mencegah kebocoran file log/script ke direktori root.
* **Audit Trail:** Semua aktivitas tercatat di folder `logs/`.

### 3. Clean Architecture
Sistem dibangun modular agar mudah dirawat dan dikembangkan.

```text
/root/adn-olt/
├── src/               <-- BRAIN (Logika Python)
│   ├── main.py        # Orchestrator (Pusat Komando)
│   ├── connector.py   # Driver OLT (SSH/Telnet Handler)
│   └── security.py    # Modul Enkripsi
├── data/              <-- MEMORY (Database)
│   ├── adn.db         # Inventory & Logs (SQLite)
│   └── secret.key     # Kunci Rahasia
└── logs/              <-- AUDIT (Rekaman Aktivitas)
```

---

## 🛠️ Deployment Guide (Golden Seed)
Sistem ini menggunakan metode deployment "Single Script". Tidak perlu konfigurasi manual yang rumit.

### Langkah Instalasi:

1. **Siapkan Environment:** Pastikan file `setup.sh`, `requirements.txt`, dan `PLANNING.md` sudah ada.

2. **Jalankan Instalasi:**
```bash
chmod +x setup.sh
./setup.sh
```

3. **Aktifkan Agent:**
```bash
source venv/bin/activate
# Lalu panggil agent AI Anda
```

---

*Developed for Network Operations Automation*