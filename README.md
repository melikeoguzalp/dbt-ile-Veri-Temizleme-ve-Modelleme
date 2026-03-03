#  Chaos Warehouse
### dbt ile Veri Temizleme ve Modelleme

![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

---

##  Proje Hakkında

Bu proje, **PostgreSQL** üzerinde bulunan ham (raw) verileri temizleyip, analiz için hazırlanmış bir **veri ambarı (data warehouse)** haline getirmeyi amaçlamaktadır. Projede kullanılan ana araç **dbt (data build tool)**, SQL tabanlı veri dönüşümlerini yönetmeyi kolaylaştırır ve veri pipeline'larının düzenli, testli ve görselleştirilebilir olmasını sağlar.

Proje **üç ana katmandan** oluşur:

| Katman | Açıklama |
|--------|----------|
|  **Staging (stg)** | Ham verilerin temizlenmiş ve normalize edilmiş hâli |
|  **Gold** | Staging tablolarından oluşturulan, analize hazır tablolar |
|  **Testler** | Veri kalitesi için `not_null` ve `unique` testleri |

---

##  dbt Nedir ve Neden Kullanıyoruz?

**dbt (data build tool)**, veri mühendislerinin SQL ile veri dönüşümleri yaparken tekrar kullanılabilir, testli ve takip edilebilir modeller oluşturmasını sağlayan modern bir araçtır.

###  dbt Kullanmanın Avantajları

-  **Dependency Yönetimi**  `ref()` fonksiyonu ile tabloların birbirine bağımlılıklarını otomatik yönetir.
-  **Testler ve Veri Kalitesi**  Her sütun için `null` veya `unique` testleri ekleyerek veri kalitesini garanti altına alır.
-  **DAG Görselleştirmesi**  `dbt docs serve` ile modellerin birbirine nasıl bağlı olduğunu grafik olarak görebilirsin.
-  **Versiyon Kontrol Uyumlu**  Proje tüm SQL dosyalarıyla GitHub'a konulabilir, herkes değişiklikleri takip edebilir.
-  **ELT Odaklı**  dbt veriyi taşıdıktan sonra (Load) temizler ve dönüştürür (Transform); ETL'ye göre daha modern bir yaklaşım.

---

##  Proje Yapısı

```
chaos_warehouse/
 data/                   #  Ham CSV veriler
    customers.csv
    orders.csv
    payments.csv
 models/
    staging/            #  Staging tablolar ve testler
    gold/               #  Analitik tablolar ve testler
 dbt_project.yml         #   dbt proje yapılandırması
 README.md               #  Bu dosya
 requirements.txt        #  Python paketleri (dbt vs.)
 profiles.yml            #  dbt PostgreSQL bağlantısı
```

---

##  Başlangıç (Setup)

**1.** PostgreSQL çalıştırın (Docker veya lokal):

```bash
docker-compose up -d
```

**2.** Bu proje klasörünü indirin veya clone edin.

**3.** Python ortamında gerekli paketleri yükleyin:

```bash
pip install -r requirements.txt
```

**4.** dbt profilini ayarlayın (`profiles.yml`) ve PostgreSQL'e bağlanın.

**5.** Verileri yükleyin ve modelleri çalıştırın:

```bash
dbt seed    # CSV verilerini yükle
dbt run     # Modelleri çalıştır
dbt test    # Testleri çalıştır
```

**6.** DAG'i tarayıcıda görüntüleyin:

```bash
dbt docs generate
dbt docs serve
```

---

##  Kullanım Senaryosu

```
 data/     staging     gold     Analiz / Dashboard
```

1. Ham veriler (`customers`, `orders`, `payments`) `data/` klasöründe bulunur.
2. **dbt staging** tabloları verileri temizler ve normalize eder.
3. **Gold** tabloları, staging tablolarından analize hazır veri üretir.
4. **Testler** sayesinde `null` veya `duplicate` veri hataları erken tespit edilir.

---

##  Sonuç

Bu proje, **dbt kullanmanın faydalarını** net bir şekilde göstermeyi amaçlamaktadır:

-  Tabloların birbirine bağımlılığını otomatik yönetir.
-  Veri kalitesi testlerini standartlaştırır.
-  Analiz ve dashboard katmanları için **temiz ve güvenilir veri** sağlar.
