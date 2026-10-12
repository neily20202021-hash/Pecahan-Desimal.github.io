# ==============================================================================
# SCRIPT R INTERAKTIF (BASE R) - SIMULASI CAT MATEMATIKA SD
# MATERI: PECAHAN & DESIMAL
# ==============================================================================
# Petunjuk Penggunaan:
# 1. Jalankan script ini langsung di R Console atau RStudio dengan perintah:
#    source("cat_konsol.R")
# 2. Tidak memerlukan instalasi package tambahan (100% Base R).
# ==============================================================================

# Aturan berhenti tes
JUMLAH_SOAL_TES <- 6

# Bank Soal (Tepat 10 Butir Soal)
bank_soal <- list(
  # Level 1 (Sangat Mudah)
  list(
    id = 1, topik = "Pecahan", level = 1,
    soal = "Sebuah pizza dipotong menjadi 4 bagian sama besar. Siti memakan 1 bagian pizza. Bagian yang dimakan Siti dalam pecahan adalah ...",
    opsi = c("1/4", "1/3", "3/4", "4/1"),
    jawaban_benar = 1, # Kunci: A
    pembahasan = "Siti memakan 1 bagian dari total 4 bagian sama besar = 1/4."
  ),
  list(
    id = 2, topik = "Desimal", level = 1,
    soal = "Pecahan 1/10 (satu persepuluh) jika ditulis ke dalam bentuk desimal adalah ...",
    opsi = c("0,01", "0,1", "1,0", "0,001"),
    jawaban_benar = 2, # Kunci: B
    pembahasan = "Pecahan 1/10 bernilai satu angka di belakang koma, yaitu 0,1."
  ),

  # Level 2 (Mudah)
  list(
    id = 3, topik = "Pecahan", level = 2,
    soal = "Pecahan berikut yang senilai dengan 2/3 adalah ...",
    opsi = c("3/4", "4/9", "4/6", "5/6"),
    jawaban_benar = 3, # Kunci: C
    pembahasan = "Kalikan pembilang dan penyebut dengan 2: (2 x 2) / (3 x 2) = 4/6."
  ),
  list(
    id = 4, topik = "Desimal", level = 2,
    soal = "Perhatikan bilangan desimal: 0,7 dan 0,45. Tanda perbandingan yang tepat adalah ...",
    opsi = c("0,7 < 0,45", "0,7 = 0,45", "0,7 <= 0,45", "0,7 > 0,45"),
    jawaban_benar = 4, # Kunci: D
    pembahasan = "0,7 senilai dengan 0,70. Karena 0,70 lebih besar dari 0,45, maka 0,7 > 0,45."
  ),

  # Level 3 (Sedang)
  list(
    id = 5, topik = "Pecahan", level = 3,
    soal = "Hasil penjumlahan dari 1/2 + 1/3 adalah ...",
    opsi = c("2/5", "5/6", "2/6", "1/6"),
    jawaban_benar = 2, # Kunci: B
    pembahasan = "Samakan penyebut dengan KPK 6: 3/6 + 2/6 = 5/6 (jangan jumlahkan langsung 2/5)."
  ),
  list(
    id = 6, topik = "Desimal", level = 3,
    soal = "Pada bilangan desimal 13,85, angka 8 menempati nilai tempat ...",
    opsi = c("Satuan", "Puluhan", "Persepuluhan", "Perseratusan"),
    jawaban_benar = 3, # Kunci: C
    pembahasan = "Angka pertama setelah tanda koma menempati nilai persepuluhan (1/10)."
  ),

  # Level 4 (Sulit)
  list(
    id = 7, topik = "Pecahan", level = 4,
    soal = "Hasil perkalian dari 3/4 x 2/5 dalam bentuk paling sederhana adalah ...",
    opsi = c("3/10", "5/9", "6/9", "15/8"),
    jawaban_benar = 1, # Kunci: A
    pembahasan = "(3 x 2) / (4 x 5) = 6/20 disederhanakan dibagi 2 menjadi 3/10."
  ),
  list(
    id = 8, topik = "Desimal", level = 4,
    soal = "Hasil dari pengurangan desimal 4,2 - 1,75 adalah ...",
    opsi = c("3,55", "2,55", "2,45", "3,45"),
    jawaban_benar = 3, # Kunci: C
    pembahasan = "Sejajarkan koma: 4,20 - 1,75 = 2,45."
  ),

  # Level 5 (Sangat Sulit)
  list(
    id = 9, topik = "Pecahan", level = 5,
    soal = "Pak Budi menanami kebunnya: 2/5 jagung dan 0,35 cabai. Sisanya dibuat kolam ikan. Bagian kolam ikan dalam pecahan sederhana adalah ...",
    opsi = c("1/2", "3/10", "1/5", "1/4"),
    jawaban_benar = 4, # Kunci: D
    pembahasan = "2/5 = 0,40. Total = 0,40 + 0,35 = 0,75. Sisa kolam = 1 - 0,75 = 0,25 = 1/4."
  ),
  list(
    id = 10, topik = "Desimal", level = 5,
    soal = "Urutan bilangan dari yang TERKECIL ke terbesar: 0,6 ; 45% ; 1/2 ; 0,25 adalah ...",
    opsi = c("0,25 ; 45% ; 1/2 ; 0,6", "45% ; 0,6 ; 0,25 ; 1/2", "0,6 ; 1/2 ; 45% ; 0,25", "0,25 ; 1/2 ; 45% ; 0,6"),
    jawaban_benar = 1, # Kunci: A
    pembahasan = "Semua ke desimal: 0,25 ; 0,45 (45%) ; 0,50 (1/2) ; 0,60 (0,6)."
  )
)

# Fungsi Memilih Soal Pertama (Level 3 Acak)
pilih_soal_pertama <- function() {
  soal_l3 <- Filter(function(s) s$level == 3, bank_soal)
  sample(soal_l3, 1)[[1]]
}

# Fungsi Memilih Soal Berikutnya (Adaptif & Fallback Level Terdekat)
pilih_soal_berikutnya <- function(level_target, id_terpakai) {
  # 1. Cek level target
  soal_target <- Filter(function(s) s$level == level_target && !(s$id %in% id_terpakai), bank_soal)
  if (length(soal_target) > 0) {
    return(sample(soal_target, 1)[[1]])
  }
  # 2. Cek level terdekat (bawah dulu lalu atas)
  for (delta in 1:4) {
    bawah <- level_target - delta
    if (bawah >= 1) {
      s_bawah <- Filter(function(s) s$level == bawah && !(s$id %in% id_terpakai), bank_soal)
      if (length(s_bawah) > 0) return(sample(s_bawah, 1)[[1]])
    }
    atas <- level_target + delta
    if (atas <= 5) {
      s_atas <- Filter(function(s) s$level == atas && !(s$id %in% id_terpakai), bank_soal)
      if (length(s_atas) > 0) return(sample(s_atas, 1)[[1]])
    }
  }
  return(NULL)
}

# Fungsi Utama Menjalankan Tes di Konsol
jalankan_cat <- function() {
  cat("\n=================================================================\n")
  cat("     LATIHAN COMPUTERIZED ADAPTIVE TESTING (CAT) MATEMATIKA SD   \n")
  cat("                   Materi: Pecahan & Desimal                     \n")
  cat("=================================================================\n\n")

  nama_siswa <- readline(prompt = "Masukkan Nama Siswa: ")
  while (nchar(trimws(nama_siswa)) == 0) {
    nama_siswa <- readline(prompt = "Nama tidak boleh kosong. Masukkan Nama Siswa: ")
  }

  cat(paste0("\nHalo, ", nama_siswa, "! Tes terdiri dari ", JUMLAH_SOAL_TES, " soal.\n"))
  cat("Tingkat kesulitan soal akan menyesuaikan jawabanmu secara otomatis.\n")
  cat("-----------------------------------------------------------------\n\n")

  riwayat <- list()
  soal_aktif <- pilih_soal_pertama()
  huruf_opsi <- c("A", "B", "C", "D")

  for (i in 1:JUMLAH_SOAL_TES) {
    cat(paste0("[Soal ", i, " dari ", JUMLAH_SOAL_TES, "] (Level ", soal_aktif$level, " - Topik: ", soal_aktif$topik, ")\n"))
    cat(soal_aktif$soal, "\n\n")

    for (j in seq_along(soal_aktif$opsi)) {
      cat(paste0("  (", huruf_opsi[j], ") ", soal_aktif$opsi[j], "\n"))
    }

    # Input respon siswa
    repeat {
      jawaban_input <- toupper(trimws(readline(prompt = "Pilih jawabanmu (A/B/C/D): ")))
      if (jawaban_input %in% huruf_opsi) {
        jawaban_idx <- which(huruf_opsi == jawaban_input)
        break
      } else {
        cat("Pilihan tidak valid. Silakan ketik A, B, C, atau D.\n")
      }
    }

    is_benar <- (jawaban_idx == soal_aktif$jawaban_benar)

    # Simpan ke riwayat
    riwayat[[i]] <- list(
      soal = soal_aktif,
      jawaban_siswa = jawaban_idx,
      is_benar = is_benar,
      level = soal_aktif$level
    )

    cat("\n-----------------------------------------------------------------\n\n")

    # Jika belum selesai, tentukan soal berikutnya
    if (i < JUMLAH_SOAL_TES) {
      level_target <- if (is_benar) min(5, soal_aktif$level + 1) else max(1, soal_aktif$level - 1)
      id_terpakai <- sapply(riwayat, function(r) r$soal$id)
      soal_aktif <- pilih_soal_berikutnya(level_target, id_terpakai)
    }
  }

  # ============================================================================
  # LAPORAN HASIL TES
  # ============================================================================
  jml_benar <- sum(sapply(riwayat, function(r) r$is_benar))
  jml_salah <- JUMLAH_SOAL_TES - jml_benar
  skor <- round((jml_benar / JUMLAH_SOAL_TES) * 100)

  kategori <- if (skor >= 80) "Sangat Baik" else if (skor >= 60) "Baik" else if (skor >= 40) "Cukup" else "Perlu Bimbingan"

  lvl_benar <- sapply(Filter(function(r) r$is_benar, riwayat), function(r) r$level)
  lvl_tertinggi <- if (length(lvl_benar) > 0) paste("Level", max(lvl_benar)) else "-"

  lintasan <- paste(sapply(riwayat, function(r) paste0("L", r$level)), collapse = " -> ")

  cat("=================================================================\n")
  cat("                      HASIL EVALUASI SISWA                       \n")
  cat("=================================================================\n")
  cat(paste0("Nama Siswa            : ", nama_siswa, "\n"))
  cat(paste0("Jumlah Soal Selesai   : ", JUMLAH_SOAL_TES, " Soal\n"))
  cat(paste0("Jawaban Benar         : ", jml_benar, " Soal\n"))
  cat(paste0("Jawaban Salah         : ", jml_salah, " Soal\n"))
  cat(paste0("Skor Akhir            : ", skor, " / 100\n"))
  cat(paste0("Kategori Predikat     : ", kategori, "\n"))
  cat(paste0("Level Tertinggi Benar : ", lvl_tertinggi, "\n"))
  cat(paste0("Lintasan Tingkat Soal : ", lintasan, "\n\n"))

  # Ringkasan Topik
  cat("--- RINGKASAN PER TOPIK ---\n")
  topik_list <- unique(sapply(riwayat, function(r) r$soal$topik))
  saran_ulang <- c()
  for (tp in topik_list) {
    sub_r <- Filter(function(r) r$soal$topik == tp, riwayat)
    b <- sum(sapply(sub_r, function(x) x$is_benar))
    s <- length(sub_r) - b
    cat(paste0("- Topik ", tp, ": ", length(sub_r), " soal (Benar: ", b, ", Salah: ", s, ")\n"))
    if (s > 0) saran_ulang <- c(saran_ulang, tp)
  }

  cat("\n--- SARAN PEMBELAJARAN ---\n")
  if (length(saran_ulang) > 0) {
    cat(paste0("Disarankan untuk mengulang latihan pada materi: ", paste(unique(saran_ulang), collapse = " dan "), ".\n"))
  } else {
    cat("Luar biasa! Seluruh materi Pecahan dan Desimal telah dikuasai dengan sempurna!\n")
  }

  cat("\n=================================================================\n")
  cat("                     PEMBAHASAN BUTIR SOAL                       \n")
  cat("=================================================================\n")
  for (k in seq_along(riwayat)) {
    item <- riwayat[[k]]
    status_teks <- if (item$is_benar) "[BENAR]" else "[SALAH]"
    cat(paste0("Soal ", k, " (Level ", item$level, " - ", item$soal$topik, ") ", status_teks, "\n"))
    cat(item$soal$soal, "\n")
    cat(paste0("  Jawabanmu : (", huruf_opsi[item$jawaban_siswa], ") ", item$soal$opsi[item$jawaban_siswa], "\n"))
    if (!item$is_benar) {
      cat(paste0("  Kunci Benar: (", huruf_opsi[item$soal$jawaban_benar], ") ", item$soal$opsi[item$soal$jawaban_benar], "\n"))
    }
    cat(paste0("  Pembahasan: ", item$soal$pembahasan, "\n\n"))
  }

  cat("Catatan: Hasil ini hanya gambaran awal untuk latihan, bukan penilaian resmi.\n")
  cat("=================================================================\n")
}

# Jalankan fungsi tes
jalankan_cat()
