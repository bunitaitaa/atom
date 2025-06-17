---

### 📄 `README.md`

````markdown
# Panduan Instalasi AtoM 2.9.x dengan Docker

Dokumen ini menjelaskan langkah-langkah instalasi AtoM (Access to Memory) versi 2.9.x menggunakan Docker dan Docker Compose secara otomatis menggunakan skrip `install-atom.sh`.

## Persyaratan Sistem

- Ubuntu 20.04 atau 22.04 (direkomendasikan)
- Akses internet
- Akses `sudo` ke terminal
- Git sudah terinstal

## Langkah Instalasi

1. **Unduh skrip instalasi:**
   Simpan file `install-atom.sh` di direktori mana pun.

2. **Beri izin eksekusi:**

   ```bash
   chmod +x install-atom.sh
````

3. **Jalankan skrip:**

   ```bash
   ./install-atom.sh
   ```

   Skrip ini akan:

   * Menginstal Docker dan Docker Compose
   * Meng-clone repositori AtoM versi stable/2.9.x
   * Menjalankan kontainer AtoM dan dependensinya
   * Purge database dan isi data demo
   * Kompilasi tema Bootstrap 5 dan 2
   * Menghapus cache dan me-restart semua kontainer

## Akses AtoM

Setelah instalasi selesai, buka browser dan akses:

```
http://localhost:63001
```

Login default:

* **Email:** `demo@example.com`
* **Password:** `demo`

## Penggunaan Lanjutan

Untuk menghentikan semua kontainer:

```bash
sudo docker compose -f docker/docker-compose.dev.yml down
```

Untuk menjalankannya kembali:

```bash
sudo docker compose -f docker/docker-compose.dev.yml up -d
```

## Troubleshooting

* Jika halaman menampilkan error layout: pastikan `npm run build` berhasil.
* Jika tidak bisa login: pastikan database sudah di-purge dengan demo (`tools:purge --demo`).
* Jika menggunakan port selain default, sesuaikan `docker-compose.dev.yml` terlebih dahulu.

---

**AtoM (Access to Memory)** adalah perangkat lunak arsip berbasis web yang dikembangkan oleh Artefactual Systems, berbasis standar ICA.

```

---

Jika kamu ingin file `README.md` ini langsung dikirim sebagai file siap pakai atau ditambahkan ke repositorimu, cukup bilang.
```
