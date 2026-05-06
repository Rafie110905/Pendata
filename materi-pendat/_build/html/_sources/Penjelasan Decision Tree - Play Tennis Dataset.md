---
title: Penjelasan Decision Tree - Play Tennis Dataset

---

# 🎾 Penjelasan Decision Tree - Play Tennis Dataset

## 📊 Dataset: Play Tennis

Dataset ini berisi 14 data hari dengan 5 kolom fitur:

| Day | Outlook | Temp. | Humidity | Wind | Play Tennis |
|-----|---------|-------|----------|------|-------------|
| D1 | Sunny | Hot | High | False | No |
| D2 | Sunny | Hot | High | True | No |
| D3 | Overcast | Hot | High | False | Yes |
| D4 | Rain | Mild | High | False | Yes |
| D5 | Rain | Cool | Normal | False | Yes |
| D6 | Rain | Cool | Normal | True | No |
| D7 | Overcast | Cool | Normal | False | Yes |
| D8 | Sunny | Mild | High | False | No |
| D9 | Sunny | Cold | Normal | False | Yes |
| D10 | Rain | Mild | Normal | True | Yes |
| D11 | Sunny | Mild | Normal | True | Yes |
| D12 | Overcast | Mild | High | True | Yes |
| D13 | Overcast | Hot | Normal | False | Yes |
| D14 | Rain | Mild | High | True | No |

**🎯 Target:** `Play Tennis` → Yes / No

---

## 🔧 Workflow KNIME (Gambar 2)

![KNIME Workflow](https://www.image2url.com/r2/default/images/1778040803895-cff00815-54f4-4e70-935e-97c1367103ca.png)

Workflow terdiri dari 5 node yang saling terhubung:

### 1. 📂 Excel Reader
Membaca file `Play_Tennis_Dataset.xlsx` sebagai input data ke dalam KNIME.

### 2. ✂️ Table Partitioner
Membagi dataset menjadi 2 bagian:
- **Training set** (70%) → dipakai Decision Tree Learner untuk belajar pola
- **Test set** (30%) → dipakai Decision Tree Predictor untuk menguji model

Pengaturan penting:
- Relative size: **70**
- Sampling strategy: **Stratified** (agar proporsi Yes/No seimbang)
- Group column: **Play Tennis**

### 3. 🌳 Decision Tree Learner
Menerima data training dan membangun model pohon keputusan. Node ini menghasilkan:
- **Port bulat** (output kiri atas) → dikirim ke Decision Tree Predictor
- **Port kotak biru** → bisa dihubungkan ke Decision Tree View (JavaScript)

Pengaturan penting:
- Class column: **Play Tennis**
- Quality measure: **Gain ratio**
- Pruning method: **No pruning**
- Min number records per node: **1**

### 4. 🔮 Decision Tree Predictor
Menerima model dari Learner dan data test dari Table Partitioner, lalu menghasilkan prediksi kelas (Yes/No) untuk setiap baris data test.

### 5. 📈 Scorer
Menghitung akurasi model dengan membandingkan hasil prediksi vs label asli. Output berupa **Confusion Matrix**.

---

## 🌿 Hasil Decision Tree (Gambar 3)

![Decision Tree Visual](https://www.image2url.com/r2/default/images/1778040936939-ce429196-be4f-405d-a2f2-53ae5f18b26f.png)

Hasil pohon keputusan yang terbentuk dari data training:

### 🔍 Penjelasan Tiap Cabang:

**🌱 Split pertama: Outlook**
Fitur `Outlook` dipilih sebagai root node karena memiliki **information gain tertinggi** dari seluruh fitur yang tersedia.

**☀️ Cabang = Sunny → No (2/2)**
Dari data training, semua hari dengan Outlook = Sunny menghasilkan keputusan **Tidak main tennis (No)** dengan 100% keyakinan (2 dari 2 data).

**🌧️ Cabang = Rain → Yes (2/2)**
Dari data training, semua hari dengan Outlook = Rain menghasilkan keputusan **Main tennis (Yes)** dengan 100% keyakinan (2 dari 2 data).

**⛅ Cabang = Overcast → Yes (1/1)**
Dari data training, semua hari dengan Outlook = Overcast menghasilkan keputusan **Main tennis (Yes)** dengan 100% keyakinan (1 dari 1 data).

### 🏠 Root Node: Yes (3/5)
Node paling atas menunjukkan bahwa dari 5 data training:
- ✅ **3 data** berlabel Yes (60%)
- ❌ **2 data** berlabel No (40%)

---

## 📋 Cara Membaca Hasil (Confusion Matrix di Scorer)

Setelah semua node dieksekusi, buka Scorer untuk melihat akurasi:
- ✅ **Yes → Yes**: Diprediksi main, ternyata main
- ✅ **No → No**: Diprediksi tidak main, ternyata tidak main
- ❌ **Yes → No** / **No → Yes**: Prediksi salah

Karena dataset ini kecil (14 baris) dan hanya 70% dipakai training, akurasi bisa bervariasi tergantung pembagian data.

---

## 💡 Kesimpulan

Model Decision Tree berhasil membangun pohon keputusan sederhana dengan **Outlook** sebagai fitur paling informatif. Pohon ini mudah diinterpretasi:

- ⛅ Hari **Overcast** → selalu main tennis
- 🌧️ Hari **Rain** → (dari training ini) main tennis
- ☀️ Hari **Sunny** → tidak main tennis

🚀 Pohon ini bisa dikembangkan lebih dalam jika data training lebih banyak dan fitur lain (Humidity, Wind, Temp) ikut berperan dalam split.