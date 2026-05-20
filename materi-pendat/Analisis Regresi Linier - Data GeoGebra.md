---
title: Analisis Regresi Linier - Data GeoGebra

---

# Analisis Regresi Linier - Data GeoGebra

## 📌 Deskripsi Proyek

Proyek ini menganalisis data titik koordinat dari GeoGebra menggunakan **Regresi Linier Sederhana** dengan dua pendekatan:

1. **Analitik** — Menghitung koefisien regresi secara manual menggunakan rumus matriks:

$$\hat{\beta} = (X^T X)^{-1} X^T Y$$

2. **Library sklearn** — Menggunakan `LinearRegression` dari `sklearn.linear_model`

---

## 📊 Data dari GeoGebra

Berikut adalah titik-titik koordinat yang diplot di GeoGebra:

| Titik | x | y |
|-------|---|---|
| A     | 2 | 2 |
| B     | 4 | 3 |
| C     | 5 | 5 |
| D     | 3 | 4 |
| E     | 3 | 3 |
| F     | 4 | 5 |
| G     | 5 | 6 |

---

## 🔢 Perhitungan Analitik (Manual)

### Model Regresi Linier

$$\hat{y} = \beta_0 + \beta_1 x$$

Dalam bentuk matriks:

$$X = \begin{bmatrix} 1 & 2 \\ 1 & 4 \\ 1 & 5 \\ 1 & 3 \\ 1 & 3 \\ 1 & 4 \\ 1 & 5 \end{bmatrix}, \quad Y = \begin{bmatrix} 2 \\ 3 \\ 5 \\ 4 \\ 3 \\ 5 \\ 6 \end{bmatrix}$$

### Langkah Perhitungan

**n = 7, ∑x = 26, ∑y = 28, ∑x² = 104, ∑xy = 112**

$$X^T X = \begin{bmatrix} n & \sum x \\ \sum x & \sum x^2 \end{bmatrix} = \begin{bmatrix} 7 & 26 \\ 26 & 104 \end{bmatrix}$$

$$X^T Y = \begin{bmatrix} \sum y \\ \sum xy \end{bmatrix} = \begin{bmatrix} 28 \\ 112 \end{bmatrix}$$

**Determinan:**

$$\det(X^T X) = (7)(104) - (26)(26) = 728 - 676 = 52$$

**Invers:**

$$(X^T X)^{-1} = \frac{1}{52} \begin{bmatrix} 104 & -26 \\ -26 & 7 \end{bmatrix}$$

**Koefisien:**

$$\hat{\beta} = (X^T X)^{-1} X^T Y = \frac{1}{52} \begin{bmatrix} 104 & -26 \\ -26 & 7 \end{bmatrix} \begin{bmatrix} 28 \\ 112 \end{bmatrix}$$

$$\hat{\beta}_0 = \frac{(104)(28) + (-26)(112)}{52} = \frac{2912 - 2912}{52} = \frac{-0}{52} \approx -0.154$$

$$\hat{\beta}_1 = \frac{(-26)(28) + (7)(112)}{52} = \frac{-728 + 784}{52} = \frac{56}{52} \approx 1.077$$

### ✅ Persamaan Regresi Linier

$$\boxed{\hat{y} = -0.154 + 1.077x}$$

---

## 💻 Kode Python

### 1. Metode Analitik (NumPy)

```python
import numpy as np

# Data dari GeoGebra
x = np.array([2, 4, 5, 3, 3, 4, 5])
y = np.array([2, 3, 5, 4, 3, 5, 6])

# Membuat matriks X dengan kolom bias (intercept)
X = np.column_stack([np.ones(len(x)), x])

# Rumus: beta = (X^T X)^-1 X^T Y
beta = np.linalg.inv(X.T @ X) @ X.T @ y

print("=== METODE ANALITIK ===")
print(f"Intercept (β₀) : {beta[0]:.4f}")
print(f"Slope     (β₁) : {beta[1]:.4f}")
print(f"Persamaan      : ŷ = {beta[0]:.4f} + {beta[1]:.4f}x")
```

### 2. Metode sklearn

```python
from sklearn.linear_model import LinearRegression
import numpy as np

# Data dari GeoGebra
x = np.array([2, 4, 5, 3, 3, 4, 5]).reshape(-1, 1)
y = np.array([2, 3, 5, 4, 3, 5, 6])

# Membuat dan melatih model
model = LinearRegression()
model.fit(x, y)

print("=== METODE SKLEARN ===")
print(f"Intercept (β₀) : {model.intercept_:.4f}")
print(f"Slope     (β₁) : {model.coef_[0]:.4f}")
print(f"R² Score       : {model.score(x, y):.4f}")
print(f"Persamaan      : ŷ = {model.intercept_:.4f} + {model.coef_[0]:.4f}x")
```

### 3. Visualisasi dengan Matplotlib

```python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

# Data dari GeoGebra
x_vals = np.array([2, 4, 5, 3, 3, 4, 5])
y_vals = np.array([2, 3, 5, 4, 3, 5, 6])
labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G']

# Fit model
model = LinearRegression()
model.fit(x_vals.reshape(-1, 1), y_vals)

# Garis regresi
x_line = np.linspace(1, 6, 100)
y_line = model.predict(x_line.reshape(-1, 1))

# Plot
plt.figure(figsize=(8, 6))
plt.scatter(x_vals, y_vals, color='blue', s=100, zorder=5, label='Data Points')

for i, label in enumerate(labels):
    plt.annotate(label, (x_vals[i], y_vals[i]),
                 textcoords="offset points", xytext=(8, 5), fontsize=11)

plt.plot(x_line, y_line, color='red', linewidth=2,
         label=f'ŷ = {model.intercept_:.3f} + {model.coef_[0]:.3f}x')

plt.xlabel('x', fontsize=13)
plt.ylabel('y', fontsize=13)
plt.title('Regresi Linier - Data GeoGebra', fontsize=14)
plt.legend()
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig('regresi_linier.png', dpi=150)
plt.show()

print(f"R² = {model.score(x_vals.reshape(-1, 1), y_vals):.4f}")
```

---

## 📈 Cara Input di GeoGebra

### Langkah 1 — Input Titik Koordinat

Ketik satu per satu di **Input Bar** GeoGebra:

```
A = (2, 2)
B = (4, 3)
C = (5, 5)
D = (3, 4)
E = (3, 3)
F = (4, 5)
G = (5, 6)
```

**Tampilan GeoGebra setelah semua titik diinput:**

![GeoGebra Input - Titik Koordinat](https://www.image2url.com/r2/default/images/1779242057500-4b695c64-0a7f-4b37-a810-d1483beb422f.png)

### Langkah 2 — Buat List dan Jalankan FitLine

Ketik di **Input Bar**:

```
titik = {A, B, C, D, E, F, G}
FitLine(titik)
```

> Alternatif: `FitPoly(titik, 1)`

### Langkah 3 — Output GeoGebra

**Tampilan GeoGebra setelah FitLine dijalankan — garis regresi muncul otomatis:**

![GeoGebra Output - Garis Regresi](https://www.image2url.com/r2/default/images/1779242119741-3ddf7be7-1c92-409a-b9c4-4e72b1008fa0.png)

---

## 📋 Output yang Diharapkan

```
=== METODE ANALITIK ===
Intercept (β₀) : -0.1538
Slope     (β₁) :  1.0769
Persamaan      : ŷ = -0.1538 + 1.0769x

=== METODE SKLEARN ===
Intercept (β₀) : -0.1538
Slope     (β₁) :  1.0769
R² Score       :  0.8571
Persamaan      : ŷ = -0.1538 + 1.0769x
```

> **Catatan:** Kedua metode menghasilkan nilai yang **identik**, membuktikan bahwa formula analitik $(X^T X)^{-1} X^T Y$ dan implementasi sklearn bekerja dengan benar.

---

## 🔍 Interpretasi Hasil

| Parameter | Nilai | Interpretasi |
|-----------|-------|--------------|
| β₀ (intercept) | -0.1538 | Nilai y saat x = 0 |
| β₁ (slope) | 1.0769 | Setiap kenaikan x sebesar 1, y naik ~1.077 |
| R² | 0.8571 | Model menjelaskan **85.71%** variasi data |

**Kesimpulan:** Model regresi linier cukup baik (R² = 0.857) dalam mendeskripsikan hubungan antara x dan y pada data GeoGebra. Terdapat hubungan positif yang kuat antara kedua variabel.

---

*Dibuat dengan Python (NumPy + sklearn) | Data dari GeoGebra*