<div align="center">

<br/>

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0A84FF,100:30D158&height=200&section=header&text=LUMEN&fontSize=80&fontColor=ffffff&fontAlignY=38&desc=Docker%20Infrastructure%20Monitor%20for%20iOS&descAlignY=60&descSize=18&descColor=ffffff" width="100%"/>

<br/>

[![Swift](https://img.shields.io/badge/Swift-5.9-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-17.0+-000000?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-5-0071e3?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/swiftui/)
[![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![WebSocket](https://img.shields.io/badge/WebSocket-Real--time-00C853?style=for-the-badge&logo=socketdotio&logoColor=white)]()
[![Docker](https://img.shields.io/badge/Docker-Monitor-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![License](https://img.shields.io/badge/License-MIT-a855f7?style=for-the-badge)]()

<br/>

### Cibinizdən bütün Docker infrastrukturunuzu real-time idarə edin.

*Native iOS · WebSocket Streams · Hysteresis Health Scoring · Zero-Compromise UX*

<br/>

</div>

---

<br/>

## 🌟 Lumen nədir?

**Lumen** — DevOps mühəndisləri, SRE-lər və sistem administratorları üçün sıfırdan yazılmış professional Docker monitoring tətbiqidir.

Tətbiq real Docker backend-inə birbaşa qoşulur. Hər konteyner üçün ayrı WebSocket axını açır, CPU/Memory/Network metriklərini saniyəlik izləyir, ağıllı sağlamlıq skorlaması hesablayır, kritik hallarda dərhal xəbərdarlıq göndərir — hamısı tamamilə natif SwiftUI ilə.

<br/>

## ✨ Əsas Xüsusiyyətlər

<table>
<tr>
<td width="50%">

### 🖥️ Dashboard
Real-time infrastruktur lövhəsi. Animasiyalı Health Score Ring, interaktiv multi-line chartlar, top CPU/Memory istifadəçiləri və son xəbərdarlıqlar — hamısı bir ekranda.

</td>
<td width="50%">

### 🐳 Containers
18+ konteyner üçün canlı metric kartlar. Hər kartda real-time CPU%, Memory%, Network TX/RX. Detail görünüşündə environment variables, port mapping, mounted volumes.

</td>
</tr>
<tr>
<td width="50%">

### 🚨 Alerts
Severity-based xəbərdarlıq sistemi. Critical (≥20% CPU), High (≥12%), Medium. Axtarış, filter, auto-refresh. Glassmorphism ProAlertRow komponentlər.

</td>
<td width="50%">

### 📜 Live Logs
Terminal-style real-time log streaming. Konteyner seçici, log level filter, auto-scroll, 1500 sətir limit, nanosecond precision timestamp parsing.

</td>
</tr>
<tr>
<td width="50%">

### ⚙️ Settings
CPU threshold slider (1–99%), server URL konfiqurasiyası, notification toggle, Firebase email verification, sign out.

</td>
<td width="50%">

### 🧪 Mock Mode
Şəbəkəsiz tam simulasiya. Sin-wave + spike engine, 18 konteyner profili, real backend formatına uyğun data — DEBUG build-da avtomatik aktiv.

</td>
</tr>
</table>

<br/>

---

## 🏗️ Arxitektura

Lumen **MVVM + Coordinator** pattern üzərindədir. UIKit navigation qatı, üzərindəki SwiftUI view-ları UIHostingController vasitəsilə embed edir.

```
UIKit Navigation Layer
└── MainTabBarController
    ├── Dashboard ──── DashboardViewModel  ←→  DashboardCoordinator
    ├── Containers ─── ContainersViewModel ←→  WebSocket Streams × N
    ├── Alerts ──────── AlertViewModel      ←→  REST API (4s refresh)
    ├── Logs ────────── LogsViewModel       ←→  WebSocket Log Stream
    └── Settings ────── SettingsViewModel   ←→  UserDefaults + Firebase
                              │
              ┌───────────────┴───────────────┐
              │         Service Layer          │
              │  LumenService    (protocol)    │
              │  ├── RealLumenService  (REST)  │
              │  └── MockLumenService  (mock)  │
              │                               │
              │  StatsStreaming   (protocol)   │
              │  ├── RealStatsHub  (WebSocket) │
              │  └── MockStatsHub  (sin-wave)  │
              └───────────────────────────────┘
```

<br/>

---

## ⚡ Dashboard & Health Score

Health Score sistemi — Lumen-in ən mürəkkəb komponentidir. Üç texnika birlikdə işləyir:

<br/>

### 🏥 Penalty-Based Scoring

Hər 2 saniyədə bir bütün konteynerlərin məlumatları toplanır, aşağıdakı penaltilərlə 100-dən çıxılır:

| Vəziyyət | Penalti | Maks |
|----------|---------|------|
| 🔴 CPU ≥ 20% (critical) | −15 base, hər 5% üçün −1 extra | −40 |
| 🟠 CPU ≥ 12% (high) | −10 base, hər 6% üçün −1 extra | −20 |
| 🟡 CPU orta > 5% | −5 | — |
| 🔴 Memory ≥ 80% | −10 (mütənasib) | −20 |
| 🟠 Memory ≥ 60% | −5 (mütənasib) | −12 |
| 🚨 Hər kritik alert | −5 | −20 |
| ⛔ Hər dayanmış kont. | −3 | −12 |

<br/>

### 🔀 Hysteresis Thresholds

Score titrəməsinin (flutter) qarşısını alır. Enter və exit threshold-ları fərqlidir:

| | Enter (kritik başlayır) | Exit (normal qayıdır) |
|-|------------------------|----------------------|
| CPU Critical | ≥ 20% | < 15% |
| CPU High | ≥ 12% | < 8% |
| Memory Critical | ≥ 80% | < 70% |
| Memory High | ≥ 60% | < 50% |

<br/>

### 📈 Exponential Smoothing (α = 0.3)

Ani sıçrayışlar olmadan hamar keçid üçün. Yeni hədəf score 30%, cari score isə 70% çəki daşıyır.

<br/>

### 🎨 Health Status

| Score | Status | Rəng |
|-------|--------|------|
| ≥ 70 | Healthy | 🟢 Yaşıl |
| ≥ 40 | Warning | 🟡 Sarı |
| < 40 | Critical | 🔴 Qırmızı |

<br/>

### ⏱️ Dashboard Timer Orkestrası

| Timer | Interval | Vəzifə |
|-------|----------|--------|
| snapshotTimer | 4 saniyə | Chart history-ə nöqtə əlavə edir |
| alertTimer | 20 saniyə | Son alertləri sinxronlaşdırır |
| containerTimer | 15 saniyə | Yeni konteynerləri kəşf edir |
| recalcTimer | 2 saniyə | Aggregates + health score yenilənir |

<br/>

---

## 🐳 Container Streaming Sistemi

### Stream Lifecycle

Ən vacib arxitektura qərarlarından biri — navigation-da streams canlı qalır:

| Hadisə | loadTask | streamTasks | Nəticə |
|--------|----------|-------------|--------|
| `onAppear()` | 🔄 Yenilənir | ✅ Toxunulmur | Detail-dən geri gəldikdə kartlar dərhal CPU göstərir |
| `onDisappear()` | ❌ Cancel | ✅ Canlı qalır | Navigation push/pop-da stats itirilmir |
| `refresh()` | 🔄 Yenilənir | 🔄 Tam reset | Pull-to-refresh tam yükləmə edir |
| `containerTimer` | — | 🔄 Reconcile | Yeni kont. üçün stream açır, yox olanı bağlayır |

<br/>

### Container Actions

| Action | Optimistic Update | Protection |
|--------|------------------|------------|
| ▶️ Start | Dərhal "running" göstərir | — |
| ⏹️ Stop | Dərhal "exited" göstərir | lumen-app üçün blok 🔒 |
| 🔄 Restart | Dərhal "running" göstərir | lumen-app üçün blok 🔒 |
| 🗑️ Remove | Confirmation dialog | lumen-app üçün blok 🔒 |

<br/>

---

## 🚨 Alert Severity Sistemi

### Threshold Dəyərləri

| Severity | CPU | Memory |
|----------|-----|--------|
| 🔴 Critical | ≥ 20% | ≥ 80% |
| 🟠 High | ≥ 12% | ≥ 60% |
| 🟡 Medium | < 12% | < 60% |

<br/>

### Alert Flow

```
Service → getAlertHistory() → sort (newest first) → applyFilter() → UI
```

`didLoadOnce` flag ilə tab keçidlərində təkrar network request edilmir.

<br/>

---

## 📜 Logs Sistemi

### Əsas Xüsusiyyətlər

| Xüsusiyyət | Dəyər |
|-----------|-------|
| Max log buffer | 1500 sətir |
| Reconnect cəhdi | 6 dəfə |
| Retry strategiyası | Exponential backoff |
| Timestamp dəqiqliyi | Nanosecond (9 rəqəm) |
| Re-flash | Scroll-da əvvəlki loglar yenidən yanmır |

### Log Levels

| Səviyyə | Rəng | İstifadə |
|---------|------|----------|
| DEBUG | 🔵 Mavi | Development məlumatları |
| INFO | ⚪ Ağ | Adi hadisələr |
| WARN | 🟡 Sarı | Xəbərdarlıqlar |
| ERROR | 🔴 Qırmızı | Xətalar |

<br/>

---

## 🔌 Network Layer

### REST API

| Method | Endpoint | İzah |
|--------|----------|------|
| `GET` | `/containers` | Bütün konteynerlərin siyahısı |
| `GET` | `/containers/:id` | Konteyner detalları (env, ports, mounts) |
| `POST` | `/containers/:id/start` | Konteyneri başlat |
| `POST` | `/containers/:id/stop` | Konteyneri dayandır |
| `POST` | `/containers/:id/restart` | Konteyneri yenidən başlat |
| `DELETE` | `/containers/:id` | Konteyneri sil |
| `GET` | `/images` | Docker image-lar |
| `GET` | `/volumes` | Docker volume-lar |
| `GET` | `/networks` | Docker network-lər |
| `GET` | `/alerts` | Xəbərdarlıq tarixi |
| `DELETE` | `/alerts` | Bütün xəbərdarlıqları sil |

<br/>

### WebSocket Stats

**Endpoint:** `ws://{host}/stats?containerId={id}`

| Sahə | Tip | İzah |
|------|-----|------|
| `cpuUsage` | Double | CPU faizi — **0.0–100.0** (22.58 = 22.58%) |
| `memoryUsage` | Int | Bytes |
| `memoryLimit` | Int | Bytes (≈ 3917 MB default) |
| `memoryPercent` | Double | Memory faizi |
| `networkRx` | Int | Alınan bytes |
| `networkTx` | Int | Göndərilən bytes |

> ⚠️ **Mühüm:** `cpuUsage` faiz formatındadır. `22.58` = 22.58% CPU, `0.2258` fraction deyil. `normalizeToPercent()` yalnız `clamp(0, 100)` edir.

<br/>

### WebSocket Stack

| Komponent | Vəzifə |
|-----------|--------|
| `DefaultWebSocketClient` | `URLSessionWebSocketTask` wrapper |
| `WebSocketBackoff` | Exponential retry: 1s → 2s → 4s → 8s → max 30s |
| `StatsCache` | Son gələn stats cache-lənir |
| `DateParser` | Nanosecond timestamp parsing |
| `StatsStreamViewModel` | 350ms başlama gecikmə (detail view animation) |

<br/>

---

## 🧪 Mock Backend

`DEBUG` build-da şəbəkəsiz tam simulasiya. Sin-wave + spike engine ilə realistik data.

### Konteyner Profillər

| Konteyner | Normal CPU | Spike CPU | Spike ehtimalı | Vəziyyət |
|-----------|-----------|-----------|----------------|----------|
| `log-cpu-heavy` | 18–26% | — | 0% | 🔴 Həmişə Critical |
| `lumen-app` | ~3% | ~21% | 5%/saniyə | 🔴 Spike-da Critical |
| `lumen-postgres` | ~5.5% | ~14% | 5%/saniyə | 🟠 Spike-da High |
| `log-mongodb` | ~2.2% | ~13% | 6%/saniyə | 🟠 Spike-da High |
| `log-analytics` | ~2.5% | ~13% | 6%/saniyə | 🟠 Spike-da High |
| `log-search-service` | ~2% | ~13% | 6%/saniyə | 🟠 Spike-da High |
| `lumen-minio` | ~5% | — | 0% | 🟢 Normal |
| Digər 11 kont. | 1.6–3% | — | 0% | 🟢 Normal |

<br/>

---

## 🎨 Design System

Bütün vizual sabitlər `DS` namespace altında mərkəzləşdirilmişdir.

<table>
<tr>
<td width="50%">

**Rənglər**
- `DS.Color.accent` — əsas mavi
- `DS.Color.danger` — kritik qırmızı
- `DS.Color.warning` — amber
- `DS.Color.success` — yaşıl
- `DS.Color.bg0–bg4` — fon ierarxiyası
- `DS.Color.textPrimary/Secondary/Tertiary/Muted`

</td>
<td width="50%">

**Animasiya & Layout**
- `DS.Anim.fast` — 0.15s easeOut
- `DS.Anim.smooth` — 0.35s easeInOut
- `DS.Anim.spring` — response 0.4, damping 0.75
- `DS.Space.xs/sm/md/lg/xl/xxl` — 4–32pt
- `DS.Radius.xs/sm/md/lg` — 6–20pt

</td>
</tr>
</table>

### Reusable Komponentlər

`GlassCard` · `NeonBadge` · `ProStatCard` · `ProCountCard` · `MiniSparkline` · `HealthScoreRing` · `LumenProgressBar` · `SkeletonRect` · `PulseDot` · `BlinkingCursor` · `SummaryBanner` · `StatusPill`

<br/>

---

## 📁 Layihə Strukturu

```
Final Project/
│
├── 📂 Screens/
│   ├── 📂 Dashboard/          (40+ fayl)
│   │   ├── Core/              DashboardViewModel · DashboardCoordinator
│   │   │                      DashboardConstants · DashboardAggregates
│   │   ├── Views/             DashboardView · DashMainContentView
│   │   ├── Cards/             DashHealthCardView · DashStatsGridView
│   │   │                      DashAlertsSectionView · DashTopContributorsView
│   │   ├── Chart/             DashMultiLineChart · DashInteractiveChartCanvas
│   │   │                      SeriesLayer · MultiTooltipOverlay
│   │   ├── Health/            HealthScoreCalculator · HealthScoreRing · HealthStatus
│   │   └── Models/            ContainerStatsHistory · GlobalStatPoint · ChartMetrics
│   │
│   ├── 📂 Containers/         (35+ fayl)
│   │   ├── Images+Network+Volume/   ImagesListView · NetworksListView · VolumesListView
│   │   ├── Premium/           PremiumImageRow · PremiumNetworkRow · PremiumVolumeRow
│   │   ├── ContainersDetail/  ContainerDetailView · ContainerDetailViewModel
│   │   │                      ContainerActionsCard · ContainerLiveMetricsCard
│   │   │                      ContainerCriticalBanner · ContainerWSStatus
│   │   └── (root)             ContainersViewModel · ContainerCard · ContainersTabView
│   │
│   ├── 📂 Alerts/             (20+ fayl)
│   │   ├── ReusableComponents/  AlertSeverity · AlertFilterType · AlertTimeFormatter
│   │   ├── ReusableViews/       ProAlertRow · SeverityPill · AlertsSearchBar
│   │   │                        ProAlertRowGlow · ProAlertRowMetricPill
│   │   └── (root)             AlertsView · AlertViewModel · AlertViewController
│   │
│   ├── 📂 Logs/               (20+ fayl)
│   │   ├── Terminal/          TerminalOutputView · TerminalLogLine · TerminalTimestamp
│   │   │                      LogFlashOverlay · BlinkingCursor · TerminalMessageText
│   │   ├── Controls/          ContainerPickerView · LogLevelFilterRow · StreamStatusBadge
│   │   └── (root)             LogsView · LogsViewModel · LogsStreamLogic
│   │
│   └── 📂 Settings/           (25+ fayl)
│       ├── Cards/             ServerCardView · NotificationsCardView · AlertFlowCardView
│       │                      AlertEmailCardView · SignOutCardView
│       ├── Server/            ServerSetupSheetView · FlowConnectorView
│       │                      ConnectionStatusCapsule · PrettyHostFormatter
│       └── (root)             SettingsView · SettingsViewModel · SettingsViewController
│
├── 📂 Network Layer/
│   ├── Endpoint/              LumenService (protocol) · RealLumenService · PocketLumenEndpoint
│   ├── Mock/                  MockStatsHub · MockLumenService · MockLogsHub
│   │                          MockData · MockWebSocketClient
│   └── WebSocket/             StatsStreaming · StatsWebSocketService · StatsStreamViewModel
│                              AlertSeverityHelper · DateParser · DefaultWebSocketClient
│                              WebSocketBackoff · LocalThresholdStore · WSRoute
│
├── 📂 MainTabBar/             MainTabBarController
│
└── 📂 DesignSystem/           DS+Color · DS+Font · DS+Space · DS+Radius · DS+Anim
                               AppEnvironment (Mock ↔ Real switch)
```

<br/>

---

## 🚀 Quraşdırma

### Tələblər

| | Versiya |
|-|---------|
| Xcode | 15.0+ |
| iOS target | 17.0+ |
| Swift | 5.9+ |
| CocoaPods | Aktual |

<br/>

### Addımlar

```bash
git clone https://github.com/username/lumen-ios.git
cd lumen-ios
pod install
open "Final Project.xcworkspace"
```

`GoogleService-Info.plist` faylını `Final Project/` qovluğuna əlavə et, sonra **⌘R** ilə build et.

> 💡 **Mock Mode:** `DEBUG` build-da server olmadan işləyir. Simulator-da birbaşa çalışdırın.

<br/>

---

## 🛠️ Tech Stack

| Texnologiya | İstifadə |
|-------------|---------|
| **Swift 5.9** | Əsas dil |
| **SwiftUI 5** | Bütün UI komponentlər |
| **UIKit** | Tab navigation (UIHostingController) |
| **Swift Concurrency** | async/await · AsyncThrowingStream |
| **URLSessionWebSocketTask** | Native WebSocket — third-party yoxdur |
| **Firebase Auth** | İstifadəçi autentifikasiyası |
| **Combine** | Settings auto-save debounce |
| **UserDefaults** | CPU threshold · preferences |
| **NotificationCenter** | Cross-view container refresh signalı |

<br/>

---

## 📊 Performance

| Göstərici | Dəyər |
|-----------|-------|
| WebSocket stream interval | ~1 saniyə / konteyner |
| Chart history buffer | 40 nöqtə (~1.5 dəq) |
| Dashboard recalc interval | 2 saniyə |
| Alert refresh interval | 4 saniyə |
| Container sync interval | 15 saniyə |
| Log buffer limit | 1500 sətir |
| WS reconnect limit | 6 cəhd (exponential backoff) |
| StatsStreamViewModel delay | 350ms (detail view animation üçün) |

<br/>

---

## 💡 Əsas Dizayn Qərarları

**Stream Persistence** — `onDisappear` WebSocket stream-ləri öldürmür. Əks halda container detail-dən geri gəldikdə 1–2 saniyə "Connecting..." görünürdü.

**didLoadOnce / didStartOnce** — Tab keçidlərində `onAppear` yenidən tetiklənir. Bu flag-lər gereksiz şəbəkə requestlərini bloklayır.

**Hysteresis** — 19.8% CPU-da score "critical" olub, 19.7%-ə düşəndə "healthy" olmasın deyə enter/exit threshold-ları fərqləndirildi.

**nonisolated deinit** — `DashboardCoordinator` class-level `@MainActor` daşımır. Hər metod ayrıca annotasiya alır. Bu `deinit`-dən `cancelAllTasks()` çağırışını mümkün edir.

**CPU Faiz Formatı** — Real backend `cpuUsage: 22.58` göndərir, bu 22.58% deməkdir. `normalizeToPercent()` yalnız `clamp(0, 100)` edir — çarpma yoxdur.

<br/>

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0A84FF,100:30D158&height=120&section=footer" width="100%"/>

**Lumen** — *Cibinizdəki data center.*

⭐ Layihəni bəyəndinizsə star vurun!

Made with ❤️ · Swift · Bakı, Azərbaycan 🇦🇿

</div>
