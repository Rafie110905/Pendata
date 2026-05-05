# 🧠 KLASIFIKASI NAIVE BAYESIAN
> **Data Mining: Concepts and Techniques** | 

---

## ⚡ Supervised vs Unsupervised Learning

| Mode | Keterangan |
|------|-----------|
| **Supervised (Classification)** | Data training punya label kelas → data baru diklasifikasi berdasar training |
| **Unsupervised (Clustering)** | Label kelas tidak diketahui → tujuan menemukan pola/kelompok |

---

## 📌 Klasifikasi vs Prediksi

- **Klasifikasi** → prediksi label kelas (diskrit/kontinu), membangun model dari data training
- **Prediksi** → memodelkan fungsi kontinu, memprediksi nilai yang tidak diketahui
- **Contoh aplikasi:**
  - Persetujuan kredit/pinjaman
  - Diagnosa medis (hepatitis A vs B)
  - Deteksi kegagalan sistem

---

## 🛠️ Issues: Data Preparation

```
1. Data Cleaning      → Kurangi noise, atasi missing values
2. Feature Selection  → Hapus atribut tidak relevan / redundan
3. Data Transformation → Normalisasi data
```

---

## 📊 Issues: Evaluating Classification Methods

- **Akurasi** → keakuratan label class & prediksi nilai
- **Kecepatan** → training time & classification time
- **Kehandalan** → mengatasi noise & missing values

---

## 🔢 Bayesian Theorem

Dari training data **X**, posterior probability kelas C:

$$P(C|\mathbf{X}) = \frac{P(\mathbf{X}|C) \cdot P(C)}{P(\mathbf{X})}$$

> **posterior = likelihood × prior / evidence**

Prediksi **X** sebagai kelas C₂ jika dan hanya jika:
$$P(C_2|\mathbf{X}) \geq P(C_k|\mathbf{X}) \quad \forall k$$

---

## 🤖 Naive Bayes Classifier

### Formulasi

Given D = record training dengan n atribut **X** = (x₁, x₂, ..., xₙ) dan m kelas C₁, C₂, ..., Cₘ:

**Tujuan:** Maksimumkan → `P(Cᵢ|X) = P(X|Cᵢ) · P(Cᵢ)`

### Asumsi Naïve: Conditional Independence

$$P(\mathbf{X}|C_i) = \prod_{k=1}^{n} P(x_k|C_i)$$

### Untuk Atribut Kategorikal
```
P(xₖ|Cᵢ) = jumlah record di Cᵢ dengan nilai xₖ / |Cᵢ,D|
```

### Untuk Atribut Kontinu (Gaussian)

$$g(x, \mu, \sigma) = \frac{1}{\sqrt{2\pi}\sigma} e^{-\frac{(x-\mu)^2}{2\sigma^2}}$$

$$P(\mathbf{X}|C_i) = g(x_k, \mu_{C_i}, \sigma_{C_i})$$

---

## 🧮 Contoh: buys_computer Dataset

**Dataset:** 14 record, 4 atribut (age, income, student, credit_rating)

**Data sampel X:**
```
age=<=30, income=medium, student=yes, credit_rating=fair
```

### Prior Probabilities
```
P(buys_computer=yes) = 9/14 = 0.643
P(buys_computer=no)  = 5/14 = 0.357
```

### Conditional Probabilities

| Atribut | P(x|yes) | P(x|no) |
|---------|----------|---------|
| age=<=30 | 2/9 = 0.222 | 3/5 = 0.600 |
| income=medium | 4/9 = 0.444 | 2/5 = 0.400 |
| student=yes | 6/9 = 0.667 | 1/5 = 0.200 |
| credit=fair | 6/9 = 0.667 | 2/5 = 0.400 |

### Hasil Klasifikasi

```
P(X|yes) = 0.222 × 0.444 × 0.667 × 0.667 = 0.044
P(X|no)  = 0.600 × 0.400 × 0.200 × 0.400 = 0.019

P(X|yes) × P(yes) = 0.044 × 0.643 = 0.028  ✅ WINNER
P(X|no)  × P(no)  = 0.019 × 0.357 = 0.007
```

**→ X diklasifikasikan sebagai: `buys_computer = YES`** 🎯

---

## ⚠️ Menghindari Probabilitas 0: Laplacian Correction

Masalah: jika satu nilai tidak muncul di training → probabilitas = 0 → merusak seluruh kalkulasi

**Solusi: Tambahkan 1 ke setiap count**

```
Contoh (1000 record, income low=0, medium=990, high=10):

Tanpa Laplace:  P(income=low) = 0/1000 = 0  ❌ MASALAH!
Dengan Laplace:
  P(income=low)    = (0+1) / (1000+3) = 1/1003
  P(income=medium) = (990+1) / (1000+3) = 991/1003
  P(income=high)   = (10+1) / (1000+3) = 11/1003  ✅
```

---

## ✅ Keuntungan & ❌ Kerugian Naive Bayes

| | Keterangan |
|--|-----------|
| ✅ **Mudah diimplementasikan** | Komputasi sederhana dan cepat |
| ✅ **Hasil baik di banyak kasus** | Efektif untuk high-dimensional data |
| ❌ **Asumsi independence** | Jarang terpenuhi di dunia nyata |
| ❌ **Tidak bisa model dependency** | Contoh: age ↔ income ↔ disease |

---

## 🕸️ Bayesian Belief Networks (BBN)

Solusi untuk keterbatasan Naive Bayes → memungkinkan **sebagian variabel saling bergantung**

```
         [play]
        /  |   \
   [outlook] [temperature] [windy]
        \         /
        [humidity]
```

- **Node** = variabel bebas
- **Links** = arah ketergantungan (DAG - Directed Acyclic Graph)
- Tidak ada loop/siklus

### Contoh: Weather/Play Dataset dengan Laplace

```
P(play=yes) = (9+1)/(14+2) = 0.625
P(play=no)  = (5+1)/(14+2) = 0.375

P(outlook=sunny|play=yes)    = (2+1)/(9+3) = 0.250
P(outlook=overcast|play=yes) = (4+1)/(9+3) = 0.417
P(outlook=rainy|play=yes)    = (3+1)/(9+3) = 0.333
```

### Klasifikasi: X = (Sunny, Cool, High, True)

```
P(yes|X) = α × 0.625 × 0.25 × 0.4 × 0.2 × 0.5 = α × 0.00625
P(no|X)  = α × 0.375 × 0.5 × 0.167 × 0.333 × 0.4 = α × 0.00417

α = 1/(0.00625 + 0.00417) = 95.969

P(play=yes|X) = 95.969 × 0.00625 = 0.60  ✅
P(play=no|X)  = 95.969 × 0.00417 = 0.40

→ PREDIKSI: play = YES (60%)
```

---

## 🐍 Implementasi Python (Full Script — sklearn)

> Referensi sklearn: https://scikit-learn.org/stable/api/sklearn.naive_bayes.html

```python
"""
╔══════════════════════════════════════════════════════════════╗
║         PROYEK: KLASIFIKASI NAIVE BAYES                     ║
║         Menggunakan scikit-learn (sklearn)                   ║
║         Data Mining | May 2026                              ║
╚══════════════════════════════════════════════════════════════╝

Dataset yang digunakan:
  1. buys_computer dataset  (dari materi kuliah - manual)
  2. Iris dataset           (dari sklearn - sebagai bonus)

Referensi sklearn:
  https://scikit-learn.org/stable/api/sklearn.naive_bayes.html
"""

# ─────────────────────────────────────────────
# IMPORT LIBRARY
# ─────────────────────────────────────────────
import numpy as np
import pandas as pd
from sklearn.naive_bayes import GaussianNB, CategoricalNB
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.metrics import (
    classification_report,
    confusion_matrix,
    accuracy_score
)
from sklearn.preprocessing import LabelEncoder
from sklearn.datasets import load_iris
import warnings
warnings.filterwarnings('ignore')


# ══════════════════════════════════════════════
# BAGIAN 1: Dataset buys_computer (dari kuliah)
# ══════════════════════════════════════════════

def load_buys_computer_dataset():
    """
    Dataset dari slide kuliah (14 record).
    Atribut: age, income, student, credit_rating
    Label  : buys_computer (yes/no)
    """
    data = {
        'age':           ['<=30','<=30','31..40','>40','>40','>40','31..40',
                          '<=30','<=30','>40','<=30','31..40','31..40','>40'],
        'income':        ['high','high','high','medium','low','low','low',
                          'medium','low','medium','medium','medium','high','medium'],
        'student':       ['no','no','no','no','yes','yes','yes',
                          'no','yes','yes','yes','no','yes','no'],
        'credit_rating': ['fair','excellent','fair','fair','fair','excellent',
                          'excellent','fair','fair','fair','excellent','excellent',
                          'fair','excellent'],
        'buys_computer': ['no','no','yes','yes','yes','no','yes',
                          'no','yes','yes','yes','yes','yes','no']
    }
    return pd.DataFrame(data)


def encode_categorical(df, target_col='buys_computer'):
    """Label encode semua kolom kategorikal."""
    encoders = {}
    df_encoded = df.copy()
    for col in df.columns:
        le = LabelEncoder()
        df_encoded[col] = le.fit_transform(df[col])
        encoders[col] = le
    return df_encoded, encoders


def bagian1_buys_computer():
    print("=" * 60)
    print("📦 BAGIAN 1: Dataset buys_computer (Manual / Kuliah)")
    print("=" * 60)

    # Load dan tampilkan dataset
    df = load_buys_computer_dataset()
    print("\n📋 Dataset:")
    print(df.to_string(index=False))

    # Encode
    df_enc, encoders = encode_categorical(df)

    X = df_enc.drop('buys_computer', axis=1)
    y = df_enc['buys_computer']

    # ── Training dengan SEMUA data (karena kecil) ──
    model = CategoricalNB(alpha=1.0)   # alpha=1 = Laplacian Correction
    model.fit(X, y)

    # ── Prediksi sampel dari slide kuliah ──
    # X = (age<=30, income=medium, student=yes, credit_rating=fair)
    sample_raw = {
        'age': '<=30',
        'income': 'medium',
        'student': 'yes',
        'credit_rating': 'fair'
    }
    sample_encoded = []
    for col in X.columns:
        val = encoders[col].transform([sample_raw[col]])[0]
        sample_encoded.append(val)

    sample_arr = np.array([sample_encoded])
    pred = model.predict(sample_arr)
    pred_proba = model.predict_proba(sample_arr)
    label = encoders['buys_computer'].inverse_transform(pred)[0]
    classes = encoders['buys_computer'].classes_

    print(f"\n🔍 Sampel X dari kuliah: {sample_raw}")
    print(f"\n📊 Probabilitas:")
    for cls, prob in zip(classes, pred_proba[0]):
        marker = "← PREDIKSI" if cls == label else ""
        print(f"   P(buys_computer={cls}|X) = {prob:.4f}  {marker}")
    print(f"\n✅ Hasil Prediksi: buys_computer = '{label.upper()}'")

    # ── Accuracy dengan cross-validation (5-fold) ──
    scores = cross_val_score(model, X, y, cv=5, scoring='accuracy')
    print(f"\n📈 Cross-Validation Accuracy (5-fold): {scores.mean():.4f} ± {scores.std():.4f}")
    print()


# ══════════════════════════════════════════════
# BAGIAN 2: Dataset Iris (sklearn built-in)
# ══════════════════════════════════════════════

def bagian2_iris():
    print("=" * 60)
    print("🌸 BAGIAN 2: Dataset Iris (GaussianNB - Atribut Kontinu)")
    print("=" * 60)

    # Load dataset
    iris = load_iris()
    X = pd.DataFrame(iris.data, columns=iris.feature_names)
    y = pd.Series(iris.target)
    class_names = iris.target_names

    print(f"\n📋 Info Dataset:")
    print(f"   Jumlah sampel  : {len(X)}")
    print(f"   Jumlah fitur   : {X.shape[1]}")
    print(f"   Kelas          : {list(class_names)}")
    print(f"\n📊 Statistik Fitur:")
    print(X.describe().round(3).to_string())

    # Split train/test (80/20)
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )
    print(f"\n✂️  Train: {len(X_train)} sampel | Test: {len(X_test)} sampel")

    # Train GaussianNB (untuk atribut kontinu)
    model = GaussianNB()
    model.fit(X_train, y_train)

    # Evaluasi
    y_pred = model.predict(X_test)
    acc = accuracy_score(y_test, y_pred)

    print(f"\n🎯 Accuracy: {acc:.4f} ({acc*100:.2f}%)")
    print("\n📄 Classification Report:")
    print(classification_report(y_test, y_pred, target_names=class_names))

    print("🔲 Confusion Matrix:")
    cm = confusion_matrix(y_test, y_pred)
    cm_df = pd.DataFrame(cm, index=class_names, columns=class_names)
    print(cm_df.to_string())

    # Cross-validation
    cv_scores = cross_val_score(model, X, y, cv=10, scoring='accuracy')
    print(f"\n📈 Cross-Validation Accuracy (10-fold): {cv_scores.mean():.4f} ± {cv_scores.std():.4f}")

    # Prior probability per kelas
    print(f"\n📌 Prior Probability (P(Cᵢ)) dari training:")
    for i, cls in enumerate(class_names):
        prior = model.class_prior_[i]
        print(f"   P({cls}) = {prior:.4f}")

    # Prediksi satu sampel baru
    sample_new = np.array([[5.1, 3.5, 1.4, 0.2]])
    pred_class = model.predict(sample_new)[0]
    pred_proba = model.predict_proba(sample_new)[0]
    print(f"\n🔍 Prediksi sampel baru {list(sample_new[0])}:")
    for cls, prob in zip(class_names, pred_proba):
        marker = "← PREDIKSI" if class_names[pred_class] == cls else ""
        print(f"   P({cls}|X) = {prob:.6f}  {marker}")
    print()


# ══════════════════════════════════════════════
# BAGIAN 3: Penjelasan Laplacian Correction
# ══════════════════════════════════════════════

def bagian3_laplacian_demo():
    print("=" * 60)
    print("🔧 BAGIAN 3: Demo Laplacian Correction")
    print("=" * 60)

    print("""
Masalah:
  Jika satu nilai atribut tidak pernah muncul di training set
  untuk suatu kelas, maka P(xₖ|Cᵢ) = 0, dan seluruh
  P(X|Cᵢ) = 0 → klasifikasi rusak!

Solusi: Laplacian Correction (alpha=1 di CategoricalNB)
  Tambahkan 1 ke setiap count

Contoh (1000 record):
  income=low    : 0 record
  income=medium : 990 record
  income=high   : 10 record

Tanpa Laplace:
  P(income=low)    = 0/1000  = 0.000   ← MASALAH!

Dengan Laplace (tambah 1 per nilai, ada 3 nilai income):
  P(income=low)    = (0+1)/(1000+3) = 0.001
  P(income=medium) = (990+1)/(1000+3) = 0.987
  P(income=high)   = (10+1)/(1000+3) = 0.011
""")

    # Demo dengan CategoricalNB alpha
    print("Demo alpha=0 (tanpa Laplace) vs alpha=1 (dengan Laplace):")
    df = load_buys_computer_dataset()
    df_enc, encoders = encode_categorical(df)
    X = df_enc.drop('buys_computer', axis=1)
    y = df_enc['buys_computer']

    for alpha in [0.0, 0.5, 1.0]:
        model = CategoricalNB(alpha=alpha)
        scores = cross_val_score(model, X, y, cv=5, scoring='accuracy')
        print(f"   alpha={alpha:.1f} → CV Accuracy: {scores.mean():.4f} ± {scores.std():.4f}")
    print()


# ══════════════════════════════════════════════
# MAIN
# ══════════════════════════════════════════════

if __name__ == "__main__":
    print("""
╔══════════════════════════════════════════════════════════════╗
║   🧠 NAIVE BAYES CLASSIFIER — Python Sklearn Implementation  ║
╚══════════════════════════════════════════════════════════════╝
""")
    bagian1_buys_computer()
    bagian2_iris()
    bagian3_laplacian_demo()
    print("=" * 60)
    print("✅ Selesai! Semua klasifikasi berhasil dijalankan.")
    print("=" * 60)
```

---

*📚 Referensi: Data Mining Concepts and Techniques | Naive Bayesian Classification*  
*🔗 sklearn docs: https://scikit-learn.org/stable/api/sklearn.naive_bayes.html*
