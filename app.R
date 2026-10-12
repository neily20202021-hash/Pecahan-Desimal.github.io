# ==============================================================================
# APLIKASI COMPUTERIZED ADAPTIVE TESTING (CAT) MATEMATIKA SD
# MATERI: PECAHAN & DESIMAL (R SHINY APPLICATION)
# ==============================================================================
# Petunjuk:
# 1. Pastikan package 'shiny' terinstal (otomatis diinstal jika belum ada).
# 2. Buka script ini di RStudio, lalu klik tombol "Run App" (atau jalankan
#    perintah shiny::runApp() di konsol).
# ==============================================================================

if (!requireNamespace("shiny", quietly = TRUE)) {
  install.packages("shiny")
}
library(shiny)

# ==============================================================================
# 1. KONFIGURASI DAN BANK SOAL (TEPAT 10 SOAL)
# ==============================================================================

# Aturan berhenti tes (bisa disesuaikan sesuai kebutuhan)
JUMLAH_SOAL_TES <- 6

# Bank Soal: 5 Level kesulitan, masing-masing 2 butir soal
bank_soal <- list(
  # ----------------------------------------------------------------------------
  # LEVEL 1 (Sangat Mudah): Mengenal pecahan dan desimal sederhana
  # ----------------------------------------------------------------------------
  list(
    id = 1,
    topik = "Pecahan",
    level = 1,
    soal = 'Sebuah pizza dipotong menjadi 4 bagian sama besar. Siti memakan 1 bagian pizza tersebut. Bagian pizza yang dimakan Siti dapat ditulis dalam bentuk pecahan yaitu ...',
    opsi = c(
      '<span class="frac"><span class="top">1</span><span class="bottom">4</span></span>',
      '<span class="frac"><span class="top">1</span><span class="bottom">3</span></span>',
      '<span class="frac"><span class="top">3</span><span class="bottom">4</span></span>',
      '<span class="frac"><span class="top">4</span><span class="bottom">1</span></span>'
    ),
    jawaban_benar = 1, # Kunci: A
    pembahasan = "Siti memakan 1 bagian (pembilang) dari total 4 bagian sama besar (penyebut). Maka bentuk pecahannya adalah 1/4."
  ),
  list(
    id = 2,
    topik = "Desimal",
    level = 1,
    soal = 'Pecahan satu persepuluh (<span class="frac"><span class="top">1</span><span class="bottom">10</span></span>) jika ditulis ke dalam bentuk bilangan desimal adalah ...',
    opsi = c("0,01", "0,1", "1,0", "0,001"),
    jawaban_benar = 2, # Kunci: B
    pembahasan = "Pecahan persepuluhan (1/10) berarti terdapat satu angka di belakang koma, yaitu 0,1."
  ),

  # ----------------------------------------------------------------------------
  # LEVEL 2 (Mudah): Pecahan senilai, membandingkan pecahan/desimal
  # ----------------------------------------------------------------------------
  list(
    id = 3,
    topik = "Pecahan",
    level = 2,
    soal = 'Pecahan di bawah ini yang senilai dengan <span class="frac"><span class="top">2</span><span class="bottom">3</span></span> adalah ...',
    opsi = c(
      '<span class="frac"><span class="top">3</span><span class="bottom">4</span></span>',
      '<span class="frac"><span class="top">4</span><span class="bottom">9</span></span>',
      '<span class="frac"><span class="top">4</span><span class="bottom">6</span></span>',
      '<span class="frac"><span class="top">5</span><span class="bottom">6</span></span>'
    ),
    jawaban_benar = 3, # Kunci: C
    pembahasan = "Pecahan senilai diperoleh dengan mengalikan pembilang dan penyebut dengan angka yang sama. (2 × 2) / (3 × 2) = 4/6."
  ),
  list(
    id = 4,
    topik = "Desimal",
    level = 2,
    soal = "Perhatikan dua bilangan desimal berikut: <strong>0,7</strong> dan <strong>0,45</strong>. Tanda perbandingan yang paling tepat adalah ...",
    opsi = c("0,7 < 0,45", "0,7 = 0,45", "0,7 ≤ 0,45", "0,7 > 0,45"),
    jawaban_benar = 4, # Kunci: D
    pembahasan = "Samakan banyak angka di belakang koma: 0,7 = 0,70. Karena 0,70 lebih besar dari 0,45, perbandingannya adalah 0,7 > 0,45."
  ),

  # ----------------------------------------------------------------------------
  # LEVEL 3 (Sedang): Penjumlahan/pengurangan pecahan, nilai tempat desimal
  # ----------------------------------------------------------------------------
  list(
    id = 5,
    topik = "Pecahan",
    level = 3,
    soal = 'Hasil dari penjumlahan pecahan <span class="frac"><span class="top">1</span><span class="bottom">2</span></span> + <span class="frac"><span class="top">1</span><span class="bottom">3</span></span> adalah ...',
    opsi = c(
      '<span class="frac"><span class="top">2</span><span class="bottom">5</span></span>',
      '<span class="frac"><span class="top">5</span><span class="bottom">6</span></span>',
      '<span class="frac"><span class="top">2</span><span class="bottom">6</span></span>',
      '<span class="frac"><span class="top">1</span><span class="bottom">6</span></span>'
    ),
    jawaban_benar = 2, # Kunci: B
    pembahasan = "Samakan penyebut dengan KPK dari 2 dan 3, yaitu 6. 1/2 = 3/6 dan 1/3 = 2/6. Maka 3/6 + 2/6 = 5/6 (jangan menjumlahkan langsung menjadi 2/5)."
  ),
  list(
    id = 6,
    topik = "Desimal",
    level = 3,
    soal = "Pada bilangan desimal <strong>13,85</strong>, angka <strong>8</strong> menempati nilai tempat ...",
    opsi = c("Satuan", "Puluhan", "Persepuluhan", "Perseratusan"),
    jawaban_benar = 3, # Kunci: C
    pembahasan = "Pada bilangan 13,85: 1 adalah puluhan, 3 satuan, 8 di posisi pertama setelah koma adalah persepuluhan, dan 5 adalah perseratusan."
  ),

  # ----------------------------------------------------------------------------
  # LEVEL 4 (Sulit): Perkalian pecahan, penjumlahan/pengurangan desimal
  # ----------------------------------------------------------------------------
  list(
    id = 7,
    topik = "Pecahan",
    level = 4,
    soal = 'Hasil perkalian pecahan dari <span class="frac"><span class="top">3</span><span class="bottom">4</span></span> × <span class="frac"><span class="top">2</span><span class="bottom">5</span></span> dalam bentuk paling sederhana adalah ...',
    opsi = c(
      '<span class="frac"><span class="top">3</span><span class="bottom">10</span></span>',
      '<span class="frac"><span class="top">5</span><span class="bottom">9</span></span>',
      '<span class="frac"><span class="top">6</span><span class="bottom">9</span></span>',
      '<span class="frac"><span class="top">15</span><span class="bottom">8</span></span>'
    ),
    jawaban_benar = 1, # Kunci: A
    pembahasan = "Kalikan pembilang dengan pembilang, penyebut dengan penyebut: (3 × 2) / (4 × 5) = 6/20. Sederhanakan dengan membagi 2: hasilnya 3/10."
  ),
  list(
    id = 8,
    topik = "Desimal",
    level = 4,
    soal = "Hasil dari operasi pengurangan desimal <strong>4,2 − 1,75</strong> adalah ...",
    opsi = c("3,55", "2,55", "2,45", "3,45"),
    jawaban_benar = 3, # Kunci: C
    pembahasan = "Sejajarkan tanda koma dan tambahkan nol: 4,20 − 1,75 = 2,45."
  ),

  # ----------------------------------------------------------------------------
  # LEVEL 5 (Sangat Sulit): Konversi pecahan-desimal-persen dan soal cerita
  # ----------------------------------------------------------------------------
  list(
    id = 9,
    topik = "Pecahan",
    level = 5,
    soal = 'Pak Budi memiliki sebidang tanah. Sebanyak <span class="frac"><span class="top">2</span><span class="bottom">5</span></span> bagian ditanami jagung dan <strong>0,35</strong> bagian ditanami cabai. Jika sisanya dibuat kolam ikan, berapa bagian tanah untuk kolam ikan dalam bentuk pecahan biasa paling sederhana?',
    opsi = c(
      '<span class="frac"><span class="top">1</span><span class="bottom">2</span></span>',
      '<span class="frac"><span class="top">3</span><span class="bottom">10</span></span>',
      '<span class="frac"><span class="top">1</span><span class="bottom">5</span></span>',
      '<span class="frac"><span class="top">1</span><span class="bottom">4</span></span>'
    ),
    jawaban_benar = 4, # Kunci: D
    pembahasan = "Ubah 2/5 ke desimal: 2/5 = 0,40. Total jagung + cabai = 0,40 + 0,35 = 0,75. Sisa kolam = 1 − 0,75 = 0,25. Bentuk pecahannya adalah 25/100 = 1/4."
  ),
  list(
    id = 10,
    topik = "Desimal",
    level = 5,
    soal = 'Urutan bilangan berikut dari yang nilainya <strong>TERKECIL</strong> ke paling besar adalah: <strong>0,6 ; 45% ; <span class="frac"><span class="top">1</span><span class="bottom">2</span></span> ; 0,25</strong>',
    opsi = c(
      '0,25 ; 45% ; <span class="frac"><span class="top">1</span><span class="bottom">2</span></span> ; 0,6',
      '45% ; 0,6 ; 0,25 ; <span class="frac"><span class="top">1</span><span class="bottom">2</span></span>',
      '0,6 ; <span class="frac"><span class="top">1</span><span class="bottom">2</span></span> ; 45% ; 0,25',
      '0,25 ; <span class="frac"><span class="top">1</span><span class="bottom">2</span></span> ; 45% ; 0,6'
    ),
    jawaban_benar = 1, # Kunci: A
    pembahasan = "Ubah ke desimal: 0,25 = 0,25 ; 45% = 0,45 ; 1/2 = 0,50 ; 0,6 = 0,60. Urutan dari terkecil adalah: 0,25 ; 45% ; 1/2 ; 0,6."
  )
)

# ==============================================================================
# 2. FUNGSI LOGIKA SISTEM ADAPTIF (CAT ENGINE)
# ==============================================================================

# Pemilihan soal pertama (Level 3 secara acak)
pilih_soal_pertama <- function() {
  soal_l3 <- Filter(function(s) s$level == 3, bank_soal)
  sample(soal_l3, 1)[[1]]
}

# Perhitungan level target berikutnya
hitung_level_berikutnya <- function(level_saat_ini, is_benar) {
  if (is_benar) {
    min(5, level_saat_ini + 1)
  } else {
    max(1, level_saat_ini - 1)
  }
}

# Pemilihan butir soal adaptif (dengan fallback level terdekat: bawah dulu lalu atas)
pilih_soal_berikutnya <- function(level_target, id_terpakai) {
  # 1. Cek pada level target
  soal_target <- Filter(function(s) s$level == level_target && !(s$id %in% id_terpakai), bank_soal)
  if (length(soal_target) > 0) {
    return(sample(soal_target, 1)[[1]])
  }

  # 2. Jika habis, cari dari level terdekat (bawah dulu, lalu atas)
  for (delta in 1:4) {
    lvl_bawah <- level_target - delta
    if (lvl_bawah >= 1) {
      soal_bawah <- Filter(function(s) s$level == lvl_bawah && !(s$id %in% id_terpakai), bank_soal)
      if (length(soal_bawah) > 0) {
        return(sample(soal_bawah, 1)[[1]])
      }
    }

    lvl_atas <- level_target + delta
    if (lvl_atas <= 5) {
      soal_atas <- Filter(function(s) s$level == lvl_atas && !(s$id %in% id_terpakai), bank_soal)
      if (length(soal_atas) > 0) {
        return(sample(soal_atas, 1)[[1]])
      }
    }
  }

  return(NULL)
}

# ==============================================================================
# 3. ANTARMUKA PENGGUNA (UI SHINY)
# ==============================================================================

ui <- fluidPage(
  tags$head(
    tags$title("Latihan CAT Matematika SD - Pecahan & Desimal"),
    tags$style(HTML("
      body {
        background-color: #f4f7fe;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #1e293b;
        padding-top: 20px;
        padding-bottom: 40px;
      }
      .main-card {
        background: #ffffff;
        border-radius: 20px;
        box-shadow: 0 10px 25px -5px rgba(67, 97, 238, 0.12);
        padding: 30px;
        margin: 0 auto 25px auto;
        max-width: 760px;
        border: 1px solid #e2e8f0;
      }
      .badge-cat {
        background: #e0e7ff;
        color: #4361ee;
        padding: 6px 14px;
        border-radius: 50px;
        font-weight: bold;
        font-size: 0.9rem;
        display: inline-block;
        margin-bottom: 10px;
      }
      .title-app {
        font-size: 2rem;
        font-weight: 800;
        color: #0f172a;
        margin-bottom: 5px;
      }
      .subtitle-app {
        font-size: 1.05rem;
        color: #64748b;
        margin-bottom: 20px;
      }
      .question-text {
        font-size: 1.35rem;
        font-weight: 700;
        line-height: 1.6;
        color: #0f172a;
        margin-bottom: 25px;
      }
      .frac {
        display: inline-flex;
        flex-direction: column;
        vertical-align: middle;
        text-align: center;
        font-size: 0.9em;
        line-height: 1.05;
        margin: 0 4px;
        font-weight: bold;
      }
      .frac .top {
        border-bottom: 2px solid currentColor;
        padding: 0 4px 1px 4px;
      }
      .frac .bottom {
        padding: 1px 4px 0 4px;
      }
      .btn-custom {
        padding: 14px 24px;
        font-size: 1.1rem;
        font-weight: bold;
        border-radius: 12px;
      }
      .option-item {
        background: #f8fafc;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        padding: 14px 18px;
        margin-bottom: 12px;
        cursor: pointer;
        transition: all 0.2s;
        font-size: 1.15rem;
      }
      .option-item:hover {
        background: #f1f5f9;
        border-color: #93c5fd;
      }
      .progress-bar-custom {
        background: linear-gradient(90deg, #4cc9f0, #4361ee);
        height: 12px;
        border-radius: 10px;
      }
      .path-node {
        display: inline-block;
        background: #e0e7ff;
        color: #4361ee;
        font-weight: bold;
        padding: 6px 14px;
        border-radius: 8px;
        margin: 4px;
      }
      .review-card {
        background: #f8fafc;
        border-radius: 12px;
        padding: 18px;
        margin-bottom: 16px;
        border-left: 6px solid #94a3b8;
      }
      .review-correct { border-left-color: #10b981; }
      .review-wrong { border-left-color: #ef4444; }
    "))
  ),
  uiOutput("main_ui")
)

# ==============================================================================
# 4. LOGIKA SERVER (SHINY SERVER)
# ==============================================================================

server <- function(input, output, session) {

  # State Reaktif Aplikasi
  state <- reactiveValues(
    tahap = "start",       # 'start', 'quiz', 'result'
    nama_siswa = "",
    nomor_soal = 1,
    soal_aktif = NULL,
    opsi_terpilih = NULL,
    riwayat = list()       # Menyimpan: list(soal, jawaban_siswa, is_benar, level)
  )

  # Render Tampilan UI Sesuai Tahap
  output$main_ui <- renderUI({
    if (state$tahap == "start") {
      # ------------------------------------------------------------------------
      # LAYAR 1: HALAMAN AWAL
      # ------------------------------------------------------------------------
      div(class = "main-card",
        div(class = "badge-cat", "🎯 Computerized Adaptive Testing"),
        h1(class = "title-app", "Latihan CAT Matematika SD"),
        p(class = "subtitle-app", "Materi: Pecahan & Desimal (Soal Menyesuaikan Jawabanmu)"),
        div(style = "background: #f8fafc; border-left: 5px solid #4361ee; padding: 16px; border-radius: 10px; margin-bottom: 20px; line-height: 1.6;",
          tags$strong("Petunjuk Latihan:"),
          tags$ul(
            tags$li("Latihan terdiri dari ", tags$strong("6 butir soal"), " pilihan ganda."),
            tags$li("Tingkat kesulitan soal berikutnya akan ", tags$strong("menyesuaikan otomatis"), " berdasarkan jawabanmu sebelumnya."),
            tags$li("Pilihlah salah satu jawaban (A, B, C, atau D) yang paling tepat.")
          )
        ),
        textInput("input_nama", "Nama Lengkap / Panggilan Siswa:", placeholder = "Contoh: Budi Santoso", width = "100%"),
        uiOutput("error_nama"),
        br(),
        actionButton("btn_mulai", "Mulai Latihan Sekarang 🚀", class = "btn-primary btn-custom", style = "width: 100%;")
      )

    } else if (state$tahap == "quiz") {
      # ------------------------------------------------------------------------
      # LAYAR 2: HALAMAN SOAL
      # ------------------------------------------------------------------------
      soal <- state$soal_aktif
      persen_progres <- round(((state$nomor_soal - 1) / JUMLAH_SOAL_TES) * 100)

      div(class = "main-card",
        div(style = "display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; flex-wrap: wrap;",
          span(style = "font-size: 1.15rem; font-weight: 800; color: #4361ee;",
               paste0("Soal ", state$nomor_soal, " dari ", JUMLAH_SOAL_TES)),
          div(
            span(class = "label label-warning", style = "background: #fef3c7; color: #b45309; padding: 6px 12px; border-radius: 20px; font-weight: bold; margin-right: 6px;",
                 paste("Level", soal$level)),
            span(class = "label label-info", style = "background: #e0f2fe; color: #0369a1; padding: 6px 12px; border-radius: 20px; font-weight: bold;",
                 paste("Topik:", soal$topik))
          )
        ),
        # Progress Bar
        div(style = "background: #e2e8f0; border-radius: 10px; height: 12px; overflow: hidden; margin-bottom: 25px;",
          div(class = "progress-bar-custom", style = paste0("width: ", persen_progres, "%;"))
        ),
        # Pertanyaan Soal
        div(class = "question-text", HTML(soal$soal)),

        # Opsi Pilihan Ganda (A, B, C, D)
        radioButtons("pilihan_jawaban", label = "Pilih salah satu jawaban:",
                     choiceNames = lapply(seq_along(soal$opsi), function(i) {
                       huruf <- c("A", "B", "C", "D")[i]
                       HTML(paste0("<strong>(", huruf, ")</strong> ", soal$opsi[i]))
                     }),
                     choiceValues = 1:4,
                     selected = character(0),
                     width = "100%"),
        br(),
        actionButton("btn_jawab", "Jawab & Lanjut ➔", class = "btn-primary btn-custom", style = "width: 100%;")
      )

    } else if (state$tahap == "result") {
      # ------------------------------------------------------------------------
      # LAYAR 3: HALAMAN HASIL
      # ------------------------------------------------------------------------
      total_soal <- length(state$riwayat)
      jml_benar <- sum(sapply(state$riwayat, function(r) r$is_benar))
      jml_salah <- total_soal - jml_benar
      skor <- round((jml_benar / total_soal) * 100)

      # Predikat Kategori
      kategori <- if (skor >= 80) "Sangat Baik" else if (skor >= 60) "Baik" else if (skor >= 40) "Cukup" else "Perlu Bimbingan"
      bg_kategori <- if (skor >= 80) "#d1fae5" else if (skor >= 60) "#dbeafe" else if (skor >= 40) "#fef3c7" else "#fee2e2"
      col_kategori <- if (skor >= 80) "#065f46" else if (skor >= 60) "#1e40af" else if (skor >= 40) "#92400e" else "#991b1b"

      # Level Tertinggi Benar
      lvl_benar <- sapply(Filter(function(r) r$is_benar, state$riwayat), function(r) r$level)
      lvl_tertinggi <- if (length(lvl_benar) > 0) paste("Level", max(lvl_benar)) else "-"

      # Rekap Topik
      topik_list <- unique(sapply(state$riwayat, function(r) r$soal$topik))
      saran_ulang <- c()

      div(class = "main-card",
        div(class = "badge-cat", "📊 Laporan Evaluasi CAT"),
        h2(style = "font-weight: 800; color: #0f172a;", paste("Selamat,", state$nama_siswa, "! 🎉")),
        # Skor Besar
        div(style = "background: #eef2ff; border-radius: 16px; padding: 24px; text-align: center; margin-bottom: 25px;",
          div(style = "font-size: 3.5rem; font-weight: 900; color: #4361ee;", skor),
          div(style = "font-size: 1.1rem; color: #64748b; margin-bottom: 8px;", "Skor Akhir Latihan"),
          span(style = paste0("background: ", bg_kategori, "; color: ", col_kategori, "; padding: 8px 22px; border-radius: 50px; font-weight: bold; font-size: 1.1rem; display: inline-block;"),
               kategori)
        ),

        # Metrik Ringkas
        div(style = "display: grid; grid-template-columns: repeat(auto-fit, minmax(140px, 1fr)); gap: 12px; margin-bottom: 25px; text-align: center;",
          div(style = "background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 14px;",
            div(style = "color: #64748b; font-size: 0.9rem;", "Total Soal"),
            div(style = "font-size: 1.4rem; font-weight: bold;", paste(total_soal, "Soal"))
          ),
          div(style = "background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 14px;",
            div(style = "color: #64748b; font-size: 0.9rem;", "Benar"),
            div(style = "font-size: 1.4rem; font-weight: bold; color: #10b981;", paste(jml_benar, "Soal"))
          ),
          div(style = "background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 14px;",
            div(style = "color: #64748b; font-size: 0.9rem;", "Salah"),
            div(style = "font-size: 1.4rem; font-weight: bold; color: #ef4444;", paste(jml_salah, "Soal"))
          ),
          div(style = "background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 14px;",
            div(style = "color: #64748b; font-size: 0.9rem;", "Level Tertinggi Benar"),
            div(style = "font-size: 1.4rem; font-weight: bold; color: #4361ee;", lvl_tertinggi)
          )
        ),

        # Jalur Lintasan Kesulitan
        div(style = "background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 16px; margin-bottom: 25px;",
          tags$strong("🛤️ Jalur Adaptasi Tingkat Kesulitan Soal:"),
          br(), br(),
          div(
            lapply(seq_along(state$riwayat), function(i) {
              item <- state$riwayat[[i]]
              tagList(
                span(class = "path-node", paste0("L", item$level)),
                if (i < length(state$riwayat)) span(style = "color: #94a3b8; font-weight: bold; font-size: 1.2rem;", " ➔ ")
              )
            })
          )
        ),

        # Rekap Per Topik & Rekomendasi
        div(style = "margin-bottom: 25px;",
          tags$h4(style = "font-weight: 800;", "📚 Penguasaan Per Topik:"),
          div(style = "display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 12px; margin-bottom: 12px;",
            lapply(topik_list, function(tp) {
              sub_r <- Filter(function(r) r$soal$topik == tp, state$riwayat)
              b <- sum(sapply(sub_r, function(x) x$is_benar))
              s <- length(sub_r) - b
              if (s > 0) saran_ulang <<- c(saran_ulang, tp)
              div(style = "background: #ffffff; border: 1px solid #e2e8f0; border-radius: 10px; padding: 12px;",
                tags$strong(paste("Topik:", tp)),
                tags$div(paste("Dikerjakan:", length(sub_r), "soal")),
                tags$div(style = "color: #10b981;", paste("Benar:", b)),
                tags$div(style = "color: #ef4444;", paste("Salah:", s))
              )
            })
          ),
          div(style = "background: #fffbeb; border-left: 5px solid #f59e0b; padding: 14px; border-radius: 8px; color: #92400e; font-size: 0.95rem;",
            if (length(saran_ulang) > 0) {
              HTML(paste0("<strong>💡 Saran Belajar:</strong> Disarankan untuk memperdalam kembali latihan pada materi <strong>",
                          paste(unique(saran_ulang), collapse = " dan "), "</strong>."))
            } else {
              HTML("<strong>🌟 Sempurna!</strong> Kamu telah menguasai seluruh materi Pecahan dan Desimal dengan sangat baik.")
            }
          )
        ),

        # Daftar Ulasan & Pembahasan
        tags$h4(style = "font-weight: 800;", "📝 Pembahasan Butir Soal:"),
        div(
          lapply(seq_along(state$riwayat), function(i) {
            item <- state$riwayat[[i]]
            huruf_siswa <- c("A", "B", "C", "D")[item$jawaban_siswa]
            huruf_kunci <- c("A", "B", "C", "D")[item$soal$jawaban_benar]
            cls <- if (item$is_benar) "review-card review-correct" else "review-card review-wrong"
            badge_status <- if (item$is_benar) "✓ Jawaban Benar" else "✗ Jawaban Kurang Tepat"
            col_status <- if (item$is_benar) "#10b981" else "#ef4444"

            div(class = cls,
              div(style = "display: flex; justify-content: space-between; margin-bottom: 8px;",
                tags$strong(paste0("Soal ", i, " (Level ", item$level, " - ", item$soal$topik, ")")),
                span(style = paste0("font-weight: bold; color: ", col_status, ";"), badge_status)
              ),
              div(style = "margin-bottom: 8px;", HTML(item$soal$soal)),
              div(style = "background: #ffffff; padding: 10px; border-radius: 6px; margin-bottom: 8px; font-size: 0.95rem;",
                tags$div(paste0("Jawabanmu: (", huruf_siswa, ")")),
                if (!item$is_benar) tags$div(style = "color: #047857; font-weight: bold;", paste0("Kunci Benar: (", huruf_kunci, ")"))
              ),
              div(style = "background: #eff6ff; color: #1e3a8a; padding: 10px; border-radius: 6px; font-size: 0.9rem;",
                tags$strong("Pembahasan: "), item$soal$pembahasan
              )
            )
          })
        ),

        # Tombol Aksi
        br(),
        div(style = "display: flex; gap: 12px;",
          actionButton("btn_ulangi", "🔄 Ulangi Tes", class = "btn-default btn-custom", style = "flex: 1;"),
          tags$button("🖨️ Cetak Hasil", class = "btn btn-primary btn-custom", style = "flex: 1;", onclick = "window.print();")
        ),
        br(),
        p(style = "text-align: center; color: #94a3b8; font-size: 0.85rem; font-style: italic;",
          "Hasil ini hanya gambaran awal untuk latihan, bukan penilaian resmi.")
      )
    }
  })

  # Event: Klik Mulai Tes
  observeEvent(input$btn_mulai, {
    nama <- trimws(input$input_nama)
    if (nchar(nama) == 0) {
      output$error_nama <- renderUI({
        div(style = "color: #ef4444; font-weight: bold; margin-top: 5px;", "⚠️ Silakan isi namamu terlebih dahulu ya!")
      })
      return()
    }
    output$error_nama <- renderUI(NULL)

    state$nama_siswa <- nama
    state$nomor_soal <- 1
    state$soal_aktif <- pilih_soal_pertama()
    state$riwayat <- list()
    state$tahap <- "quiz"
  })

  # Event: Klik Jawab Soal
  observeEvent(input$btn_jawab, {
    req(input$pilihan_jawaban)
    jawaban_int <- as.integer(input$pilihan_jawaban)
    soal_curr <- state$soal_aktif
    is_benar <- (jawaban_int == soal_curr$jawaban_benar)

    # Catat riwayat
    state$riwayat[[length(state$riwayat) + 1]] <- list(
      soal = soal_curr,
      jawaban_siswa = jawaban_int,
      is_benar = is_benar,
      level = soal_curr$level
    )

    # Cek aturan berhenti tes
    if (length(state$riwayat) >= JUMLAH_SOAL_TES) {
      state$tahap <- "result"
      return()
    }

    # Hitung level berikutnya
    lvl_target <- hitung_level_berikutnya(soal_curr$level, is_benar)
    id_terpakai <- sapply(state$riwayat, function(r) r$soal$id)
    soal_lanjut <- pilih_soal_berikutnya(lvl_target, id_terpakai)

    state$nomor_soal <- state$nomor_soal + 1
    state$soal_aktif <- soal_lanjut
  })

  # Event: Klik Ulangi Tes
  observeEvent(input$btn_ulangi, {
    state$tahap <- "start"
  })
}

# ==============================================================================
# 5. MENJALANKAN APLIKASI SHINY
# ==============================================================================
shinyApp(ui = ui, server = server)
