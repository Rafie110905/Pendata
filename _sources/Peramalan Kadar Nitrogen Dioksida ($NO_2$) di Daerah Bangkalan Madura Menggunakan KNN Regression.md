---
title: Peramalan Kadar Nitrogen Dioksida ($NO_2$) di Daerah Bangkalan Madura Menggunakan KNN Regression

---

# 🌫️ Peramalan Kadar NO₂ di Daerah Bangkalan Madura

> 📅 **Periode Data:** 1 Januari 2024 – 1 Maret 2026
> 📍 **Lokasi:** Kabupaten Bangkalan, Madura, Jawa Timur
> 🛰️ **Sumber Data:** Sentinel-5P (TROPOMI) via Copernicus Data Space Ecosystem

---

## 📋 Daftar Isi

1. [🌍 Latar Belakang](#-latar-belakang)
2. [📥 Pengumpulan Data](#-1-pengumpulan-data)
3. [🔧 Preprocessing Data](#-2-preprocessing-data)
4. [🤖 Modeling KNN Regression](#-3-modeling-menggunakan-knn-regression)
5. [✅ Kesimpulan](#-kesimpulan)

---

## 🌍 Latar Belakang

Peningkatan aktivitas industri, transportasi, serta pertumbuhan populasi yang pesat telah menyebabkan peningkatan signifikan terhadap tingkat pencemaran udara di berbagai wilayah. Salah satu polutan udara utama yang menjadi perhatian adalah **Nitrogen Dioksida (NO₂)**, yaitu gas beracun yang dihasilkan terutama dari proses pembakaran bahan bakar fosil seperti kendaraan bermotor, pembangkit listrik, dan kegiatan industri.

NO₂ memiliki dampak serius terhadap kesehatan manusia, seperti:
- 😷 Gangguan pernapasan
- 🫁 Iritasi paru-paru
- 🤒 Memperburuk penyakit asma dan bronkitis

Selain itu, NO₂ juga berkontribusi terhadap pembentukan **hujan asam** 🌧️ dan penurunan kualitas lingkungan secara keseluruhan.

---

## 📥 1. Pengumpulan Data

Data Time Series Harian kadar NO₂ di daerah Bangkalan diambil dari website **[Copernicus Data Space](https://dataspace.copernicus.eu/)**.

### 🔌 1.1 Install & Koneksi ke Copernicus

```python
pip install openeo
```

```python
import openeo

connection = openeo.connect("openeo.dataspace.copernicus.eu").authenticate_oidc()
```

**🖥️ Output:**
```
Visit (link authentikasi) 📋 to authenticate.
✅ Authorized successfully
Authenticated using device code flow.
```

### 🗺️ 1.2 Pengambilan Data NO₂ Bangkalan (2024–2026)

Koordinat wilayah Bangkalan diperoleh dari [geojson.io](https://geojson.io). Data diambil dari tanggal **1 Januari 2024** sampai **1 Maret 2026**.

```python
aoi = {
    "type": "Polygon",
    "coordinates": [[
        [113.09, -6.89],
        [112.68, -6.89],
        [112.68, -7.20],
        [113.09, -7.20],
        [113.09, -6.89],
    ]]
}

s5post = connection.load_collection(
    "SENTINEL_5P_L2",
    temporal_extent=["2024-01-01", "2026-03-01"],
    spatial_extent={
        "west":  112.68,
        "south": -7.20,
        "east":  113.09,
        "north": -6.89
    },
    bands=["NO2"],
)

# Agregasi harian
s5p_no2_daily = s5post.aggregate_temporal_period(reducer="mean", period="day")

# Eksekusi batch job
job = s5p_no2_daily.execute_batch(
    title="NO2 Bangkalan 2024-2026",
    outputfile="NO2Bangkalan.nc"
)
```

**🖥️ Output:**
```
0:00:00 Job 'j-260603014205411dac1a563e3dccea8c': send 'start'
0:00:25 Job 'j-260603014205411dac1a563e3dccea8c': queued (progress 0%)
0:01:08 Job 'j-260603014205411dac1a563e3dccea8c': running (progress N/A)
...
0:07:00 Job 'j-260603014205411dac1a563e3dccea8c': finished (progress 100%) ✅
```

> 💡 **Catatan:** Setelah selesai, file `NO2Bangkalan.nc` dapat diunduh dari halaman [OpenEO Web Editor](https://editor.openeo.org/?server=https%3A%2F%2Fopeneo.dataspace.copernicus.eu%2Fopeneo%2F1.2).

---

## 🔧 2. Preprocessing Data

### 📂 2.1 Ekstrak Data dari File .nc

Setelah mengunduh file `.nc`, kita membaca dan mengekstrak variabel NO₂ serta waktu.

```python
import netCDF4

file_path = "NO2Bangkalan.nc"
ds = netCDF4.Dataset(file_path)

# Lihat seluruh variabel yang tersedia
print("📦 Variabel dalam file:")
print(ds.variables.keys())

# Ambil NO2 dan Time
no2  = ds.variables["NO2"][:]
time = ds.variables["t"][:]

# Konversi waktu ke format tanggal
try:
    time_units = ds.variables["t"].units
    dates = netCDF4.num2date(time, units=time_units)
except Exception:
    dates = time

# Tampilkan struktur data NO2
print(type(no2))
print(len(no2))
print(len(no2[0]))
print(len(no2[0][0]))
print(no2[0][0][0])
```

**🖥️ Output:**
```
📦 Variabel dalam file:
dict_keys(['t', 'x', 'y', 'crs', 'NO2'])
<class 'numpy.ma.MaskedArray'>
784
9
8
3.1133957e-05
```

📊 Struktur data NO₂ per baris adalah array berukuran **`[784 x 9 x 8]`**:

| Dimensi | Nilai | Keterangan |
|---------|-------|------------|
| Waktu   | 784   | Jumlah hari data |
| Grid Y  | 9     | Jumlah baris spasial |
| Grid X  | 8     | Jumlah kolom spasial |

### ❓ 2.2 Contoh Data (Ada Missing Value `--`)

```python
print("Contoh data pertama:")
for i in range(0, 10):
    print(no2[i])
```

**🖥️ Output (contoh):**
```
[[3.113e-05  3.113e-05  --  --  --  --  --  --]
 [5.017e-05  5.017e-05  --  --  --  --  --  --]
 ...
 [-- -- -- -- -- -- -- --]]
```

> ⚠️ Terlihat banyak nilai `--` yang merupakan **missing value**. Ini wajar karena satelit Sentinel-5P tidak selalu merekam semua piksel grid setiap hari.

---

### 🔄 a. Atasi Missing Value — Interpolasi Linear per Grid

```python
import numpy as np
import pandas as pd

# Interpolasi missing value per grid
no2_filled = np.ma.copy(no2).filled(np.nan)

for i in range(no2.shape[1]):      # 9 baris grid
    for j in range(no2.shape[2]):  # 8 kolom grid
        series = pd.Series(no2[:, i, j])
        no2_filled[:, i, j] = series.interpolate(
            method='linear', limit_direction='both'
        ).values
```

> ✅ Setiap titik grid yang memiliki nilai `--` diisi otomatis menggunakan **Interpolasi Linear** berdasarkan nilai sebelum dan sesudahnya.

---

### 📊 b. Rata-ratakan Data & Simpan CSV

Setelah interpolasi, NO₂ di 9×8 grid dirata-ratakan menjadi **1 nilai per hari**, lalu disimpan ke CSV.

```python
new_dates  = []
no2_values = []

for i in range(len(dates)):
    new_dates.append(dates[i].strftime('%Y-%m-%d'))
    no2_values.append(np.mean(no2_filled[i]))

df = pd.DataFrame({"date": new_dates, "NO2": no2_values})
df.to_csv("NO2_Bangkalan_timeseries.csv", index=False)

print(df.head(10))
print(df.info())
```

**🖥️ Output:**
```
         date       NO2
0  2024-01-02  0.000031
1  2024-01-03  0.000031
2  2024-01-04  0.000030
3  2024-01-05  0.000033
4  2024-01-06  0.000033
5  2024-01-07  0.000034
6  2024-01-08  0.000034
7  2024-01-09  0.000035
8  2024-01-10  0.000030
9  2024-01-11  0.000031

RangeIndex: 784 entries, 0 to 783
 #   Column  Non-Null Count  Dtype
 0   date    784 non-null    object
 1   NO2     784 non-null    float32
```

---

### 📅 c. Pengecekan Missing Value Harian

Setelah data berbentuk CSV, kita cek kelengkapan data Time Series harian.

```python
import pandas as pd
import numpy as np

df = pd.read_csv("NO2_Bangkalan_timeseries.csv")
df['date'] = pd.to_datetime(df['date'])

start_date = "2024-01-01"
end_date   = "2026-03-01"
full_range = pd.date_range(start=start_date, end=end_date, freq='D')

missing_dates = full_range.difference(df['date'])
print(f"Jumlah hari missing: {len(missing_dates)}")
print("Daftar tanggal missing:")
print(missing_dates)
```

**🖥️ Output:**
```
Jumlah hari missing: 7
Daftar tanggal missing:
DatetimeIndex(['2024-01-01', '2024-03-23', '2024-08-12', '2025-01-30',
               '2025-01-31', '2026-02-24', '2026-03-01'],
              dtype='datetime64[ns]', freq=None)
```

> 🔍 Ditemukan **7 hari missing**. Kita isi kembali menggunakan Interpolasi Linear:

```python
df = df.sort_values('date').set_index('date').reindex(full_range)
df.index.name = 'date'

df['NO2'] = df['NO2'].interpolate(method='time')
df['NO2'] = df['NO2'].bfill().ffill()

df.to_csv("no2_timeseries_interpolated.csv")

missing_final = full_range.difference(df.index[df['NO2'].notna()])
print(f"Missing setelah interpolasi: {len(missing_final)}")
```

**🖥️ Output:**
```
Missing setelah interpolasi: 0 ✅
```

---

### 🚨 d. Deteksi Outlier — Metode IQR

Setelah missing value teratasi, kita deteksi outlier menggunakan **IQR (Interquartile Range)**.

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv("no2_timeseries_interpolated.csv")
df['date'] = pd.to_datetime(df['date'])

# Hitung IQR
Q1 = df['NO2'].quantile(0.25)
Q3 = df['NO2'].quantile(0.75)
IQR = Q3 - Q1
lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

# Filter outlier
outliers_iqr = df[(df['NO2'] < lower_bound) | (df['NO2'] > upper_bound)]
print("Jumlah Outlier (IQR):", len(outliers_iqr))
print(outliers_iqr[['date', 'NO2']].head())
```

**🖥️ Output:**
```
Jumlah Outlier (IQR): 2
          date       NO2
262 2024-09-19  0.000077
290 2024-10-17  0.000047
```

> 🔴 Ditemukan **2 data outlier** pada dataset 2024–2026.

**Visualisasi Deteksi Outlier:**

```python
plt.figure(figsize=(15, 5))
plt.plot(df['date'], df['NO2'], label="NO2", linewidth=1)
plt.scatter(outliers_iqr['date'], outliers_iqr['NO2'],
            color='red', marker='o', label="Outliers")
plt.axhline(upper_bound, color='orange', linestyle='dashed', label="Upper Bound (IQR)")
plt.axhline(lower_bound, color='blue',   linestyle='dashed', label="Lower Bound (IQR)")
plt.title("Deteksi Outlier Data NO2 (Metode IQR)")
plt.xlabel("Tanggal")
plt.ylabel("Kadar NO2")
plt.legend()
plt.tight_layout()
plt.xticks(
    ticks=[df['date'].iloc[0], df['date'].iloc[-1]],
    labels=[df['date'].iloc[0].strftime('%Y-%m-%d'),
            df['date'].iloc[-1].strftime('%Y-%m-%d')]
)
plt.show()
```

![image](https://www.image2url.com/r2/default/images/1780468456847-2bde0285-a918-4024-b8e3-2d64ce75a8d9.png)

---

**Hapus Outlier & Isi Kembali dengan Interpolasi:**

```python
# Jadikan outlier sebagai NaN
df['NO2_cleaned'] = df['NO2'].mask(
    (df['NO2'] < lower_bound) | (df['NO2'] > upper_bound)
)
print("Jumlah outlier:", df['NO2_cleaned'].isna().sum())

# Interpolasi linear untuk mengisi kembali nilai outlier
df['NO2_filled'] = df['NO2_cleaned'].interpolate(method='linear')
df['NO2_filled'] = df['NO2_filled'].bfill().ffill()
print("Jumlah missing setelah interpolasi:", df['NO2_filled'].isna().sum())
```

**🖥️ Output:**
```
Jumlah outlier: 2
Jumlah missing setelah interpolasi: 0 ✅
```

**Visualisasi Setelah Outlier Removal:**

```python
plt.figure(figsize=(15, 5))
plt.plot(df['date'], df['NO2_filled'], label="NO2 (Interpolated)", linewidth=1)
plt.xticks(
    ticks=[df['date'].iloc[0], df['date'].iloc[-1]],
    labels=[df['date'].iloc[0].strftime('%Y-%m-%d'),
            df['date'].iloc[-1].strftime('%Y-%m-%d')]
)
plt.title("Plot Data NO2 Setelah Outlier Removal & Interpolasi")
plt.xlabel("Tanggal")
plt.ylabel("Kadar NO2")
plt.legend()
plt.tight_layout()
plt.show()
```

![image](https://www.image2url.com/r2/default/images/1780468637487-bb85dd56-e804-4514-a414-1eb5c3585e94.png)

---

## 🤖 3. Modeling menggunakan KNN Regression

### 📐 a. Normalisasi Data (MinMax Scaler)

Karena menggunakan model KNN Regression, data perlu dinormalisasi ke rentang **0–1**.

```python
from sklearn.preprocessing import MinMaxScaler

scaler = MinMaxScaler()
df['NO2_scaled'] = scaler.fit_transform(df[['NO2_filled']])

print(df[['date', 'NO2_filled', 'NO2_scaled']].head())
```

**🖥️ Output:**
```
        date  NO2_filled  NO2_scaled
0 2024-01-01    0.000031    0.616193
1 2024-01-02    0.000031    0.616193
2 2024-01-03    0.000031    0.598840
3 2024-01-04    0.000030    0.581487
4 2024-01-05    0.000033    0.672595
```

---

### 🔗 b. Uji Korelasi Data (30 Lag)

Sebelum modeling, kita ubah data ke format **supervised learning** lalu uji korelasi fitur lag terhadap label **(t)**.

```python
import pandas as pd

def create_supervised(data, n_lag=4):
    df_supervised = pd.DataFrame()
    for i in range(n_lag, 0, -1):
        df_supervised[f'NO2(t-{i})'] = data.shift(i)
    df_supervised['NO2(t)'] = data
    df_supervised.dropna(inplace=True)
    return df_supervised

# Uji korelasi dengan 30 lag
supervised_df30 = create_supervised(df['NO2_scaled'], n_lag=30)

lag_cols     = supervised_df30.drop(columns="NO2(t)").columns
correlations = supervised_df30[lag_cols].corrwith(supervised_df30['NO2(t)'])
print(correlations)
```

**🖥️ Output:**
```
NO2(t-30)    0.389744
NO2(t-29)    0.414011
NO2(t-28)    0.427080
NO2(t-27)    0.415561
NO2(t-26)    0.396906
NO2(t-25)    0.388818
NO2(t-24)    0.373779
NO2(t-23)    0.372484
NO2(t-22)    0.377521
NO2(t-21)    0.373975
NO2(t-20)    0.363064
NO2(t-19)    0.353649
NO2(t-18)    0.356027
NO2(t-17)    0.355643
NO2(t-16)    0.376660
NO2(t-15)    0.394854
NO2(t-14)    0.408027
NO2(t-13)    0.411955
NO2(t-12)    0.418205
NO2(t-11)    0.439869
NO2(t-10)    0.471021
NO2(t-9)     0.494570
NO2(t-8)     0.516976  ✅
NO2(t-7)     0.527165  ✅
NO2(t-6)     0.542564  ✅
NO2(t-5)     0.570716  ✅
NO2(t-4)     0.607117  ✅
NO2(t-3)     0.668847  ✅
NO2(t-2)     0.746308  ✅
NO2(t-1)     0.857543  ✅
```

> 📈 Lag dengan **korelasi > 0.5** (fitur terbaik): **t-1 hingga t-8** (8 lag)
> Ini berbeda dengan referensi yang hanya t-1 s/d t-4, menunjukkan pola NO₂ lebih terstruktur di periode 2024–2026.

---

### 🗂️ c. Mengubah Data ke Format Supervised

```python
supervised_df4  = create_supervised(df['NO2_scaled'], n_lag=4)
supervised_df10 = create_supervised(df['NO2_scaled'], n_lag=10)

print(supervised_df4)
print(supervised_df4.shape)
```

**🖥️ Output (4 lag):**
```
            NO2(t-4)  NO2(t-3)  NO2(t-2)  NO2(t-1)    NO2(t)
date
2024-01-05  0.307350  0.307350  0.298695  0.290039  0.335483
2024-01-06  0.307350  0.298695  0.290039  0.335483  0.339013
...
2026-03-01  0.250355  0.248838  0.247320  0.334968  0.334968

[787 rows x 5 columns]  →  Shape: (787, 5)
```

**🖥️ Output (10 lag):**
```
Shape: (781, 11)
```

---

### 🏋️ d. Training & Evaluasi Model KNN

```python
from sklearn.neighbors import KNeighborsRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score
import numpy as np

def MAPE(y_true, y_pred):
    y_true, y_pred = np.array(y_true), np.array(y_pred)
    nonzero = y_true != 0
    return np.mean(np.abs((y_true[nonzero] - y_pred[nonzero]) / y_true[nonzero])) * 100

def train_knn(df_supervised, model_name=""):
    X = df_supervised.drop(columns=['NO2(t)']).values
    y = df_supervised['NO2(t)'].values

    # Split data 80/20
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, shuffle=False
    )

    knn = KNeighborsRegressor(n_neighbors=5)
    knn.fit(X_train, y_train)
    y_pred = knn.predict(X_test)

    rmse = np.sqrt(mean_squared_error(y_test, y_pred))
    r2   = r2_score(y_test, y_pred)
    mape = MAPE(y_test, y_pred)

    print(f"\n=== {model_name} ===")
    print(f"Train: {len(X_train)} | Test: {len(X_test)}")
    print(f"RMSE  : {rmse:.6f}")
    print(f"R²    : {r2:.4f}")
    print(f"MAPE  : {mape:.4f}%")

    return knn, y_test, y_pred

knn_4,  y_test_4,  y_pred_4  = train_knn(supervised_df4,  "KNN - 4 Hari Sebelumnya")
knn_10, y_test_10, y_pred_10 = train_knn(supervised_df10, "KNN - 10 Hari Sebelumnya")
knn_30, y_test_30, y_pred_30 = train_knn(supervised_df30, "KNN - 30 Hari Sebelumnya")
```

**🖥️ Output:**
```
=== KNN - 4 Hari Sebelumnya ===
Train: 629 | Test: 158
RMSE  : 0.117125
R²    : 0.7374
MAPE  : 17.1928%

=== KNN - 10 Hari Sebelumnya ===
Train: 624 | Test: 157
RMSE  : 0.125803
R²    : 0.6971
MAPE  : 20.3163%

=== KNN - 30 Hari Sebelumnya ===
Train: 608 | Test: 153
RMSE  : 0.157267
R²    : 0.4964
MAPE  : 24.3438%
```

**📊 Ringkasan Hasil Evaluasi:**

| 🤖 Model | 🏋️ Train | 🧪 Test | 📉 RMSE | 📈 R² | 🎯 MAPE |
|----------|----------|---------|---------|-------|---------|
| KNN 4 Hari  | 629 | 158 | 0.117125 | **0.7374** ⭐ | **17.19%** ⭐ |
| KNN 10 Hari | 624 | 157 | 0.125803 | 0.6971 | 20.32% |
| KNN 30 Hari | 608 | 153 | 0.157267 | 0.4964 | 24.34% |

> 🏆 **Model terbaik: KNN 4 Hari Sebelumnya**

---

### 📈 e. Plotting Hasil Prediksi

**4 Hari Sebelumnya:**

```python
import matplotlib.pyplot as plt
import numpy as np

plt.figure()
plt.plot(np.arange(len(y_test_4)), y_test_4, label="Actual")
plt.plot(np.arange(len(y_pred_4)), y_pred_4, label="Predicted")
plt.title("KNN Regression - 4 Hari Sebelumnya")
plt.xlabel("Sample Index")
plt.ylabel("NO2 Value")
plt.legend()
plt.show()
```

![image](https://www.image2url.com/r2/default/images/1780468766707-f04af9a4-29d8-420a-aee9-c8de4e8d61bf.png)

---

**10 Hari Sebelumnya:**

```python
plt.figure()
plt.plot(np.arange(len(y_test_10)), y_test_10, label="Actual")
plt.plot(np.arange(len(y_pred_10)), y_pred_10, label="Predicted")
plt.title("KNN Regression - 10 Hari Sebelumnya")
plt.xlabel("Sample Index")
plt.ylabel("NO2 Value")
plt.legend()
plt.show()
```

![image](https://www.image2url.com/r2/default/images/1780468879389-3f993f89-bdf0-4c02-a2f9-bdc17db0a16c.png)

---

**30 Hari Sebelumnya:**

```python
import matplotlib.pyplot as plt
import numpy as np


plt.figure(figsize=(15, 5))
plt.plot(np.arange(len(y_test_30)), y_test_30, label="Actual", linewidth=1.5)
plt.plot(np.arange(len(y_pred_30)), y_pred_30, label="Predicted", linewidth=1.5)
plt.title("KNN Regression - 30 Hari Sebelumnya")
plt.xlabel("Sample Index")
plt.ylabel("NO2 Value (Scaled)")
plt.legend()
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()
plt.show()
```

![image](https://www.image2url.com/r2/default/images/1780469683913-2336a13e-03a9-4c42-9146-9ebc1d827f3e.png)

---

## ✅ Kesimpulan

Hasil evaluasi model KNN Regression pada data NO₂ Bangkalan 2024–2026 menunjukkan bahwa:

1. 🏆 **Model 4 hari sebelumnya** memberikan performa **terbaik** dengan RMSE terkecil (0.117125), R² tertinggi (0.7374), dan MAPE terendah (17.19%). Model ini mampu menjelaskan sekitar **73.74%** variabilitas data target.

2. 📉 **Penambahan fitur lag tidak selalu meningkatkan performa.** Ketika jumlah lag ditambah menjadi 10 dan 30 hari, performa model justru menurun — RMSE dan MAPE meningkat, sedangkan R² turun menjadi 0.4964 pada lag 30. Ini disebabkan oleh **curse of dimensionality** pada KNN.

3. 📊 **Hasil data 2024–2026 jauh lebih baik** dibanding referensi (2023–2025) yang hanya memiliki R² ~0.14 dan MAPE >60%. Ini karena proses preprocessing yang lebih lengkap (outlier removal IQR + interpolasi).

4. 🔬 **Uji korelasi** menunjukkan 8 lag (t-1 s/d t-8) memiliki korelasi >0.5, lebih banyak dari referensi yang hanya 4 lag. Ini mengindikasikan pola NO₂ yang lebih konsisten di periode 2024–2026.

5. 🚀 Meski KNN dengan 4 lag sudah cukup baik (R²=0.73), untuk akurasi lebih tinggi dapat dicoba model lain seperti **LSTM**, **Random Forest**, atau **XGBoost**.

---

> 🛰️ *Data bersumber dari Sentinel-5P (TROPOMI) via Copernicus Data Space Ecosystem*
> 📍 *Wilayah: Kabupaten Bangkalan, Madura — Periode: 2024-01-01 s/d 2026-03-01*