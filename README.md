<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0A84FF,50:5E5CE6,100:30D158&height=280&section=header&text=LUMEN&fontSize=100&fontColor=ffffff&fontAlignY=42&desc=Professional%20Docker%20Infrastructure%20Monitor%20for%20iOS&descAlignY=62&descSize=20&descColor=ffffffcc&animation=fadeIn" width="100%"/>

<br/>

[![Swift](https://img.shields.io/badge/Swift-5.9-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-17.0+-000000?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-0071e3?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/swiftui/)
[![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![WebSocket](https://img.shields.io/badge/WebSocket-Live_Streams-00C853?style=for-the-badge&logo=socketdotio&logoColor=white)]()
[![Docker](https://img.shields.io/badge/Docker-Monitor-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![Xcode](https://img.shields.io/badge/Xcode-15.0+-147EFB?style=for-the-badge&logo=xcode&logoColor=white)]()
[![License](https://img.shields.io/badge/License-MIT-a855f7?style=for-the-badge)]()

<br/>

> ### 🌟 *"Cibinizdəki data center"*
> **Lumen** — DevOps mühəndisləri üçün yaradılmış, real-time WebSocket axınları,  
> interaktiv chartlar və ağıllı health scoring ilə tam silahlanmış natif iOS tətbiqi.

<br/>

</div>

---

<br/>

## 🧭 Mündəricat

| 🔗 Bölmə | 🔗 Bölmə |
|---|---|
| [🌟 Lumen haqqında](#-lumen-haqqında) | [✨ Xüsusiyyətlər](#-xüsusiyyətlər) |
| [🏗️ Arxitektura](#️-arxitektura) | [⚡ Dashboard & Health Score](#-dashboard--health-score) |
| [🐳 Container Sistemi](#-container-sistemi) | [🚨 Alert Sistemi](#-alert-sistemi) |
| [📜 Live Logs](#-live-logs) | [⚙️ Settings](#️-settings) |
| [🔌 Network Layer](#-network-layer) | [🧪 Mock Backend](#-mock-backend) |
| [🎨 Design System](#-design-system) | [📁 Layihə Strukturu](#-layihə-strukturu) |
| [🚀 Quraşdırma](#-quraşdırma) | [🛠️ Tech Stack](#️-tech-stack) |

<br/>

---

<br/>

## 🌟 Lumen haqqında

**Lumen** — iOS üçün sıfırdan yazılmış tam professional Docker monitoring tətbiqidir. Tətbiq, DevOps mühəndislərinin, SRE-lərin və sistem administratorlarının gün ərzində ən çox ehtiyac duyduğu şeyləri — konteyner vəziyyəti, resurs istifadəsi, xəbərdarlıqlar və loglar — bir yerdə, real vaxtda, cibindəki iPhone-dan əlçatan edir.

Lumen sadəcə bir dashboard tətbiqi deyil. Hər konteyner üçün ayrı-ayrı WebSocket axınları açır, sinusoid dalğa + spike simulasiyası ilə realistik mock mühit yaradır, hysteresis-based health scoring ilə infrastructure-un sağlamlığını saniyə-saniyə izləyir və bütün bunları tamamilə natif SwiftUI ilə, üçüncü tərəf UI kitabxanası olmadan həyata keçirir.

<br/>

<div align="center">

| 👩‍💻 Developer | 📅 Başlama | 🏙️ Yer | 🎯 Platform | 🔐 Auth |
|:---:|:---:|:---:|:---:|:---:|
| Sabina Karimli | Fevral 2026 | Bakı 🇦🇿 | iPhone iOS 17+ | Firebase |

</div>

<br/>

---

<br/>

## ✨ Xüsusiyyətlər

<br/>

### 🖥️ Dashboard — Real-time İnfrastruktur Mərkəzi

Dashboard, tətbiqin ürəyidir. Açıldığı anda bütün Docker infrastrukturunun sağlamlıq vəziyyətini bir baxışda görürsünüz. Üstdə böyük, animasiyalı **Health Score Ring** — 0-dan 100-ə qədər rəng dəyişdirir, hysteresis və exponential smoothing sayəsində ani titrəmə olmadan hamar keçid edir. Yanında 4 iri metrik kart: ümumi CPU faizi, istifadə olunan Memory (MB), işləyən konteyner sayı, kritik vəziyyətdəki konteyner sayı.

Aşağıda **interaktiv multi-line chartlar** — CPU Contribution, CPU Trend, Memory Trend — 3 tab arasında keçid edərək infrastrukturun son 1.5 dəqiqəlik tarixini görürsünüz. Hər nöqtəyə toxunduqda tooltip açılır, dəqiq dəyəri göstərir. Daha aşağıda **Top Contributors** — ən çox CPU və RAM istifadə edən konteynerların sıralı siyahısı. Ən sonda isə **son 5 kritik xəbərdarlıq** — birbaşa Dashboard-dan Alerts-ə keçmədən oxuya bilərsiniz.

<br/>

### 🐳 Containers — Canlı Metrik Kartlar

Containers tab-ı açıldığında bütün Docker konteynerləri kart formasında sıralanır. Hər kartın içində **real-time metric strip** var — hər saniyə WebSocket-dən gələn data ilə avtomatik yenilənir. Sol tərəfdə konteynerin adı, image-i, rəngli ikon. Sağda CPU progress bar (faizlə, rəngli), Memory progress bar, şəbəkə trafiği (download ↓ upload ↑ bytes). Karta tıklayanda **Detail View** açılır: environment variables, port mapping, mounted volumes, actions panel.

**Actions Panel**-də Start, Stop, Restart, Remove düymələri var. `lumen-app` kimi sistem-kritik konteynerlar üçün destructive actions avtomatik olaraq deaktiv edilir — təsadüfən silinmə riski sıfır. **Pull-to-refresh** ilə yuxarı sürüşdürdükdə tam reset baş verir. Tabs: Containers / Images / Volumes / Networks — hamısı bir yerdə.

<br/>

### 🚨 Alerts — Ağıllı Xəbərdarlıq Mərkəzi

Alert sistemi CPU və Memory threshold-larına əsaslanır. Kritik alertlər qırmızı glow ilə, high alertlər narıncı, medium isə sarı ilə göstərilir. Hər alert kartı — **ProAlertRow** — glassmorphism dizayn ilə hazırlanmışdır: şüşə effektli arxa fon, severity rənginə uyğun sol border, konteyner ikonu, CPU/Memory metric pill-ləri, relative timestamp ("2 dəq əvvəl").

Hər 4 saniyədə bir avtomatik yenilənir. Severity filter ilə yalnız Critical, yalnız High və ya hamısını görə bilərsiniz. Axtarış paneli ilə konteyner adına görə filtirləyə bilərsiniz. "Clear All" düyməsi bütün alert tarixini siləcəyini soruşur — confirmation dialog-dan sonra təmizlənir.

<br/>

### 📜 Logs — Terminal-Style Canlı Axın

Logs tab-ı, birbaşa serverkə qoşulmuş terminal kimidir. Konteyner seçicidən istədiyiniz konteyneri seçirsiniz, WebSocket bağlantısı qurulur və loglar axmağa başlayır. Hər log sətri: sola sıra nömrəsi, nanosaniyə dəqiqliyində timestamp, log level badge (DEBUG / INFO / WARN / ERROR), rəngli mətn. Yeni log gəldikdə həmin sətir qısa müddət parlayır — **LogFlashOverlay** effekti. Sol tərəfdə yanıb-sönən terminal kursoru (BlinkingCursor) aktivliyi göstərir.

Log level filter ilə yalnız ERROR-ları görə, yalnız WARN-ları izləyə bilərsiniz. Buffer 1500 sətirdə tutulur — performans itkisi olmadan saatlarla izləyə bilərsiniz. 6 reconnect cəhdindən sonra istifadəçiyə bildiriş göstərilir.

<br/>

### ⚙️ Settings — Tam Fərdiləşdirmə

Settings ekranı bir neçə kart-bölməyə ayrılmışdır. **Server Card** — host URL-i daxil edib bağlantı testi edirsiniz, animasiyalı FlowConnectorView bağlantı axını vizual olaraq göstərir. **CPU Threshold Slider** — 1%-dən 99%-ə qədər sürüşdürün, Alert sistemi dərhal yeni threshold ilə işləməyə başlayır, UserDefaults-a avtomatik saxlanır. **Notifications Card** — bildirişləri açıb-bağlayırsınız. **Alert Email Card** — Firebase-dəki verified email-i göstərir. **Sign Out** — hesabdan çıxış.

<br/>

---

<br/>

## 🏗️ Arxitektura

Lumen, **MVVM + Coordinator** pattern üzərindədir. UIKit navigation qatı, üzərindəki SwiftUI view-ları UIHostingController vasitəsilə embed edir. Bu hibrid yanaşma həm SwiftUI-nin deklarativ gücündən, həm də UIKit-in navigation etibarlılığından istifadə etməyə imkan verir.

<br/>

<div align="center">

```
                    ┌─────────────────────────────┐
                    │   MainTabBarController       │
                    │        (UIKit)               │
                    └──────────┬──────────────────┘
                               │ UIHostingController
          ┌────────────────────┼────────────────────┐
          │                    │                    │
    Dashboard            Containers             Alerts / Logs / Settings
    ViewModel            ViewModel              ViewModel × 3
          │                    │
    DashboardCoordinator  WebSocket Streams × N
    ├── snapshotTimer (4s)      │
    ├── alertTimer (20s)   latestStats[id]
    ├── containerTimer(15s)     │
    └── recalcTimer (2s)   ContainerCard × N
                               │
                    ┌──────────▼──────────┐
                    │    Service Layer     │
                    │  LumenService ───── RealLumenService (REST)
                    │                └─── MockLumenService (mock)
                    │  StatsStreaming ─── RealStatsHub (WebSocket)
                    │                └─── MockStatsHub (sin-wave)
                    └─────────────────────┘
```

</div>

<br/>

### 🧩 Əsas Arxitektura Qərarları

| 🔑 Pattern | 📍 İstifadə Yeri | 💡 Niyə? |
|---|---|---|
| `@MainActor` | Bütün ViewModels | Thread-safe UI yeniləmələri |
| `AsyncThrowingStream` | Stats streaming | Swift structured concurrency |
| `didLoadOnce` flag | AlertVM, DetailVM | Tab keçidlərində double request yoxdur |
| `didStartOnce` flag | DashboardVM | Tab-switch-də double-start yoxdur |
| Hysteresis thresholds | HealthScoreCalculator | Score titrəməsi (flutter) aradan qalxır |
| Exponential smoothing | DashboardVM | Hamar, animasiyalı health score keçidi |
| Protocol-based services | LumenService, StatsStreaming | Mock ↔ Real asanca dəyişir |
| Coordinator pattern | DashboardCoordinator | Timer + stream lifecycle bir yerdə |
| Stream persistence | ContainersViewModel | Navigation-da stats itirilmir |
| Optimistic UI update | Container actions | İstifadəçi dərhal cavab hiss edir |

<br/>

---

<br/>

## ⚡ Dashboard & Health Score

Dashboard-un ən mürəkkəb hissəsi Health Score sistemidir. Sadə bir faiz deyil — üç ayrı texnika birgə işləyir və real infrastruktur davranışını əks etdirir.

<br/>

### 🏥 Penalty-Based Scoring

Hər 2 saniyədə bir bütün aktiv konteynerlərin məlumatları toplanır. Ən yüksək CPU istifadə edən konteyner penalty hesablamasına əsas olur (ortalama deyil, maksimum — çünki bir konteyner sistemi çökdürə bilər). 100 başlangıc balından aşağıdakı penaltilər çıxılır:

<br/>

<div align="center">

| 🚦 Vəziyyət | ⬇️ Base Penalti | ➕ Extra | 🔝 Maks |
|:---|:---:|:---:|:---:|
| 🔴 CPU ≥ 20% — Critical | −15 | Hər əlavə 5% üçün −1 | −40 |
| 🟠 CPU ≥ 12% — High | −10 | Hər əlavə 6% üçün −1 | −20 |
| 🟡 CPU orta > 5% | −5 | — | — |
| 🔵 CPU orta > 1% | −2 | — | — |
| 🔴 Memory ≥ 80% | −10 (mütənasib) | — | −20 |
| 🟠 Memory ≥ 60% | −5 (mütənasib) | — | −12 |
| 🚨 Hər kritik alert | −5 | — | −20 |
| ⛔ Hər dayanmış kont. | −3 | — | −12 |

</div>

<br/>

### 🔀 Hysteresis — Titrəmənin Qarşısı

Threshold-ların üstündə-altında oynayan bir konteyner olduqda score saniyədə dəfələrlə dəyişərdi — bu çox rahatsızedici görünür. Hysteresis ilə bu problem həll edilib: **girmə** threshold-u çıxma threshold-undan yüksəkdir.

<br/>

<div align="center">

| 📊 Metrik | 🔴 Enter (kritik başlayır) | 🟢 Exit (normal qayıdır) | 🛡️ Qorunan zona |
|:---|:---:|:---:|:---:|
| CPU Critical | ≥ 20% | < 15% | 15% – 20% |
| CPU High | ≥ 12% | < 8% | 8% – 12% |
| Memory Critical | ≥ 80% | < 70% | 70% – 80% |
| Memory High | ≥ 60% | < 50% | 50% – 60% |

</div>

<br/>

### 📈 Exponential Smoothing — Hamar Keçid

Hədəf score dərhal göstərilmir. Əvvəlki dəyər 70%, yeni hədəf isə 30% çəki daşıyır (α = 0.3). Bu sayədə 75-dən 40-a keçid bir saniyəlik sıçrayış deyil, vizual olaraq hamar bir eniş olur. HealthScoreRing animasiyası da bununla sinxronlaşır.

<br/>

### 🎨 Health Status Rəng Sistemi

<div align="center">

| 💯 Score Aralığı | 🏷️ Status | 🎨 Rəng | 💬 Mənası |
|:---:|:---:|:---:|:---|
| 70 – 100 | ✅ Healthy | 🟢 Yaşıl | Sistem sabit, kritik problem yoxdur |
| 40 – 69 | ⚠️ Warning | 🟡 Sarı | Diqqət tələb edən vəziyyətlər var |
| 0 – 39 | 🚨 Critical | 🔴 Qırmızı | Dərhal müdaxilə lazımdır |

</div>

<br/>

### ⏱️ Dashboard Timer Orkestrası

Dashboard fonda 4 ayrı timer işlədir. Bunların hamısı `DashboardCoordinator` tərəfindən idarə edilir:

<br/>

<div align="center">

| ⏰ Timer | 🔄 Interval | 📋 Vəzifə | 🎯 Nəticə |
|:---|:---:|:---|:---|
| 📸 snapshotTimer | 4 saniyə | `globalHistory`-ə yeni nöqtə əlavə edir | Chart-lar canlı yenilənir |
| 🚨 alertTimer | 20 saniyə | Son alertləri API-dən çəkir | Dashboard alert paneli yenilənir |
| 🐳 containerTimer | 15 saniyə | Yeni konteynerləri kəşf edir | Yeni axınlar açılır |
| 🔢 recalcTimer | 2 saniyə | Aggregates + health score hesablayır | Ring + metrik kartlar yenilənir |

</div>

<br/>

### 📊 Chart Sistemi

Dashboard-da 3 interaktiv chart tab-ı mövcuddur. Hər biri son ~1.5 dəqiqənin məlumatlarını göstərir. Konteyner başına 40 nöqtəlik rolling buffer saxlanır, hər 2.5 saniyədə bir yeni nöqtə əlavə edilir, köhnəsi çıxarılır.

<br/>

<div align="center">

| 📈 Tab | 📊 Chart tipi | 📋 Göstərdiyi |
|:---|:---:|:---|
| 🖥️ CPU Contribution | Multi-series | Hər konteynerin CPU töhfəsi ayrıca |
| 📉 CPU Trend | Line chart | Ümumi infrastruktur CPU trendi |
| 💾 Memory Trend | Line chart | Ümumi infrastruktur Memory trendi |

</div>

<br/>

---

<br/>

## 🐳 Container Sistemi

### 🔄 Stream Lifecycle — Ən Kritik Qərar

Container sistemininin ən mühüm arxitektura qərarı — WebSocket stream-lərin navigasiya boyunca canlı qalmasıdır. Bu qərara gəlməzdən əvvəl hər `onDisappear`-də bütün stream-lər öldürülürdü. Detail view-dan geri qayıdanda kartlar 1–2 saniyə "Connecting..." göstərirdi — çox pis UX. İndi isə:

<br/>

<div align="center">

| 📍 Hadisə | 📥 loadTask | 📡 streamTasks | 💡 Nəticə |
|:---|:---:|:---:|:---|
| 🟢 `onAppear()` | 🔄 Yenilənir | ✅ Toxunulmur | Geri qayıdanda kartlar anında CPU göstərir |
| 🔴 `onDisappear()` | ❌ Cancel | ✅ Canlı qalır | Detail açılsa da stream-lər ölmür |
| 🔁 `refresh()` | 🔄 Yenilənir | 🔄 Tam reset | Pull-to-refresh hər şeyi yenidən yükləyir |
| ⏱️ `containerTimer` | — | 🔄 Reconcile | Yeni kont. stream açır, yox olanı bağlayır |

</div>

<br/>

### ⚡ Container Actions

Bütün konteyner əməliyyatları **optimistic update** ilə işləyir — server cavabını gözləmədən UI dərhal yenilənir. İstifadəçi 0 gecikmə hiss edir.

<br/>

<div align="center">

| 🎮 Action | ⚡ Optimistic Update | 🔒 lumen-app | 📋 Əlavə |
|:---|:---:|:---:|:---|
| ▶️ Start | Dərhal "running" 🟢 | ✅ Mümkün | — |
| ⏹️ Stop | Dərhal "exited" ⚫ | 🔒 Bloklu | Critical banner göstərilir |
| 🔄 Restart | Dərhal "running" 🟢 | 🔒 Bloklu | Critical banner göstərilir |
| 🗑️ Remove | Confirmation dialog | 🔒 Bloklu | Silinmə geri alınamaz |

</div>

<br/>

### 🃏 ContainerCard Anatomy

Hər kart aşağıdakı vizual komponentlərdən ibarətdir:

<br/>

<div align="center">

| 🧩 Komponent | 📋 Vəzifəsi |
|:---|:---|
| 🎨 `ContainerCardBackground` | Glassmorphism arxa fon, severity glow |
| 🖼️ `ContainerCardAvatar` | Konteyner tipi ikonu (rəngli) |
| 📛 `ContainerCardNameBlock` | Ad + image tag |
| 🔴 `ContainerStateBadge` | running / exited / paused badge |
| 📊 `ContainerCardMetricStrip` | CPU% + MEM% progress barlar |
| 🌐 `ContainerCardNetworkCell` | Download ↓ / Upload ↑ bytes |
| 💀 `ContainerCardSkeleton` | Loading vəziyyəti animasiyası |

</div>

<br/>

---

<br/>

## 🚨 Alert Sistemi

### 🎯 Severity Threshold-ları

Alert sistemi `AlertSeverityHelper` vasitəsilə mərkəzləşdirilmiş threshold-larla işləyir. Settings-dən CPU threshold dəyişdirildikdə bütün sistem dərhal yeni dəyərlə işləməyə başlayır.

<br/>

<div align="center">

| 🚦 Severity | 🖥️ CPU Threshold | 💾 Memory Threshold | 🎨 Rəng |
|:---|:---:|:---:|:---:|
| 🔴 Critical | ≥ 20% | ≥ 80% | Qırmızı glow |
| 🟠 High | ≥ 12% | ≥ 60% | Narıncı glow |
| 🟡 Medium | < 12% | < 60% | Sarı glow |

</div>

<br/>

### 🃏 ProAlertRow — Alert Kart Anatomiyası

Hər alert kartı 8 ayrı subcomponent-dən ibarətdir. Bu komponent-ağacı kartın hər hissəsini izolə edir, yenidən istifadəni asanlaşdırır:

<br/>

<div align="center">

| 🧩 Komponent | 📋 Vəzifəsi |
|:---|:---|
| 🫧 `ProAlertRowCardBackground` | Glassmorphism kart fonu |
| ✨ `ProAlertRowGlow` | Severity rənginə uyğun parlama effekti |
| 📏 `ProAlertRowLeftBar` | Sol tərəf rəngli sərhəd xətti |
| 🖼️ `ProAlertRowIcon` | Konteyner tipi ikonu |
| 📛 `ProAlertRowHeader` | Konteyner adı + SeverityPill badge |
| 💬 `ProAlertRowMessage` | Xəbərdarlıq mətni |
| 💊 `ProAlertRowMetricPill` | CPU% + MEM% dəyərləri |
| 🕐 `ProAlertRowTime` | "2 dəq əvvəl" formatında vaxt |

</div>

<br/>

---

<br/>

## 📜 Live Logs

### 🖥️ Terminal Komponentləri

Logs ekranı, real bir terminal-ın görünüşünü tam olaraq təkrarlayır. Hər vizual element ayrıca komponent kimi yazılmışdır:

<br/>

<div align="center">

| 🧩 Komponent | 📋 Vəzifəsi |
|:---|:---|
| ⌨️ `BlinkingCursor` | Sol üstdə yanıb-sönən terminal kursoru |
| 🔢 `TerminalLineNumber` | Sıra nömrəsi (solda sabit) |
| 🕐 `TerminalTimestamp` | Nanosaniyə dəqiqliyində tarix/saat |
| 🏷️ `LogLevelBadge` | DEBUG / INFO / WARN / ERROR badge |
| 📝 `TerminalMessageText` | Log səviyyəsinə görə rəngli mətn |
| ✨ `LogFlashOverlay` | Yeni log sətri üçün qısa parıltı animasiyası |
| ➖ `TerminalSeparator` | Sətirlərarası incə xətt |
| 📊 `LineCountPill` | Cari buffer-dəki log sayı |
| 🟢 `StreamStatusBadge` | Bağlı / Bağlanır / Xəta badge-i |

</div>

<br/>

### 📊 Stream Parametrləri

<div align="center">

| ⚙️ Parametr | 📊 Dəyər | 💡 Səbəb |
|:---|:---:|:---|
| 🗂️ Max buffer | 1500 sətir | Performans + RAM balansı |
| 🔁 Max reconnect | 6 cəhd | Sonsuz döngünün qarşısı |
| ⏱️ Retry strategiyası | Exponential backoff | Serveri yükləməmək üçün |
| 🕐 Timestamp dəqiqliyi | Nanosaniyə (9 rəqəm) | Docker log formatına tam uyğun |
| 💡 Re-flash | Scroll-da yoxdur | Köhnə loglar yenidən yanmır |

</div>

<br/>

### 🔵 Log Level Sistemi

<div align="center">

| 🏷️ Səviyyə | 🎨 Rəng | 📋 İstifadə |
|:---:|:---:|:---|
| 🔵 DEBUG | Mavi | Development, izləmə məlumatları |
| ⚪ INFO | Ağ | Normal əməliyyat hadisələri |
| 🟡 WARN | Sarı | Diqqət tələb edən vəziyyətlər |
| 🔴 ERROR | Qırmızı | Xətalar, uğursuz əməliyyatlar |

</div>

<br/>

---

<br/>

## ⚙️ Settings

### 🎚️ CPU Threshold Slider

Settings-in ən güclü xüsusiyyəti — CPU threshold slider. 1%-dən 99%-ə qədər sürüşdürdükdə əvvəlcə UserDefaults-a avtomatik saxlanır, sonra `AlertSeverityHelper`-in qlobal threshold dəyəri dərhal yenilənir. Yəni siz slider-i hərəkət etdirərkən tətbiqin alert sistemi real vaxtda yeni dəyərlə işləməyə başlayır — restart lazım deyil, heç bir əlavə addım lazım deyil.

<br/>

### 🖥️ Server Konfiqurasiyası

ServerSetupSheet-i açıb host URL daxil etdikdə animasiyalı **FlowConnectorView** bağlantı axını vizual olaraq göstərir — sanki bir node-dan digərinə data axır. **ConnectionStatusCapsule** bağlantının uğurlu olub-olmadığını rəngli badge ilə anında bildirir. **PrettyHostFormatter** daxil etdiyiniz URL-i oxunaqlı formata çevirir.

<br/>

### 🔔 Bildiriş Tənzimləmələri

Notifications toggle, **AlertFlowCardView**-da CPU threshold slider ilə birlikdə yerləşir. Bu iki ayar bir arada olduğundan istifadəçi hansı threshold-da necə xəbərdarlıq alacağını eyni anda görə bilir. AlertEmailCardView isə Firebase-dəki verified email-i göstərir — alertlərin hara göndərildiyini təsdiqləyir.

<br/>

### 💾 Auto-Save Mexanizmi

Settings-də hər dəyişiklik 800ms debounce ilə avtomatik saxlanır. İstifadəçi slider-i sürüşdürdükcə hər mövqedə save edilmir — yalnız 800ms hərəkətsizlikdən sonra. Bu həm batareya, həm də I/O performansı baxımından optimal yanaşmadır. `deinit`-də `autoSaveTask` cancel edilir — memory leak yoxdur.

<br/>

---

<br/>

## 🔌 Network Layer

### 🌐 REST API Endpoint-ləri

<div align="center">

| 🔧 Method | 🔗 Endpoint | 📋 Təsvir |
|:---:|:---|:---|
| 🟢 `GET` | `/containers` | Bütün konteynerlərin tam siyahısı |
| 🟢 `GET` | `/containers/:id` | Tək konteyner detalları (env, ports, mounts) |
| 🟡 `POST` | `/containers/:id/start` | Konteyneri işə salır |
| 🟡 `POST` | `/containers/:id/stop` | Konteyneri dayandırır |
| 🟡 `POST` | `/containers/:id/restart` | Konteyneri yenidən başladır |
| 🔴 `DELETE` | `/containers/:id` | Konteyneri tamamilə silir |
| 🟢 `GET` | `/images` | Bütün Docker image-lər |
| 🟢 `GET` | `/volumes` | Bütün Docker volume-lar |
| 🟢 `GET` | `/networks` | Bütün Docker network-lər |
| 🟢 `GET` | `/alerts` | Bütün xəbərdarlıq tarixi |
| 🔴 `DELETE` | `/alerts` | Bütün xəbərdarlıqları silir |

</div>

<br/>

### 📡 WebSocket Stats — Gələn Sahələr

`ws://{host}/stats?containerId={id}` endpoint-indən hər ~1 saniyədə bir JSON gəlir:

<br/>

<div align="center">

| 📦 Sahə | 🔢 Tip | 📋 Məna | ⚠️ Qeyd |
|:---|:---:|:---|:---|
| `cpuUsage` | Double | CPU faizi | **22.58 = 22.58%** — fraction deyil! |
| `memoryUsage` | Int | İstifadə olunan RAM | Bytes formatında |
| `memoryLimit` | Int | Maksimum RAM | Bytes (≈ 3917 MB) |
| `memoryPercent` | Double | Memory faizi | 0.0 – 100.0 aralığı |
| `networkRx` | Int | Alınan məlumat | Bytes |
| `networkTx` | Int | Göndərilən məlumat | Bytes |

</div>

<br/>

> ⚠️ **Mühüm Qeyd:** `cpuUsage` həmişə faiz formatındadır. `normalizeToPercent()` funksiyası yalnız `clamp(0, 100)` əməliyyatı edir — heç bir çarpma yoxdur. Bunu `×100` etmək `22.58%`-i `2258%`-ə çevirərdi.

<br/>

### 🔌 WebSocket Stack Komponentləri

<div align="center">

| 🧩 Komponent | 📋 Vəzifəsi |
|:---|:---|
| 🔗 `DefaultWebSocketClient` | `URLSessionWebSocketTask` üzərindəki native wrapper |
| 🔁 `WebSocketBackoff` | Exponential retry: 1s → 2s → 4s → 8s → max 30s |
| 💾 `StatsCache` | Son gələn stats-ı `CachedStatsEnvelope`-da saxlayır |
| 🕐 `DateParser` | Docker-in nanosaniyə timestamp-ini parse edir |
| 📡 `StatsStreamViewModel` | 350ms başlama gecikmə (detail animation tamamlansın) |
| 🗺️ `WSRoute` | WebSocket URL-lərini mərkəzləşdirir |
| 📊 `WebSocketState` | connecting / connected / disconnected / error |

</div>

<br/>

---

<br/>

## 🧪 Mock Backend

`DEBUG` build-da şəbəkəsiz tam simulasiya mühiti. Server olmadan simulator-da birbaşa işlədilir. Hər şey real backend formatına tam uyğundur.

<br/>

### 🌊 Sin-Wave + Spike Engine

MockStatsHub hər konteyner üçün unikal profil daşıyır. CPU dəyəri sinusoid dalğa ilə dəyişir, üstünə random noise əlavə olunur, müəyyən ehtimalla spike baş verir:

**CPU = baseCPU + amplitude × sin(phase) + noise + (spike varsa: baseCPU × spikeMult)**

Bu formulanın nəticəsi `clamp(0.1, 99.9)` aralığında tutulur — real backend formatına tam uyğun faiz dəyəri.

<br/>

### 🐳 18 Konteyner Profili

<div align="center">

| 🐳 Konteyner | 📊 Normal CPU | ⚡ Spike CPU | 🎲 Spike ehtimalı | 🚦 Severity |
|:---|:---:|:---:|:---:|:---:|
| `log-cpu-heavy` | 18 – 26% | — | 0% | 🔴 Həmişə Critical |
| `lumen-app` | ~3% | ~21% | 5% / saniyə | 🔴 Spike-da Critical |
| `lumen-postgres` | ~5.5% | ~14% | 5% / saniyə | 🟠 Spike-da High |
| `log-mongodb` | ~2.2% | ~13% | 6% / saniyə | 🟠 Spike-da High |
| `log-analytics` | ~2.5% | ~13% | 6% / saniyə | 🟠 Spike-da High |
| `log-search-service` | ~2% | ~13% | 6% / saniyə | 🟠 Spike-da High |
| `lumen-minio` | ~5% | — | 0% | 🟢 Normal |
| `log-redis-cache` | ~2.2% | — | 0% | 🟢 Normal |
| `log-nginx-web` | ~1.8% | — | 0% | 🟢 Normal |
| `log-auth-service` | ~2% | — | 0% | 🟢 Normal |
| `log-notification-service` | ~1.8% | — | 0% | 🟢 Normal |
| `log-worker-jobs` | ~2.2% | — | 0% | 🟢 Normal |
| `log-queue-processor` | ~2% | — | 0% | 🟢 Normal |
| `log-api-gateway` | ~2.5% | — | 0% | 🟢 Normal |
| `log-payment-service` | ~2% | — | 0% | 🟢 Normal |
| `log-cleaner` | ~1.6% | ~6.4% | 5% / saniyə | 🟢 Spike kiçikdir |
| `log-memory-heavy` | ~2.8% | ~8.4% | 3% / saniyə | 🟢 Memory yüksəkdir |
| `lumen-caddy` | ~1.5% | — | 0% | 🟢 Normal |

</div>

<br/>

### 🎭 Normal Vəziyyətdə Health Score Simulasiyası

Mock mühitdə 18 konteyner işləyir. `log-cpu-heavy` həmişə 22% CPU göstərir — bu `cpuCritical` penalty (−15) yaradır. 2 kritik alert var — `alertPenalty` (−10). Digər konteynerlar 1.6–5.5% CPU aralığında — yalnız `cpuLow` (−2). Nəticə: target ≈ **73** → 🟢 **Healthy**.

<br/>

---

<br/>

## 🎨 Design System

Bütün vizual sabitlər `DS` namespace altında mərkəzləşdirilmişdir. Heç bir magic number yoxdur — hər padding, hər radius, hər animasiya müddəti bir yerdən idarə olunur.

<br/>

<div align="center">

<table>
<tr>
<td width="50%" valign="top">

**🎨 Rənglər**

| Token | Məna |
|---|---|
| `DS.Color.accent` | Əsas mavi |
| `DS.Color.danger` | Kritik qırmızı |
| `DS.Color.warning` | Amber/narıncı |
| `DS.Color.success` | Yaşıl |
| `DS.Color.bg0 – bg4` | Fon ierarxiyası (5 qat) |
| `DS.Color.textPrimary` | Əsas mətn |
| `DS.Color.textSecondary` | İkincil mətn |
| `DS.Color.textMuted` | Solğun mətn |

</td>
<td width="50%" valign="top">

**⚙️ Layout & Animasiya**

| Token | Dəyər |
|---|---|
| `DS.Space.xs` | 4 pt |
| `DS.Space.sm` | 8 pt |
| `DS.Space.md` | 12 pt |
| `DS.Space.lg` | 16 pt |
| `DS.Space.xl` | 24 pt |
| `DS.Space.xxl` | 32 pt |
| `DS.Anim.fast` | easeOut 0.15s |
| `DS.Anim.smooth` | easeInOut 0.35s |
| `DS.Anim.spring` | response 0.4, damping 0.75 |

</td>
</tr>
</table>

</div>

<br/>

### 🧩 Reusable Komponent Kitabxanası

`GlassCard` · `NeonBadge` · `ProStatCard` · `ProCountCard` · `MiniSparkline` · `HealthScoreRing` · `LumenProgressBar` · `CircularProgress` · `SkeletonRect` · `PulseDot` · `BlinkingCursor` · `SummaryBanner` · `SummaryChip` · `StatusPill` · `SectionHeader` · `DividerLine` · `CenteredEmpty` · `CenteredLoader`

<br/>

---

<br/>

## 📁 Layihə Strukturu

<div align="center">

```
Final Project/
│
├── 📂 Screens/
│   │
│   ├── 📂 Dashboard/                        🖥️  40+ fayl
│   │   ├── 📂 Core/         DashboardViewModel · DashboardCoordinator
│   │   │                    DashboardConstants · DashboardAggregates · DashboardChartBuilder
│   │   ├── 📂 Views/        DashboardView · DashMainContentView · DashLoadingView
│   │   │                    DashAmbientBackgroundView · DashboardViewController
│   │   ├── 📂 Cards/        DashHealthCardView · DashStatsGridView
│   │   │                    DashAlertsSectionView · DashTopContributorsView
│   │   ├── 📂 Chart/        DashMultiLineChart · DashInteractiveChartCanvas
│   │   │                    DashTrendChart · DashChartTabSelector
│   │   │                    SeriesLayer · MultiTooltipOverlay · LegendItem
│   │   ├── 📂 Health/       HealthScoreCalculator · HealthScoreRing · HealthStatus
│   │   └── 📂 Models/       ContainerStatsHistory · GlobalStatPoint
│   │                        ChartMetrics · TopContributorItem
│   │
│   ├── 📂 Containers/                       🐳  35+ fayl
│   │   ├── 📂 Images+Network+Volume/
│   │   │                    ImagesListView · NetworksListView · VolumesListView
│   │   │                    SummaryBanner · SummaryChip · PremiumCardList
│   │   ├── 📂 Premium/      PremiumImageRow · PremiumNetworkRow · PremiumVolumeRow
│   │   │                    PremiumRowShell · PremiumIconBox · RelativeTime
│   │   ├── 📂 ContainersDetail/
│   │   │                    ContainerDetailView · ContainerDetailViewModel
│   │   │                    ContainerActionsCard · ContainerLiveMetricsCard
│   │   │                    ContainerCriticalBanner · ContainerWSStatus
│   │   │                    ContainerDetailCard · ContainerDetailSections
│   │   │                    ContainerHeaderCard · ContainerMetricRow
│   │   └── 📂 (root)        ContainersViewModel · ContainersView · ContainerCard
│   │                        ContainerCardMetricStrip · ContainerCardBackground
│   │                        ContainersTabView · ContainersTabViewModel
│   │                        ContainerStateBadge · ContainersLiveBadge
│   │
│   ├── 📂 Alerts/                           🚨  20+ fayl
│   │   ├── 📂 ReusableComponents/
│   │   │                    AlertSeverity · AlertFilterType · AlertEvents
│   │   │                    AlertTimeFormatter
│   │   ├── 📂 ReusableViews/
│   │   │                    ProAlertRow · ProAlertRowGlow · ProAlertRowHeader
│   │   │                    ProAlertRowMetricPill · ProAlertRowMessage
│   │   │                    ProAlertRowTime · ProAlertRowIcon · ProAlertRowLeftBar
│   │   │                    SeverityPill · AlertsSearchBar · AlertsFilterRow
│   │   │                    AlertsListView · AlertsHeaderView · AlertsStatusPill
│   │   └── 📂 (root)        AlertsView · AlertViewModel · AlertViewController
│   │
│   ├── 📂 Logs/                             📜  20+ fayl
│   │   ├── Terminal/        TerminalOutputView · TerminalLogLine · TerminalTimestamp
│   │   │                    TerminalMessageText · LogFlashOverlay · TerminalSeparator
│   │   │                    TerminalRowBackground · BlinkingCursor
│   │   ├── Controls/        ContainerPickerView · LogLevelFilterRow · LogLevelChip
│   │   │                    LineCountPill · StreamStatusBadge · LogsToolbarRow
│   │   └── 📂 (root)        LogsView · LogsViewModel · LogsStreamLogic
│   │                        LogsFilterLogic · LogsContainerLogic · LogsState
│   │
│   └── 📂 Settings/                         ⚙️  25+ fayl
│       ├── Cards/           ServerCardView · NotificationsCardView
│       │                    AlertFlowCardView · AlertEmailCardView
│       │                    SignOutCardView · AppInfoCardView · GlowCardView
│       ├── Server/          ServerSetupSheetView · FlowConnectorView
│       │                    FlowNodeView · ConnectionStatusCapsule
│       │                    PrettyHostFormatter · ServerRowView
│       └── 📂 (root)        SettingsView · SettingsViewModel · SettingsViewController
│                            SettingsHeroHeaderView · SettingsBackgroundView
│
├── 📂 Network Layer/                        🔌
│   ├── 📂 Endpoint/         LumenService (protocol) · RealLumenService
│   │                        PocketLumenEndpoint · NetworkClient · NetworkError
│   ├── 📂 Mock/             MockStatsHub · MockLumenService · MockLogsHub
│   │                        MockData · MockWebSocketClient
│   └── 📂 WebSocket/        StatsStreaming · StatsWebSocketService · StatsStreamViewModel
│                            AlertSeverityHelper · DateParser · DefaultWebSocketClient
│                            WebSocketBackoff · StatsCache · CachedStatsEnvelope
│                            LogsStreaming · LogsWebSocketService · WSRoute
│                            LocalThresholdStore · WebSocketState · WebSocketClient
│
├── 📂 MainTabBar/           MainTabBarController
│
└── 📂 DesignSystem/         DS+Color · DS+Font · DS+Space · DS+Radius · DS+Anim
                             AppEnvironment  ← Mock ↔ Real switch #if DEBUG
```

</div>

<br/>

---

<br/>

## 🚀 Quraşdırma

### 📋 Tələblər

<div align="center">

| 🛠️ Alət | ✅ Minimum Versiya |
|:---:|:---:|
| 🍎 Xcode | 15.0+ |
| 📱 iOS | 17.0+ |
| 🦅 Swift | 5.9+ |
| 📦 CocoaPods | Aktual |

</div>

<br/>

### ⚡ Sürətli Başlanğıc

```bash
git clone https://github.com/username/lumen-ios.git
cd lumen-ios
pod install
open "Final Project.xcworkspace"
```

`GoogleService-Info.plist` faylını `Final Project/` qovluğuna əlavə edin, sonra **⌘R** ilə build edin.

<br/>

### 🧪 Mock Mode — Şəbəkəsiz Test

`DEBUG` build-da heç bir konfiqurasiya lazım deyil. Simulator-da birbaşa çalışdırın — MockStatsHub, MockLumenService, MockLogsHub avtomatik aktiv olur. Bütün 18 konteyner profili, spike-lar, alertlər, loglar — hamısı işləyir.

<br/>

### 🌐 Real Backend ilə

Settings → Server Card → Host URL daxil edin. Əsas test serveri: `159.223.192.61:8324`. Connection test düyməsinə basın, yaşıl status görünsə hazırsınız.

<br/>

---

<br/>

## 🛠️ Tech Stack

<div align="center">

| ⚙️ Texnologiya | 🔢 Versiya | 📋 İstifadə |
|:---|:---:|:---|
| 🦅 **Swift** | 5.9 | Əsas proqramlaşdırma dili |
| 🎨 **SwiftUI** | 5.0 | Bütün UI komponentlər — third-party UI yoxdur |
| 📱 **UIKit** | — | Tab navigation (UIHostingController ilə embedding) |
| ⚡ **Swift Concurrency** | — | async/await · AsyncThrowingStream · Task |
| 🔌 **URLSessionWebSocketTask** | — | Native WebSocket — third-party WebSocket yoxdur |
| 🔐 **Firebase Auth** | 10.x | İstifadəçi autentifikasiyası |
| 🔗 **Combine** | — | Settings auto-save 800ms debounce |
| 💾 **UserDefaults** | — | CPU threshold · notification preference |
| 📢 **NotificationCenter** | — | Container refresh cross-view signal |

</div>

<br/>

---

<br/>

## 📊 Performance Göstəriciləri

<div align="center">

| 📈 Göstərici | ⚡ Dəyər | 💡 Qeyd |
|:---|:---:|:---|
| 🔌 WebSocket stream interval | ~1 saniyə | Hər konteyner üçün ayrı stream |
| 📊 Chart history buffer | 40 nöqtə | ≈ 1.5 dəqiqəlik məlumat |
| 🔢 Dashboard recalc | 2 saniyə | Exponential smoothing ilə |
| 🚨 Alert refresh | 4 saniyə | Auto-refresh, istifadəçi müdaxiləsi yoxdur |
| 🐳 Container sync | 15 saniyə | Yeni konteyner kəşfi |
| 📜 Log buffer | 1500 sətir | Saatlarla log axını mümkündür |
| 🔁 WS reconnect | 6 cəhd | 1s → 2s → 4s → 8s → max 30s |
| ⏱️ StatsStream delay | 350ms | Detail view animasiyası tamamlansın deyə |
| 💀 Skeleton loading | Anında | ContainerCardSkeleton + ContainersSkeletonList |

</div>

<br/>

---

<br/>

## 💡 Əsas Dizayn Qərarları

<br/>

**🔄 Stream Persistence** — Navigation boyunca WebSocket stream-lər canlı qalır. Container detail-dən geri qayıdanda kartlar anında CPU göstərir — heç bir "Connecting..." gecikmə yoxdur. Bu qərara gəlməzdən əvvəl hər `onDisappear`-də stream-lər öldürülürdü, geri qayıdanda 1–2 saniyə boş kart görünürdü. İndi `onDisappear` yalnız `loadTask`-ı cancel edir, stream-lərə toxunmur.

**🔒 didLoadOnce / didStartOnce** — SwiftUI-nin `onAppear` hər tab keçidində, hər navigation push/pop-da tetiklənir. Bu flag-lər ilk yükləmədən sonra gereksiz şəbəkə requestlərinin qarşısını alır. Nəticə: daha az API call, daha sürətli UI.

**🎯 Hysteresis** — 19.9% CPU-da score "critical" olub, 19.8%-ə düşəndə "healthy" olmasın deyə enter/exit threshold-ları ayrıldı. Bu olmadan health ring saniyədə dəfələrlə rəng dəyişərdi — pis UX.

**🧵 nonisolated deinit** — `DashboardCoordinator` class-level `@MainActor` daşımır. Hər metod ayrıca annotasiya alır. Bu qərar `deinit`-dən `cancelAllTasks()` çağırışını mümkün edir — əks halda Swift compiler runtime error verərdi.

**⚡ Optimistic Updates** — Container actions (start/stop/restart) server cavabını gözləmədən UI-ı dərhal yeniləyir. İstifadəçi sıfır gecikmə hiss edir. Server xəta qaytararsa rollback baş verir.

**📐 CPU Faiz Formatı** — Real backend `cpuUsage: 22.58` göndərir. Bu 22.58% CPU-dur — `0.2258` fraction deyil. `normalizeToPercent()` yalnız `clamp(0, 100)` edir. Bunu `×100` etmək `22.58%`-i `2258%`-ə çevirərdi — çox ciddi bir bug.

<br/>

---

<br/>

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:30D158,50:5E5CE6,100:0A84FF&height=150&section=footer&text=Made%20with%20%E2%9D%A4%EF%B8%8F%20in%20Baku%20%F0%9F%87%A6%F0%9F%87%BF&fontSize=24&fontColor=ffffff&fontAlignY=55" width="100%"/>

<br/>

**Lumen** — *Cibinizdəki data center.*

⭐ Layihəni bəyəndinizsə star vurun — bu çox motivasiya verir!

<br/>

[![GitHub stars](https://img.shields.io/github/stars/username/lumen-ios?style=social)](https://github.com/username/lumen-ios)
[![GitHub forks](https://img.shields.io/github/forks/username/lumen-ios?style=social)](https://github.com/username/lumen-ios)

<br/>

*Swift · SwiftUI · Bakı, Azərbaycan 🇦🇿 · 2026*

</div>
