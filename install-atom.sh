#!/bin/bash

set -e

echo "Memulai instalasi AtoM 2.9.x dengan Docker..."

# 1. Install Docker & Compose
echo "Memeriksa & menginstal Docker jika belum ada..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin git

# 2. Clone repositori AtoM
echo "Meng-clone AtoM versi stable/2.9.x..."
git clone -b stable/2.9.x https://github.com/artefactual/atom.git atom
cd atom

# 3. Jalankan kontainer
echo "Menjalankan Docker Compose..."
sudo docker compose -f docker/docker-compose.dev.yml up -d

# 4. Tunggu kontainer siap
echo "Menunggu 10 detik agar semua kontainer siap..."
sleep 10

# 5. Purge database dan isi data demo
echo "Menghapus database dan mengisi data demo..."
sudo docker compose -f docker/docker-compose.dev.yml exec atom php -d memory_limit=-1 symfony tools:purge --demo

# 6. Restart worker
echo "Merestart atom_worker..."
sudo docker compose -f docker/docker-compose.dev.yml restart atom_worker

# 7. Kompilasi tema Bootstrap 5
echo "Mengompilasi tema Bootstrap 5..."
sudo docker compose -f docker/docker-compose.dev.yml exec atom npm install
sudo docker compose -f docker/docker-compose.dev.yml exec atom npm run build

# 8. Kompilasi tema Bootstrap 2
echo "Mengompilasi tema Bootstrap 2..."
sudo docker compose -f docker/docker-compose.dev.yml exec atom make -C plugins/arDominionPlugin

# 9. Clear cache
echo "Menghapus cache Symfony..."
sudo docker compose -f docker/docker-compose.dev.yml exec atom php symfony cc

# 10. Restart semua
echo "Merestart semua kontainer..."
sudo docker compose -f docker/docker-compose.dev.yml restart

# 11. Selesai
echo "Instalasi selesai. AtoM sekarang dapat diakses di:"
echo "http://localhost:63001"
echo "Login: demo@example.com / demo"
