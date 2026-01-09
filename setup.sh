#!/bin/bash
set -e

# 1. Hard Reset (Membersihkan sistem lama agar steril)
echo "🧹 Membersihkan sistem lama..."
rm -rf src data .gemini logs venv __pycache__ *.log *.db
# Note: PLANNING.md, requirements.txt, .gitignore tidak dihapus.

# 2. Install System Dependencies
echo "📦 Install System Dependencies..."
apt-get update > /dev/null
apt-get install -y python3-full python3-venv sqlite3 > /dev/null

# 3. Setup Virtual Environment
echo "🛠️  Setup Virtual Environment..."
python3 -m venv venv

# 4. Install Python Libraries
echo "⬇️  Install Python Libraries..."
./venv/bin/pip install --upgrade pip > /dev/null
./venv/bin/pip install -r requirements.txt

# 5. Auto-activate shortcut
if ! grep -q "source $(pwd)/venv/bin/activate" ~/.bashrc; then
    echo "source $(pwd)/venv/bin/activate" >> ~/.bashrc
fi

echo ""
echo "✨ SETUP FINAL SELESAI."
echo "--------------------------------------------------"
echo "WAJIB: Ketik perintah ini sebelum memanggil Gemini:"
echo "source venv/bin/activate"