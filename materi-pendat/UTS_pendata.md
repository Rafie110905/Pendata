---
title: Untitled

---

# 📊 Panduan Analisis Kesuburan Tanah dengan KNN di KNIME

**Dataset:** 2.000 Sampel | 10 Fitur | 2 Kelas (Subur / Tidak Subur)  
**Metode:** K-Nearest Neighbors (KNN)  
**Evaluasi:** Accuracy | Precision | Recall | F1-Score

---

## 🗺️ Gambaran Umum Workflow

| No | Node | Fungsi |
|:---|:---|:---|
| 1 | **Excel Reader** | Membaca file dataset `.xlsx` |
| 2 | **Missing Value** | Imputasi data hara yang kosong |
| 3 | **One to Many** | Encoding Tekstur Tanah (Kategorikal → Numerik) |
| 4 | **Normalizer** | Min-Max Normalization (Skala 0-1) |
| 5 | **Column Filter** | Menghapus kolom ID yang tidak relevan |
| 6 | **Table Partitioner** | Split Data (80% Training / 20% Testing) |
| 7 | **K Nearest Neighbor (Learner)** | Melatih model KNN |
| 8 | **KNN Predictor** | Prediksi terhadap data testing |
| 9 | **Scorer** | Menghitung metrik evaluasi |

### 📸 Screenshot Workflow Lengkap
> ![image](https://www.image2url.com/r2/default/images/1776822641865-cb0ac6d1-7156-42b0-b5d8-4cd19a634b61.png)

---

## STEP 1 — Excel Reader
**Fungsi:** Membaca file `dataset_kesuburan_tanah_missing.xlsx`.

**Konfigurasi:**
* Browse file dataset.
* Centang: *Has column header (row 1)*.

| Screenshot Node | Screenshot Konfigurasi |
|---|---|
| ![![image](https://www.image2url.com/r2/default/images/1776822789772-dab30874-e431-449a-a07d-18a6af3d27cc.png)|
![image](https://www.image2url.com/r2/default/images/1776822978461-f7925dcb-5f42-4a66-9d1e-e9f707b9a76d.png) |


## STEP 2 — Missing Value
**Fungsi:** Menangani data hilang (berdasarkan ringkasan data hara).

**Konfigurasi:**
| Kolom | Metode |
|:---|:---|
| pH, N, P, K, C-Organik, Kadar Air, BD | **Mean** (Rata-rata) |
| Tekstur Tanah | **Most Frequent Value** (Modus) |

**📸 Screenshot Konfigurasi & Output**
> ![image](https://www.image2url.com/r2/default/images/1776823212447-4495e128-ba75-489c-96e8-c704f39597a8.png)
> ![image](https://www.image2url.com/r2/default/images/1776823130600-26b08550-c567-4577-ab13-d95e7378cce6.png)

---

## STEP 3 — One to Many
**Fungsi:** Mengubah data tekstur (String) menjadi kolom numerik agar bisa dihitung jaraknya oleh KNN.

**Konfigurasi:**
* **Columns to transform:** `Tekstur Tanah` ✅
* **Label** tetap di *Available columns*.

**📸 Screenshot Konfigurasi & Output**
| Konfigurasi | Output Dummy Columns |
|---|---|
| ![image](https://www.image2url.com/r2/default/images/1776823416954-c2c3d833-d1b8-47e2-83aa-8e5b494d947b.png) | ![image](https://www.image2url.com/r2/default/images/1776823520162-2843af1c-9570-4675-b681-c0d1d203fafc.png) |

---

## STEP 4 — Normalizer
**Fungsi:** Menyamakan skala semua fitur ke rentang [0, 1].

**Konfigurasi:**
* **Method:** Min-Max Normalization.
* **Includes:** Semua fitur numerik hasil Step 3.

**📸 Screenshot Konfigurasi & Output**
> ![image](https://www.image2url.com/r2/default/images/1776823589547-96f1a2f8-65fa-408b-9987-2c225cf0151f.png)
> ![image](https://www.image2url.com/r2/default/images/1776823663262-42861366-5d81-4c8b-abe5-997322b8e117.png)

---

## STEP 5 — Column Filter
**Fungsi:** Memastikan hanya fitur hara dan Label yang masuk ke model.

**Konfigurasi:**
* **Excludes:** `ID` (karena ID bukan indikator kesuburan).

> ![image](https://www.image2url.com/r2/default/images/1776824201983-d9125cc8-e11b-4dd0-b9da-45b4cb175e12.png)

---

## STEP 6 — Table Partitioner
**Fungsi:** Membagi data untuk proses belajar dan uji coba.

**Konfigurasi:**
* **Relative size:** 80% (Training).
* **Sampling strategy:** Stratified (pada kolom `Label`).

> ![image](https://www.image2url.com/r2/default/images/1776824257319-86c744bf-2b5c-4c7e-9ef6-d91a2fc08bff.png)

---

## STEP 7 — K Nearest Neighbor (Learner)
**Fungsi:** Mencari pola kedekatan antar data tanah.

**Konfigurasi:**
* **Class labels:** `Label`.
* **k:** 5 (atau sesuai hasil eksperimen).

> ![image](https://www.image2url.com/r2/default/images/1776824314238-fd80c9c9-a007-4242-b291-9a83f71f5e86.png)

---

## STEP 8 — KNN Predictor & Step 9 — Scorer
**Fungsi:** Melakukan prediksi dan melihat hasil akurasi.

**📸 Screenshot Koneksi & Output Prediksi**
> ![image](https://www.image2url.com/r2/default/images/1776824392629-70db3a56-2181-4996-9b6a-5fe3f9f7cc29.png)
> ![image](https://www.image2url.com/r2/default/images/1776824507784-200cec2f-e7ff-4d30-ad82-918589e50ae9.png)

---

## 📊 Hasil Evaluasi

### Confusion Matrix
> ![image](https://www.image2url.com/r2/default/images/1776824599718-571e8634-9407-46ef-8c5e-a789ccebedc8.png)

### Accuracy Statistics
> ![image](https://www.image2url.com/r2/default/images/1776824677370-36f9d67a-ddaf-481a-81d5-2dc47be1561b.png)


---
**Dibuat oleh:** Moh Rafie Nazar J  
**Instansi:** Teknik Informatika  
**Project:** UTS (Analisis Kesuburan Tanah - KNIME Analytics Platform)