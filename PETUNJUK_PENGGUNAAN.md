# PANDUAN PENGGUNAAN & DOKUMENTASI TEKNIS
## Aplikasi CAT (Computerized Adaptive Testing) Matematika SD
### Materi: Pecahan & Desimal

---

### 1. Deskripsi Singkat
Aplikasi ini adalah media latihan asesmen adaptif berbasis komputer (**Computerized Adaptive Testing / CAT**) sederhana yang dirancang khusus untuk siswa Sekolah Dasar (SD). Aplikasi berjalan dalam **SATU file mandiri (`index.html`)** tanpa ketergantungan server (*backend*) atau pustaka eksternal (*zero-dependency*), sehingga dapat dibuka secara langsung di peramban web (*browser*) mana pun baik secara *offline* maupun *online*.

---

### 2. Cara Menjalankan Aplikasi
1. Buka folder tempat file disimpan:
   `d:\S3 PENELITIAN DAN EVALUASI PENDIDIKAN\SEMESTER 1\Asesmen Berbasis Komputer\Belajar Tugas 1\`
2. Klik ganda (*double click*) file **`index.html`**, atau klik kanan lalu pilih **Open With** &rarr; **Google Chrome**, **Microsoft Edge**, atau **Mozilla Firefox**.
3. Aplikasi akan langsung tampil dan siap digunakan.

---

### 3. Alur Penggunaan Siswa
1. **Halaman Awal:**
   - Masukkan nama siswa pada kolom input.
   - Baca petunjuk singkat latihan.
   - Klik tombol **"Mulai Latihan Sekarang 🚀"**.
2. **Halaman Soal:**
   - Siswa mengerjakan soal satu per satu (satu layar satu butir soal).
   - Menampilkan nomor soal ("Soal X dari 6"), *progress bar*, lencana tingkat kesulitan (*level*), dan topik.
   - Pilih salah satu dari 4 opsi jawaban (A, B, C, atau D).
   - Tombol **"Jawab & Lanjut ➔"** akan aktif setelah salah satu opsi dipilih.
   - *Catatan:* Hasil benar/salah sengaja **tidak ditampilkan di tengah tes** agar siswa tetap fokus dan menjaga validitas adaptasi.
3. **Halaman Hasil:**
   - Menampilkan nama siswa, skor akhir (0–100), dan predikat/kategori (**Perlu Bimbingan**, **Cukup**, **Baik**, atau **Sangat Baik**).
   - Menampilkan metrik butir benar, butir salah, dan **Level Tertinggi yang Berhasil Dijawab Benar**.
   - Menampilkan visualisasi **Jalur Adaptasi Tingkat Kesulitan** (contoh: `L3 ➔ L4 ➔ L3 ➔ L4 ➔ L5 ➔ L4`).
   - Menyajikan **Ringkasan Penguasaan per Topik** (Pecahan dan Desimal) serta saran topik yang perlu diperdalam.
   - Menyajikan daftar telaah lengkap butir soal, jawaban siswa, kunci jawaban benar, dan pembahasan edukatif.
   - Tersedia tombol **"🔄 Ulangi Tes"** dan **"🖨️ Cetak Hasil"** (`window.print()`).

---

### 4. Logika Adaptif (CAT Engine)
Sistem menggunakan algoritma adaptif bertingkat (*rule-based branched testing*):
1. **Soal Pertama:** Siswa selalu memulai dari **Level 3 (Sedang)** yang dipilih secara acak dari 2 butir soal level 3 yang tersedia.
2. **Kenaikan / Penurunan Level:**
   - Jika jawaban **BENAR**: Tingkat kesulitan soal berikutnya naik 1 level (maksimal level 5).
   - Jika jawaban **SALAH**: Tingkat kesulitan soal berikutnya turun 1 level (minimal level 1).
3. **Pencarian Butir Soal Terdekat (Fallback Logic):**
   - Sistem memprioritaskan butir yang belum pernah muncul pada level target.
   - Apabila seluruh butir soal pada level target telah terpakai, sistem secara otomatis mencari butir yang masih tersedia pada level terdekat dengan aturan: **cek satu level di bawah terlebih dahulu, lalu cek satu level di atas**.
4. **Aturan Berhenti (*Stopping Rule*):**
   - Tes secara otomatis berhenti tepat setelah siswa menyelesaikan **6 butir soal** (`JUMLAH_SOAL_TES = 6`).

---

### 5. Panduan Modifikasi & Kustomisasi Kode

Semua kode tersimpan rapi di dalam file **`index.html`** dan terbagi menjadi 4 bagian dengan komentar penjelas berbahasa Indonesia.

#### A. Cara Mengubah Jumlah Soal Tes
Buka file `index.html` dengan teks editor (Notepad, VS Code, atau editor lainnya), cari baris di bagian atas tag `<script>`:
```javascript
// Konstanta aturan berhenti tes
const JUMLAH_SOAL_TES = 6;
```
Ubah angka `6` menjadi jumlah butir soal yang diinginkan (misal `5` atau `8`), lalu simpan (*Save*). Pastikan jumlah soal tes tidak melebihi total butir yang tersedia di bank soal.

#### B. Cara Menambah Soal Baru ke Bank Soal
Pada array `bankSoal` di `index.html`, tambahkan objek soal baru mengikuti struktur baku berikut:
```javascript
{
  id: 11, // Pastikan ID unik dan belum digunakan
  topik: "Pecahan", // Topik: "Pecahan" atau "Desimal"
  level: 3, // Level kesulitan: 1 (sangat mudah) hingga 5 (sangat sulit)
  soal: 'Hasil dari 1/4 + 2/4 adalah ...', // Teks pertanyaan
  opsi: [
    '1/4',
    '2/4',
    '3/4',
    '4/4'
  ], // 4 pilihan jawaban [A, B, C, D]
  jawaban_benar: 2, // Indeks jawaban benar (0 = A, 1 = B, 2 = C, 3 = D)
  pembahasan: "Karena penyebutnya sudah sama, jumlahkan pembilang: 1 + 2 = 3. Hasilnya adalah 3/4."
}
```

*Tips Menulis Pecahan Bertingkat:*
Untuk membuat pecahan bertingkat yang rapi di layar, gunakan format tag HTML berikut:
```html
<span class="frac"><span class="frac-top">pembilang</span><span class="frac-bottom">penyebut</span></span>
```
Contoh untuk pecahan $\frac{3}{4}$:
```html
<span class="frac"><span class="frac-top">3</span><span class="frac-bottom">4</span></span>
```
