# DATA PREPARATION — PERTEMUAN 3
## Studi Kasus: Iris + Data Campuran (Mixed-Type)

```{admonition} Identitas Mahasiswa
:class: note

| | |
|---|---|
| **Nama** | Moh Rafie Nazar J. |
| **NIM** | 240411100003 |
| **Mata Kuliah** | Penambangan Data |
| **Pertemuan** | 3 — Data Preparation |
```

Dokumen ini melanjutkan materi Data Preparation dalam kerangka **CRISP-DM** yang mencakup:
identifikasi missing value, statistik deskriptif, encoding, scaling, **pengukuran jarak**, dan penanganan **data campuran (mixed-type)**.

---

## ✅ Tugas Pertemuan 3

```{admonition} Tugas yang Harus Diselesaikan
:class: important

Berikut tiga tugas utama pada Pertemuan 3 beserta status penyelesaiannya:

| No | Tugas | Status | Keterangan |
|:--:|-------|:------:|------------|
| 1 | **Mengukur Jarak** — ditempatkan di bawah bagian *Data Understanding* | ✅ Selesai | Euclidean, Manhattan, Spearman, Hamming pada data Iris (CSV & SQL) — lihat **Section 3.13–3.14** |
| 2 | **Buat/Cari Data Campuran** — mengandung tipe ordinal, numerik, kategorikal, dan biner | ✅ Selesai | Dataset **Adult Census Income** (`adult.csv` + PostgreSQL `AdultCensus`) — lihat **Section 3.15** |
| 3 | **Lakukan Pengukuran Jarak pada Data Campuran** tersebut | ✅ Selesai | 4 metrik jarak diterapkan di Orange pada data Adult Census Income — lihat **Section 3.15.5** |
```

> **File Orange Workflow:** {download}`AdultCensus.ows <../DataCampuranPertemuan3/AdultCensusIncome/AdultCensus.ows>`
>
> **File SQL Database:** {download}`AdultCensus.sql <../DataCampuranPertemuan3/AdultCensusIncome/AdultCensus.sql>`

---

## 3.1 Konsep CRISP-DM

**CRISP-DM** (Cross-Industry Standard Process for Data Mining) adalah metodologi standar dalam proyek data mining yang terdiri dari 6 fase berurutan:

| No | Fase | Keterangan |
|----|------|------------|
| 1 | Business Understanding | Memahami tujuan bisnis dan kebutuhan analisis |
| 2 | Data Understanding | Eksplorasi awal data, statistik deskriptif |
| 3 | **Data Preparation** | Pembersihan, transformasi, seleksi fitur |
| 4 | Modeling | Membangun model machine learning |
| 5 | Evaluation | Mengevaluasi performa model |
| 6 | Deployment | Implementasi model ke sistem nyata |

> Pertemuan ini berfokus pada fase **Data Preparation** — fase paling kritis yang memakan 60–70% waktu proyek data mining.

---

## 3.2 Persiapan Lingkungan

Sebelum memulai analisis, kita impor library yang dibutuhkan. Setiap library memiliki peran khusus dalam proses data preparation.

```python
%matplotlib inline
import pandas as pd          # manipulasi dan analisis data tabular
import numpy as np           # komputasi numerik dan array
import matplotlib.pyplot as plt  # visualisasi data

from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.metrics import pairwise_distances
```

| Library | Fungsi Utama |
|---------|-------------|
| `pandas` | Load CSV, manipulasi DataFrame, groupby, describe |
| `numpy` | Operasi array, kalkulasi jarak manual |
| `matplotlib` | Plot histogram, visualisasi distribusi |
| `StandardScaler` | Normalisasi fitur (mean=0, std=1) sebelum hitung jarak |
| `LabelEncoder` | Konversi label kategorikal ke numerik |
| `pairwise_distances` | Hitung distance matrix antar semua pasang data |

---

## 3.3 Memuat Dataset Awal

Dataset dimuat kembali untuk memastikan seluruh proses preparation dilakukan pada data mentah yang konsisten.

```python
df = pd.read_csv("IRIS.csv")
df.head()
```

**Output `df.head()`** — 5 baris pertama dataset Iris:

| | sepal_length | sepal_width | petal_length | petal_width | species |
|--|---|---|---|---|---|
| **0** | 5.1 | 3.5 | 1.4 | 0.2 | Iris-setosa |
| **1** | 4.9 | 3.0 | 1.4 | 0.2 | Iris-setosa |
| **2** | 4.7 | 3.2 | 1.3 | 0.2 | Iris-setosa |
| **3** | 4.6 | 3.1 | 1.5 | 0.2 | Iris-setosa |
| **4** | 5.0 | 3.6 | 1.4 | 0.2 | Iris-setosa |

Dataset ini berisi **150 baris** dan **5 kolom**, terdiri dari 4 fitur numerik dan 1 kolom target kategorikal.

---

## 3.4 Penjelasan: Fitur vs Kelas (Target)

Memahami perbedaan **fitur** dan **kelas** adalah dasar sebelum melakukan pemodelan supervised learning.

- **Fitur (features / attributes)** = kolom input yang menjadi karakteristik bunga, digunakan sebagai variabel independen (X).
- **Kelas (class / label / target)** = kolom output yang ingin diprediksi, merupakan variabel dependen (y).

**Tabel Identifikasi Kolom Dataset Iris:**

| Kolom | Tipe Data | Peran | Keterangan |
|-------|-----------|-------|------------|
| `sepal_length` | Numerik (float) | **Fitur** | Panjang kelopak luar / sepal (cm) |
| `sepal_width` | Numerik (float) | **Fitur** | Lebar kelopak luar / sepal (cm) |
| `petal_length` | Numerik (float) | **Fitur** | Panjang mahkota bunga / petal (cm) |
| `petal_width` | Numerik (float) | **Fitur** | Lebar mahkota bunga / petal (cm) |
| `species` | Kategorikal (string) | **Kelas (Target)** | Jenis bunga: *setosa*, *versicolor*, *virginica* |

✅ **Kesimpulan:** `sepal_length`, `sepal_width`, `petal_length`, `petal_width` → **fitur**.
Sedangkan `Iris-setosa`, `Iris-versicolor`, `Iris-virginica` → **kelas/label**.

> Jika membuat kolom `species_encoded`, itu hanya versi **numerik** dari kelas — bukan fitur baru.

---

## Pembersihan Data

---

## 3.5 Identifikasi Missing Value

Identifikasi missing value adalah langkah **pertama dan wajib** dalam data preparation. Data yang memiliki nilai kosong dapat menyebabkan error pada algoritma atau hasil analisis yang bias.

### 3.5.1 Jumlah Missing per Kolom

```python
missing_count = df.isnull().sum()
missing_count
```

### 3.5.2 Persentase Missing per Kolom

```python
missing_percent = (df.isnull().mean() * 100).round(2)
pd.DataFrame({'missing_count': missing_count, 'missing_%': missing_percent})
```

**Hasil Pengecekan Missing Value Dataset Iris:**

| Kolom | Missing Count | Missing % | Status |
|-------|:---:|:---:|:---:|
| `sepal_length` | 0 | 0.00% | ✅ Lengkap |
| `sepal_width` | 0 | 0.00% | ✅ Lengkap |
| `petal_length` | 0 | 0.00% | ✅ Lengkap |
| `petal_width` | 0 | 0.00% | ✅ Lengkap |
| `species` | 0 | 0.00% | ✅ Lengkap |

> Dataset Iris **tidak memiliki missing value**, sehingga tidak diperlukan proses imputasi (pengisian nilai kosong).

---

## Encoding dan Transformasi

---

## 3.6 Encoding Label

Karena algoritma machine learning memerlukan data numerik, maka label `species` bertipe string perlu dikonversi menjadi bentuk numerik menggunakan `LabelEncoder`.

```python
from sklearn.preprocessing import LabelEncoder

le = LabelEncoder()
df['species_encoded'] = le.fit_transform(df['species'])
df.head()
```

**Mapping Encoding:**

| Label Asli | Encoded | Keterangan |
|-----------|:-------:|------------|
| `Iris-setosa` | **0** | Kelas pertama secara alfabet |
| `Iris-versicolor` | **1** | Kelas kedua |
| `Iris-virginica` | **2** | Kelas ketiga |

---

## 3.7 Pemisahan Fitur dan Target

Dataset dipisahkan menjadi dua bagian agar model dapat dilatih secara *supervised*:
- **X** → matriks fitur input (4 kolom numerik)
- **y** → vektor target/label (1 kolom encoded)

```python
numeric_cols = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width']
X = df[numeric_cols].copy()
y = df['species_encoded']
```

---

## Standardisasi Scaling

---

## 3.8 Alasan Dilakukan Scaling

Scaling penting untuk algoritma berbasis jarak seperti **KNN**, **K-Means**, dan **SVM** karena fitur dengan rentang nilai lebih besar dapat mendominasi perhitungan jarak.

```python
from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)
pd.DataFrame(X_scaled, columns=X.columns).head()
```

**Output Data Setelah Scaling (5 baris pertama):**

| | sepal_length | sepal_width | petal_length | petal_width |
|--|---|---|---|---|
| **0** | -0.9155 | 1.0199 | -1.3577 | -1.3359 |
| **1** | -1.1576 | -0.1280 | -1.3577 | -1.3359 |
| **2** | -1.3996 | 0.3311 | -1.4147 | -1.3359 |
| **3** | -1.5206 | 0.1015 | -1.3006 | -1.3359 |
| **4** | -1.0365 | 1.2495 | -1.3577 | -1.3359 |

Setelah scaling, seluruh fitur memiliki **mean ≈ 0** dan **standar deviasi ≈ 1**, sehingga tidak ada fitur yang mendominasi.

---

## Mengukur Jarak (Distance)

---

## 3.13 Cara Mengukur Jarak untuk Data Iris

Karena seluruh fitur Iris bertipe numerik, terdapat beberapa metrik jarak yang dapat digunakan. **Scaling wajib dilakukan** sebelum menghitung jarak.

**Perbandingan Metrik Jarak Numerik:**

| Metrik | Formula | Kapan Dipakai |
|--------|---------|---------------|
| **Euclidean** | $d = \sqrt{\sum_{i=1}^{n}(x_i - y_i)^2}$ | Jarak garis lurus, data normal, paling umum |
| **Manhattan** | $d = \sum_{i=1}^{n}\|x_i - y_i\|$ | Lebih tahan outlier, cocok untuk data grid |
| **Minkowski** | $d = \left(\sum_{i=1}^{n}\|x_i - y_i\|^p\right)^{1/p}$ | Generalisasi keduanya, fleksibel |

### 3.13.1 Scaling Data

```python
X = df[numeric_cols].copy()
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)
```

### 3.13.2 Distance Matrix — Euclidean

```python
from sklearn.metrics import pairwise_distances

D_euclid = pairwise_distances(X_scaled, metric='euclidean')
print("Euclidean D[0:5, 0:5]:\n", D_euclid[:5, :5].round(4))
```

### 3.13.3 Distance Matrix — Manhattan

```python
D_manhattan = pairwise_distances(X_scaled, metric='manhattan')
print("Manhattan D[0:5, 0:5]:\n", D_manhattan[:5, :5].round(4))
```

### 3.13.4 Distance Matrix — Minkowski (p=3)

```python
D_minkowski = pairwise_distances(X_scaled, metric='minkowski', p=3)
print("Minkowski(p=3) D[0:5, 0:5]:\n", D_minkowski[:5, :5].round(4))
```

**Perbandingan Nilai Jarak antara Iris-0 dan Iris-50 (setosa vs versicolor) setelah scaling:**

| Metrik | Nilai Jarak | Interpretasi |
|--------|:-----------:|-------------|
| Euclidean | ≈ 6.50 | Jarak garis lurus di ruang 4D |
| Manhattan | ≈ 10.20 | Jumlah selisih absolut per dimensi |
| Minkowski (p=3) | ≈ 5.40 | Lebih kecil dari Euclidean |

---

## Distance Matrix di Orange

---

## 3.14 Distance Matrix di Orange (Workflow)

Orange menyediakan widget **Distances** yang langsung menghitung distance matrix tanpa perlu menulis kode.

| Langkah | Widget | Keterangan |
|:-------:|--------|------------|
| 1 | **File** / **SQL Table** | Load dataset Iris |
| 2 | **Select Columns** | Masukkan fitur numerik ke Attributes; `species` ke Class |
| 3 | **Normalize** | Pilih Standardize agar skala seragam |
| 4 | **Distances** | Pilih metric: Euclidean / Manhattan / Spearman / Hamming |
| 5 | **Distance Matrix** | Tampilkan matriks jarak antar semua sampel |

---

## Jarak Data Campuran (Mixed-Type)

---

## 3.15 Pengukuran Jarak pada Data Campuran — Adult Census Income

Dataset **Adult Census Income** adalah data campuran (*mixed-type*) yang mengandung **keempat tipe data sekaligus**: numerik, ordinal, nominal/kategorikal, dan biner. Dataset ini digunakan untuk memprediksi **apakah pendapatan seseorang melebihi $50K per tahun**.

### 3.15.1 Profil Dataset Adult Census Income

Dataset berasal dari **US Census Bureau** dan terdapat **48.842 baris** dan **15 kolom** fitur. Tersedia dalam dua format: file CSV (`adult.csv`) dan tabel PostgreSQL (`adult_census` di database `AdultCensus`).

```python
df_adult = pd.read_csv("../DataCampuranPertemuan3/AdultCensusIncome/adult.csv")
df_adult.head()
```

### 3.15.2 Identifikasi Tipe Data per Kolom (Mixed-Type)

| Kolom | Tipe Data | Metrik Jarak yang Sesuai |
|-------|-----------|:------------------------:|
| `age` | **Numerik** | Euclidean / Manhattan |
| `fnlwgt` | **Numerik** | Euclidean / Manhattan |
| `capital_gain` | **Numerik** | Euclidean / Manhattan |
| `capital_loss` | **Numerik** | Euclidean / Manhattan |
| `hours_per_week` | **Numerik** | Euclidean / Manhattan |
| `education_num` | **Ordinal** | Spearman |
| `education` | **Ordinal** | Spearman |
| `workclass` | **Nominal** | Hamming |
| `marital_status` | **Nominal** | Hamming |
| `occupation` | **Nominal** | Hamming |
| `relationship` | **Nominal** | Hamming |
| `race` | **Nominal** | Hamming |
| `native_country` | **Nominal** | Hamming |
| `sex` | **Biner** | Hamming |
| `income` | **Biner** | **Target / Kelas** |

> **Kesimpulan:** Dataset Adult Census Income adalah contoh data campuran yang kaya — terdapat 5 fitur numerik, 2 fitur ordinal, 7 fitur nominal, dan 1 fitur biner sebagai target.

### 3.15.3 Mengapa Data Campuran Memerlukan Beberapa Metrik?

| Tipe Data | Masalah Jika Salah Metrik | Solusi |
|-----------|--------------------------|--------|
| **Numerik** | Tanpa normalisasi, fitur berskala besar mendominasi jarak | Euclidean/Manhattan setelah scaling |
| **Ordinal** | Nilai mengandung urutan hierarki | Konversi ke rank → Spearman |
| **Nominal** | Tidak ada urutan — cukup cek apakah sama atau beda | Hamming (match/mismatch) |
| **Biner** | Hanya dua nilai; cukup cek apakah sama atau beda | Hamming / Target |

### 3.15.4 Koneksi ke Database PostgreSQL

Data Adult Census Income dapat dimuat langsung dari database PostgreSQL menggunakan widget **SQL Table** di Orange:

| Parameter | Nilai |
|-----------|-------|
| **Server** | PostgreSQL |
| **Host** | `127.0.0.1` |
| **Port** | `5432` |
| **Database** | `AdultCensus` |
| **User** | `postgres` |
| **Table** | `adult_census` |

### 3.15.5 Workflow Orange — Pengukuran Jarak pada Data Campuran

Orange Data Mining digunakan untuk mengukur jarak menggunakan **4 metrik berbeda**. File workflow: `AdultCensus.ows`

**Penjelasan 4 Metrik yang Dipakai:**

| Metrik | Cocok Untuk | Cara Kerja |
|--------|-------------|-----------|
| **Euclidean** | Fitur numerik | $d = \sqrt{\sum(x_i - y_i)^2}$ — jarak absolut |
| **Manhattan** | Fitur numerik (robust outlier) | $d = \sum\|x_i - y_i\|$ — lebih tahan outlier |
| **Spearman** | Fitur ordinal | Korelasi rank antar baris; ideal untuk pendidikan berjenjang |
| **Hamming** | Fitur nominal & biner | Proporsi atribut berbeda; ideal untuk kategori |

```{admonition} Mengapa 4 Metrik Sekaligus pada Adult Census Income?
:class: tip
Dataset ini sangat heterogen — ada 5 kolom numerik, 2 ordinal, 7 nominal, dan 1 biner. Tidak ada satu metrik tunggal yang optimal untuk semua tipe sekaligus.
```

### 3.15.6 Download File Orange Workflow & SQL

```{admonition} 📥 Download File
:class: note
**Orange Workflow:**
{download}`AdultCensus.ows <../DataCampuranPertemuan3/AdultCensusIncome/AdultCensus.ows>`

**SQL Database:**
{download}`AdultCensus.sql <../DataCampuranPertemuan3/AdultCensusIncome/AdultCensus.sql>`
```

---

## 3.16 Menyimpan Dataset Final untuk Modeling

Setelah seluruh proses preparation selesai, dataset yang sudah di-scale disimpan sebagai file CSV baru untuk digunakan pada tahap **Modeling**.

```python
df_modeling = pd.DataFrame(X_scaled, columns=X.columns)
df_modeling['target'] = y.values
df_modeling.to_csv("IRIS_after_preparation_for_modeling.csv", index=False)
```

Dataset ini telah siap digunakan untuk tahap Modeling. Kolom `target` berisi label encoded (0 = setosa, 1 = versicolor, 2 = virginica).

---

```{admonition} Identitas Mahasiswa
:class: note

**Nama:** Moh Rafie Nazar J. | **NIM:** 240411100003
```
