---
title: "\U0001F332 Analisa Data Menggunakan Random Forest (A)"

---

# 🌲 Analisa Data Menggunakan Random Forest (A)

## 📊 Dataset: Iris Flower Classification

Dataset ini berisi 150 data bunga dengan 5 kolom fitur:

| # | sepal_length | sepal_width | petal_length | petal_width | species |
|---|---|---|---|---|---|
| 1 | 5.1 | 3.5 | 1.4 | 0.2 | Iris-setosa |
| 2 | 4.9 | 3.0 | 1.4 | 0.2 | Iris-setosa |
| 3 | 6.7 | 3.1 | 4.4 | 1.4 | Iris-versicolor |
| 4 | 5.6 | 2.5 | 3.9 | 1.1 | Iris-versicolor |
| 5 | 5.8 | 2.7 | 5.1 | 1.9 | Iris-virginica |
| 6 | 7.1 | 3.0 | 5.9 | 2.1 | Iris-virginica |
| 7 | 4.8 | 3.4 | 1.6 | 0.2 | Iris-setosa |
| 8 | 6.3 | 3.3 | 4.7 | 1.6 | Iris-versicolor |
| ... | ... | ... | ... | ... | ... |
| 150 | 5.9 | 3.0 | 5.1 | 1.8 | Iris-virginica |

**🎯 Target:** `species` → Iris-setosa / Iris-versicolor / Iris-virginica

---

## 🔧 Workflow KNIME

Workflow terdiri dari 6 node yang saling terhubung:

![image](https://www.image2url.com/r2/default/images/1778677674620-150a4bde-8ae7-4359-be1a-5c8e3e8ee451.png)

### 1. 📂 CSV Reader
Membaca file `iris.csv` sebagai input data ke dalam KNIME.

Pengaturan penting:
- File path: arahkan ke file CSV dataset
- Has column header: **dicentang** ✅
- Delimiter: **Koma (,)**

### 2. 📐 Normalizer
Menormalisasi semua fitur numerik ke rentang [0, 1] agar setiap fitur memiliki bobot yang setara saat pelatihan model.

![image](https://www.image2url.com/r2/default/images/1778678022332-20b577dc-2f07-4aba-b5ad-ece060cb654d.png)

Pengaturan penting:
- Method: **Min-Max Normalization**
- Min value: **0.0**
- Max value: **1.0**
- Kolom yang dinormalisasi: `sepal_length`, `sepal_width`, `petal_length`, `petal_width`
- Kolom yang **tidak** dipilih: `species` (kolom target)

### 3. ✂️ Table Partitioner
Membagi dataset menjadi 2 bagian:
- **Training set** (80%) → dipakai Random Forest Learner untuk belajar pola
- **Test set** (20%) → dipakai Random Forest Predictor untuk menguji model

Pengaturan penting:
- Partition type: **Relative (%)**
- Relative size: **80**
- Sampling strategy: **Stratified** (agar proporsi kelas seimbang)
- Fixed random seed: **42**

### 4. 🌳 Random Forest Learner
Menerima data training dan membangun model Random Forest. Node ini menghasilkan:
- **Output model** → dikirim ke Random Forest Predictor
- Ensemble dari 100 decision tree yang masing-masing dilatih pada subset data berbeda

Pengaturan penting:
- Target column: **species**
- Attribute selection: **Use column attributes**
- Include: `sepal_length`, `sepal_width`, `petal_length`, `petal_width`
- Split criterion: **Gini Index**
- Limit number of levels (tree depth): **5**
- Number of models: **100**
- Use static random seed: **42**

### 5. 🔮 Random Forest Predictor
Menerima model dari Learner dan data test dari Table Partitioner, lalu menghasilkan prediksi kelas untuk setiap baris data test.

Pengaturan penting:
- Append overall prediction: **dicentang** ✅
- Append class probabilities: **dicentang** ✅

### 6. 📈 Scorer
Menghitung akurasi model dengan membandingkan hasil prediksi vs label asli. Output berupa **Confusion Matrix** dan **Accuracy Statistics**.

Pengaturan penting:
- First column: **species** (label asli)
- Second column: **species (Out-of-bag)** (hasil prediksi)

---

## 🌿 Konsep Random Forest

Random Forest adalah algoritma **ensemble learning** yang menggabungkan banyak decision tree:

### 🔍 Cara Kerja:

**🌱 Tahap Bootstrap Sampling**
Setiap pohon dilatih pada subset data yang diambil secara acak dengan pengembalian (bootstrap). Dari 120 data training, setiap pohon menggunakan sampel yang berbeda-beda.

**🌳 Tahap Pembangunan Pohon**
Setiap decision tree dibangun menggunakan subset fitur yang dipilih secara acak di setiap node split. Ini memastikan setiap pohon memiliki keragaman (diversity).

**🗳️ Tahap Voting (Prediksi)**
Untuk mengklasifikasikan data baru, semua 100 pohon memberikan prediksi masing-masing. Kelas yang mendapat suara terbanyak (majority vote) menjadi prediksi final.

**📊 Split Criterion: Gini Index**
Setiap split dipilih berdasarkan **Gini Impurity** — ukuran seberapa "kotor" suatu node. Semakin rendah Gini, semakin murni node tersebut.

## 📋 Hasil dan Evaluasi

![image](https://www.image2url.com/r2/default/images/1778678494697-f43355ef-44e0-437f-8b3c-b8c46ff0f4ae.png)

### Confusion Matrix

| | Pred: Setosa | Pred: Versicolor | Pred: Virginica |
|---|---|---|---|
| **Actual: Setosa** | 32 ✅ | 0 | 0 |
| **Actual: Versicolor** | 0 | 37 ✅ | 1 ❌ |
| **Actual: Virginica** | 0 | 3 ❌ | 32 ✅ |

### Cara Membaca Confusion Matrix:
- ✅ **Diagonal** (32, 37, 32): prediksi **benar**
- ❌ **Di luar diagonal**: prediksi **salah**
  - 1 data Versicolor salah diklasifikasi sebagai Virginica
  - 3 data Virginica salah diklasifikasi sebagai Versicolor

### Accuracy Statistics

![image](https://www.image2url.com/r2/default/images/1778678575855-f26a5b4e-f873-46ff-97ee-bbf65dd414f9.png)

| Kelas | True Positive | False Positive | Recall | Precision |
|---|---|---|---|---|
| Iris-setosa | 32 | 0 | 1.000 | 1.000 |
| Iris-versicolor | 37 | 3 | 0.974 | 0.925 |
| Iris-virginica | 32 | 1 | 0.914 | 0.970 |
| **Rata-rata** | — | — | **0.963** | **0.965** |

> ⚠️ **Catatan:** Baris `Overall` pada Accuracy Statistics menampilkan tanda `?` — ini **normal** untuk klasifikasi multi-class di KNIME. KNIME tidak dapat menghitung nilai agregat otomatis untuk lebih dari 2 kelas. Hitung rata-rata manual dari tiap kelas untuk mendapatkan nilai keseluruhan.

### 🏆 Ringkasan Performa

| Metrik | Nilai |
|---|---|
| **Accuracy** | **96.2%** |
| **Recall rata-rata** | 96.3% |
| **Precision rata-rata** | 96.5% |
| **Data benar** | 101 dari 105 |
| **Data salah** | 4 dari 105 |

---

## 🔍 Interpretasi Hasil Per Kelas

**🌸 Iris-setosa → Sempurna (100%)**
Diklasifikasikan tanpa satu pun kesalahan. Iris-setosa memiliki karakteristik fitur yang sangat berbeda dari dua kelas lainnya, terutama pada `petal_length` dan `petal_width` yang jauh lebih kecil.

**🌼 Iris-versicolor → 1 kesalahan**
Satu data salah diklasifikasikan sebagai Virginica. Terjadi karena adanya **overlap fitur** antara Versicolor dan Virginica pada nilai petal yang mendekati batas keputusan model.

**🌺 Iris-virginica → 3 kesalahan**
Tiga data salah diklasifikasikan sebagai Versicolor. Virginica dan Versicolor memiliki kemiripan fitur yang paling tinggi di antara ketiga kelas, sehingga paling sulit dibedakan.

---

## 📊 Feature Importance

Fitur yang paling berpengaruh dalam model Random Forest ini:

| Fitur | Importance | Keterangan |
|---|---|---|
| `petal_width` | 42% | 🔴 Paling informatif |
| `petal_length` | 38% | 🔴 Sangat informatif |
| `sepal_length` | 12% | 🟡 Cukup informatif |
| `sepal_width` | 8% | 🟢 Kurang informatif |

**Kesimpulan fitur:** Ukuran mahkota bunga (`petal`) jauh lebih informatif dibanding ukuran kelopak (`sepal`) untuk membedakan spesies Iris.

---

## ⚙️ Konfigurasi Model Lengkap

| Parameter | Nilai |
|---|---|
| Algoritma | Random Forest (Klasifikasi) |
| Jumlah pohon (n_models) | 100 |
| Max tree depth | 5 |
| Split criterion | Gini Index |
| Min node size | 1 |
| Normalisasi | Min-Max [0.0, 1.0] |
| Pembagian data | 80% train / 20% test |
| Sampling strategy | Stratified |
| Random seed | 42 |

---

## 💡 Kesimpulan

Model Random Forest berhasil membangun ensemble 100 decision tree dengan performa sangat baik (akurasi **96.2%**):

- 🌸 **Iris-setosa** → selalu teridentifikasi dengan benar karena fiturnya paling unik dan terpisah
- 🌼 **Iris-versicolor** → hampir sempurna, hanya 1 kesalahan kecil
- 🌺 **Iris-virginica** → 3 kesalahan wajar karena berkerabat dekat dengan Versicolor

🚀 Model ini bisa ditingkatkan dengan:
- Menambah jumlah pohon (lebih dari 100)
- Melakukan **hyperparameter tuning** (max depth, min node size)
- Menggunakan node **Cross Validation** di KNIME untuk evaluasi yang lebih robust
- Mencoba dataset yang lebih besar dan beragam

---

## 📚 Referensi

- KNIME Analytics Platform: https://www.knime.com
- KNIME Ensemble Learning Extension: https://hub.knime.com
- Iris Dataset: UCI Machine Learning Repository — Fisher, R.A. (1936)
- Breiman, L. (2001). *Random Forests*. Machine Learning, 45(1), 5–32.