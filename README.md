<div align="center">

<br />

```
██╗     ██╗   ██╗███╗   ███╗███████╗███╗   ██╗
██║     ██║   ██║████╗ ████║██╔════╝████╗  ██║
██║     ██║   ██║██╔████╔██║█████╗  ██╔██╗ ██║
██║     ██║   ██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║
███████╗╚██████╔╝██║ ╚═╝ ██║███████╗██║ ╚████║
╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝
```

**Professional Docker Infrastructure Monitor · Native iOS**

<br/>

[![Swift](https://img.shields.io/badge/Swift-5.9-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-17.0+-000000?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-0071e3?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/swiftui/)
[![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![WebSocket](https://img.shields.io/badge/WebSocket-Live_Streams-00C853?style=for-the-badge&logo=socket.io&logoColor=white)]()
[![Docker](https://img.shields.io/badge/Docker-API-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![License](https://img.shields.io/badge/License-MIT-purple?style=for-the-badge)]()

<br/>

> 🌟 **Lumen** — Cibinizdən bütün Docker infrastrukturunuzu real-time idarə edin.  
> WebSocket streams · Interactive charts · Hysteresis health scoring · Zero-compromise UX.

<br/>

</div>

---

## 📋 Mündəricat

| | |
|---|---|
| [✨ Layihə haqqında](#-layihə-haqqında) | [🏗️ Arxitektura](#️-arxitektura) |
| [📱 Ekranlar & Funksiyalar](#-ekranlar--funksiyalar) | [⚡ Dashboard & Health Score](#-dashboard--health-score) |
| [🐳 Container Sistemi](#-container-sistemi) | [🚨 Alert Sistemi](#-alert-sistemi) |
| [📜 Live Logs](#-live-logs) | [⚙️ Settings](#️-settings) |
| [🔌 Network Layer](#-network-layer) | [🧪 Mock Backend](#-mock-backend) |
| [🎨 Design System](#-design-system) | [📁 Layihə Strukturu](#-layihə-strukturu) |
| [🚀 Quraşdırma](#-quraşdırma) | [🛠️ Tech Stack](#️-tech-stack) |

---

## ✨ Layihə haqqında

**Lumen** — iOS üçün sıfırdan yazılmış professional Docker monitoring tətbiqidir. DevOps mühəndisləri, SRE-lər və sistem administratorları üçün nəzərdə tutulub.

Tətbiq real backend-ə WebSocket vasitəsilə qoşulur, hər konteyner üçün ayrı-ayrı stats axını yaradır, ağıllı sağlamlıq skorlaması aparır və kritik hallarda ani xəbərdarlıq göndərir — hamısı natif SwiftUI ilə.

```
👩‍💻  Developer    :  Sabina Karimli
📅  Başlama tarixi:  Fevral 2026
🏙️  Yer           :  Bakı, Azərbaycan 🇦🇿
📦  Xcode project :  Final Project
🎯  Target        :  iPhone (iOS 17.0+)
🔐  Auth          :  Firebase Authentication
📡  Real-time     :  URLSessionWebSocketTask (per-container streams)
🧪  Mock mode     :  DEBUG build — şəbəkəsiz tam simulasiya
```

---

## 🏗️ Arxitektura

Lumen **MVVM + Coordinator** pattern üzərindədir. UIKit navigation layer üstündə SwiftUI view-lar embed edilib.

```
┌─────────────────────────────────────────────────────────────────────┐
│                         UIKit Navigation                            │
│   MainTabBarController                                              │
│   ├── DashboardViewController    → embeds DashboardView            │
│   ├── ContainersViewController   → embeds ContainersTabView        │
│   ├── AlertViewController        → embeds AlertsView               │
│   ├── LogsViewController         → embeds LogsView                 │
│   └── SettingsViewController     → embeds SettingsView             │
└─────────────────────────┬───────────────────────────────────────────┘
                          │  UIHostingController
┌─────────────────────────▼───────────────────────────────────────────┐
│                        SwiftUI Views                                │
│                                                                     │
│  DashboardView ──── DashboardViewModel (@MainActor, @StateObject)  │
│       │                    │                                        │
│       │             DashboardCoordinator                            │
│       │             ├── snapshotTimer  (4s)                         │
│       │             ├── alertTimer     (20s)                        │
│       │             ├── containerTimer (15s)                        │
│       │             └── streamTasks    (per-container WS)           │
│       │                                                             │
│  ContainersTabView ─ ContainersTabViewModel                        │
│       └── ContainersView ── ContainersViewModel                    │
│                 └── [ContainerCard] × N  ← live metric strips      │
│                       └── ContainerDetailView                      │
│                             └── StatsStreamViewModel               │
│                                                                     │
│  AlertsView ──── AlertViewModel                                     │
│  LogsView   ──── LogsViewModel + LogsStreamLogic                   │
│  SettingsView ── SettingsViewModel                                  │
└─────────────────────────┬───────────────────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────────────────┐
│                       Network Layer                                 │
│                                                                     │
│   LumenService (protocol)                                           │
│   ├── RealLumenService   → REST API (GET/POST/DELETE)               │
│   └── MockLumenService   → Simulated responses                      │
│                                                                     │
│   StatsStreaming (protocol)                                         │
│   ├── RealStatsHub       → ws://host/stats?containerId={id}         │
│   └── MockStatsHub       → Sin-wave + spike simulation engine       │
│                                                                     │
│   WebSocket Stack                                                   │
│   ├── DefaultWebSocketClient  (URLSessionWebSocketTask wrapper)     │
│   ├── WebSocketBackoff        (exponential retry)                   │
│   ├── StatsCache              (CachedStatsEnvelope)                 │
│   └── DateParser              (nanosecond timestamp support)        │
└─────────────────────────────────────────────────────────────────────┘
```

### 🔄 Stats Data Flow

```
WebSocket  →  ContainerStats  →  normalizeToPercent()  →  clamp(0–100)
                                         │
                    ┌────────────────────┼────────────────────┐
                    │                    │                    │
              ContainerCard       ContainerStatsHistory   HealthScore
              (live UI strip)     (40-point chart buffer)  Calculator
                    │                    │                    │
               CPU% / MEM%        DashboardChartBuilder   target score
               Network TX/RX      multi-line charts        α=0.3 smooth
```

### 🧩 Key Architectural Decisions

| Pattern | Harada | Niyə |
|---------|--------|------|
| `@MainActor` | Bütün ViewModels | Thread-safe UI update-ları |
| `AsyncThrowingStream` | Stats streaming | Structured Swift concurrency |
| `didLoadOnce` flag | AlertVM, DetailVM | Double network request önlənir |
| `didStartOnce` flag | DashboardVM | Tab-switch-də double-start yoxdur |
| Hysteresis thresholds | HealthScoreCalculator | Score titrəməsi (flutter) aradan qalxır |
| Exponential smoothing α=0.3 | DashboardVM | Hamar health score animasiyası |
| Protocol-based services | LumenService, StatsStreaming | Mock ↔ Real asan keçid |
| Coordinator pattern | DashboardCoordinator | Timer + stream lifecycle idarəsi |
| `nonisolated deinit` | DashboardCoordinator | Task cancel deinit-dən təhlükəsiz |
| Stream persistence | ContainersViewModel | Navigation push/pop-da streams canlı qalır |

---

## 📱 Ekranlar & Funksiyalar

### 🖥️ Dashboard Tab
Real-time Docker infrastruktur lövhəsi — 5 vizual bölmə:

- **🏥 Health Score Ring** — 0–100 arası animasiyalı sağlamlıq göstəricisi (hysteresis + smoothing)
- **📊 Stats Grid** — Ümumi CPU%, Memory MB, Running count, Critical count
- **📈 Interactive Charts** — CPU Contribution / CPU Trend / Memory Trend (3 tab)
- **🔝 Top Contributors** — Ən çox CPU/RAM istifadə edən konteynerlar
- **🚨 Recent Alerts** — Son 5 kritik xəbərdarlıq

### 🐳 Containers Tab
Per-container real-time metric kartları:

- **Live metric strip** — hər kartda CPU% + MEM% progress bar + Network TX/RX
- **Filter chips** — All / Running / Stopped
- **Search** — konteyner adına görə axtarış
- **Pull-to-refresh** — sürüşdürərək yeniləmə
- **Tabs** — Containers / Images / Volumes / Networks
- **Detail view** — Environment variables, Ports, Mounts, Live stats, Actions

### 🚨 Alerts Tab
Xəbərdarlıq mərkəzi:

- **Severity filter** — All / Critical / High / Medium
- **Search** — konteyner adına görə axtarış
- **Auto-refresh** — hər 4 saniyədə bir
- **Clear history** — bütün xəbərdarlıqları silmə

### 📜 Logs Tab
Terminal-style real-time log axını:

- **Container picker** — hansı konteynerin logunu izləmək seçimi
- **Log level filter** — INFO / WARN / ERROR / DEBUG
- **Live streaming** — WebSocket vasitəsilə real-time output
- **Auto-scroll** — yeni loglar gəldikdə aşağı sürüşmə
- **Line count pill** — cari log sayı göstəricisi

### ⚙️ Settings Tab
İstifadəçi tərəfindən fərdiləşdirilə bilər:

- **Server connection** — host URL konfiqurasiyası + connection test
- **CPU threshold slider** — 1–99% arası xəbərdarlıq hədd dəyəri
- **Notification toggle** — bildirişləri açıb/bağlamaq
- **Email verification** — Firebase istifadəçi məlumatları
- **Sign out** — hesabdan çıxış

---

## ⚡ Dashboard & Health Score

### Health Score Mexanizmi

Health score sistemi üç əsas texnikadan istifadə edir:

**1. Penalty-based scoring**
```swift
score = 100
score -= cpuPenalty     // max CPU-ya görə (hysteresis ilə)
score -= memPenalty     // ortalama memory-yə görə
score -= alertPenalty   // aktiv kritik alertlərə görə
score -= stoppedPenalty // dayanmış konteynerlərə görə
```

**2. Hysteresis thresholds** — titrəmə (score flutter) aradan qalxır:
```
CPU Critical: enter ≥ 20%  → exit < 15%
CPU High:     enter ≥ 12%  → exit <  8%
MEM Critical: enter ≥ 80%  → exit < 70%
MEM High:     enter ≥ 60%  → exit < 50%
```

**3. Exponential smoothing** — ani sıçrayış olmadan hamar keçid:
```swift
// α = 0.3  →  yeni dəyər 30%, köhnə dəyər 70% təsir edir
smoothedScore = Int(Double(target) * 0.3 + Double(current) * 0.7)
```

### Penalty Cədvəli

| Vəziyyət | Base Penalti | Extra | Maks |
|----------|-------------|-------|------|
| CPU ≥ 20% (critical) | −15 | hər +5% üçün −1 | −40 |
| CPU ≥ 12% (high) | −10 | hər +6% üçün −1 | −20 |
| CPU avg > 5% | −5 | — | — |
| Memory ≥ 80% | −10 (prop.) | — | −20 |
| Memory ≥ 60% | −5 (prop.) | — | −12 |
| Hər kritik alert | −5 | — | −20 |
| Hər dayanmış kont. | −3 | — | −12 |

### Health Status

```
Score ≥ 70  →  🟢  Healthy
Score ≥ 40  →  🟡  Warning
Score  < 40  →  🔴  Critical
```

### Dashboard Timer Orkestrası

```
DashboardCoordinator
├── snapshotTimer   : hər  4s → globalHistory-ə nöqtə əlavə edir
├── alertTimer      : hər 20s → recentAlerts sinxronlaşdırılır
├── containerTimer  : hər 15s → yeni konteynerləri kəşf edir
└── (DashboardViewModel)
    └── recalcTimer : hər  2s → aggregates + health score yenilənir
```

### Chart Sistemi

```
ChartTab.cpuContribution  →  Hər konteynerin CPU töhfəsi
ChartTab.cpuTrend         →  Zaman üzrə ümumi CPU trendi (multi-line)
ChartTab.memoryTrend      →  Zaman üzrə ümumi Memory trendi (multi-line)

ContainerStatsHistory: 40 nöqtəlik rolling buffer (hər 2.5s bir snapshot)
GlobalStatPoint:       timestamp + totalCPU + totalMemoryMB
```

---

## 🐳 Container Sistemi

### Stream Lifecycle — Əsas Dizayn Qərarı

```
ContainersViewModel
│
├── onAppear()
│   └── Yalnız loadTask yenilənir
│       Stream tasks TOXUNULMUR ✅
│       → Detail-dən geri gəldikdə kartlar dərhal CPU göstərir
│
├── onDisappear()
│   └── Yalnız loadTask cancel edilir
│       Stream tasks CANLIQALIR ✅
│       → Navigation push/pop-da stats itirilmir
│
├── refresh()          [pull-to-refresh + NotificationCenter]
│   └── TAM RESET: cancelStreams() + latestStats.removeAll()
│       → Yeni yükləmə başlayır
│
└── reconcileStreams()  [containerTimer hər 15s]
    └── Yeni konteyner üçün stream başlat
        Artıq yoxolan konteyner üçün stream dayandır
```

### Container Actions

```swift
// Optimistic update — istifadəçi dərhal dəyişiklik görür
Start   → state: "running"   (server cavabını gözləmədən)
Stop    → state: "exited"
Restart → state: "running"

// System-critical protection
if container.name == "lumen-app" {
    // Stop / Restart / Remove buttons → deaktiv 🔒
}
```

### ContainerCard — Live Metric Strip

```
┌─────────────────────────────────────────────────┐
│  🔵 lumen-app              ● running          › │
│     lumen-mobile-app:local                       │
│                                                  │
│  🖥 CPU          💾 MEM         ↓233B ↑132B     │
│  21.9% ████░░   12.0% ██░░░                     │
└─────────────────────────────────────────────────┘

cpuPct = clamp(cpuUsage, 0, 100)      // faiz format, clamp only
memPct = clamp(memoryPercent, 0, 100) // faiz format, clamp only
```

---

## 🚨 Alert Sistemi

### Severity Thresholds

```swift
AlertSeverityHelper.Threshold
├── cpuHigh   : 20.0%  →  🔴  Critical
├── cpuMedium : 12.0%  →  🟠  High / Warning
├── memHigh   : 80.0%  →  🔴  Critical
└── memMedium : 60.0%  →  🟡  Medium
```

### Alert Flow

```
Service.getAlertHistory()
        │
        ▼
AlertViewModel.load()  [didLoadOnce guard — double request yoxdur]
        │
        ▼
sort by timestamp (descending) → applyFilter(severity + search)
        │
        ▼
AlertsView → ProAlertRow (glow + severity pill + metric chips)
```

### ProAlertRow Komponentlər

```
ProAlertRowShell
├── ProAlertRowCardBackground   (glassmorphism card)
├── ProAlertRowGlow             (severity rənginə uyğun glow)
├── ProAlertRowLeftBar          (rəngli sol border)
├── ProAlertRowIcon             (konteyner tipi ikonu)
├── ProAlertRowHeader           (konteyner adı + SeverityPill)
├── ProAlertRowMessage          (xəbərdarlıq mətni)
├── ProAlertRowMetricPill       (CPU% + MEM%)
└── ProAlertRowTime             (relative timestamp)
```

---

## 📜 Live Logs

### Stream Arxitekturası

```
LogsView
├── ContainerPickerView    → aktiv konteyner seçimi
└── TerminalOutputView     → terminal-style log render
      ├── TerminalLogLine        (satır komponenti)
      ├── TerminalTimestamp      (nanosecond precision)
      ├── TerminalMessageText    (rəngli log mətni)
      └── LogFlashOverlay        (yeni log highlight animasiyası)

LogsViewModel
└── LogsStreamLogic
    ├── max 1500 log satırı     (performans limiti)
    ├── maxAttempts: 6          (reconnect cəhdi sayı)
    ├── userStopped flag        (istifadəçi dayandırırsa yenidən başlamır)
    ├── pendingLogs buffer      (batch UI update)
    └── DateParser              (nanosecond timestamp fix)
```

### Nanosecond Timestamp Fix

```swift
// Problem: "2026-03-07T11:09:27.391118289Z" → standard parser bacarmir
// Həll: 9 rəqəmli nanosecond-u 3 rəqəmə kəs
"2026-03-07T11:09:27.391118289Z"
         ↓  trim to milliseconds
"2026-03-07T11:09:27.391Z"
         ↓  ISO8601DateFormatter parse
✅  Date object
```

### Log Level Sistemi

```
🔵  DEBUG   → development məlumatları
⚪  INFO    → adi hadisələr
🟡  WARN    → xəbərdarlıqlar
🔴  ERROR   → xətalar
```

---

## ⚙️ Settings

### CPU Threshold

```swift
@Published var cpuThreshold: Double {
    didSet {
        guard oldValue != cpuThreshold else { return }  // sonsuz döngü yoxdur
        let clamped = min(max(cpuThreshold, 1.0), 99.0)
        LocalThresholdStore.saveCPU(clamped)            // UserDefaults
        AlertSeverityHelper.Threshold.current = clamped // global threshold yenilənir
    }
}
```

### Auto-Save

```swift
// Debounce — hər dəyişiklikdə dərhal save etmir, 800ms gözləyir
private func scheduleAutoSave() {
    autoSaveTask?.cancel()
    autoSaveTask = Task {
        try? await Task.sleep(nanoseconds: 800_000_000)
        await performSave()
    }
}

deinit {
    autoSaveTask?.cancel() // memory leak yoxdur ✅
}
```

### Server Setup

```
ServerSetupSheetView
├── Host URL daxil etmə
├── ConnectionStatusCapsule  → bağlantı testi nəticəsi
├── PrettyHostFormatter      → URL-i oxunaqlı formata çevirir
└── FlowConnectorView        → animasiyalı connection flow diagramı
```

---

## 🔌 Network Layer

### REST Endpoints

```
Base URL: http://{host}:{port}

GET    /containers              →  [ContainerInfo]
GET    /containers/:id          →  ContainerInfo (env, ports, mounts)
POST   /containers/:id/start    →  200 OK
POST   /containers/:id/stop     →  200 OK
POST   /containers/:id/restart  →  200 OK
DELETE /containers/:id          →  200 OK

GET    /images                  →  [DockerImage]
GET    /volumes                 →  [DockerVolume]
GET    /networks                →  [DockerNetwork]

GET    /alerts                  →  [Alert]
DELETE /alerts                  →  200 OK (clear all)
```

### WebSocket Stats Format

```
Endpoint: ws://{host}:{port}/stats?containerId={id}

// Hər ~1 saniyədə gələn payload:
{
  "containerId":    "e517a71cfa3b...",
  "cpuUsage":       22.58,        // ← FAIZ (0.0–100.0), fraction DEYİL
  "memoryUsage":    204800000,    // bytes
  "memoryLimit":    4106219520,   // bytes (≈ 3917 MB)
  "memoryPercent":  4.98,         // faiz
  "networkRx":      45231,        // bytes received
  "networkTx":      12048         // bytes transmitted
}
```

### WebSocket Stack

```
WebSocketClient (protocol)
└── DefaultWebSocketClient
    ├── connect()      → URLSessionWebSocketTask.resume()
    ├── receive()      → AsyncStream<String>
    ├── disconnect()   → task.cancel()
    └── WebSocketBackoff → exponential retry (1s→2s→4s→8s→max 30s)

StatsStreamViewModel
├── 350ms başlama gecikmə   → detail view açıldıqda animation tamamlanır
├── CachedStatsEnvelope     → son gələn stats cache-lənir
└── StatsCache              → shared cache (multi-view sync)
```

### ⚠️ CPU Format — Mühüm Qeyd

```
Real backend HƏMİŞƏ faiz göndərir:
  22.58  →  22.58% CPU  ✅
   1.45  →   1.45% CPU  ✅ (bu fraction DEYİL!)

normalizeToPercent() = sadəcə clamp(0, 100)
Heç bir ×100 çevrilməsi yoxdur
```

---

## 🧪 Mock Backend

`DEBUG` build-da şəbəkəsiz tam simulasiya mühiti:

### MockStatsHub — Sin-Wave + Spike Engine

```swift
struct Profile {
    let baseCPU:       Double  // normal CPU faizi (0–100)
    let cpuAmplitude:  Double  // dalğa amplitudu
    let spikeChance:   Double  // hər saniyə spike ehtimalı
    let spikeMult:     Double  // spike = baseCPU × spikeMult
    let baseMem:       Double  // normal memory MB
    let memAmplitude:  Double
}

// CPU formulası:
rawCPU = baseCPU + amplitude × sin(phase) + noise
       + (spikeActive ? spikeMult × baseCPU : 0)
finalCPU = clamp(rawCPU, 0.1, 99.9)
```

### Konteyner Profillər

| Konteyner | Normal CPU | Spike CPU | Spike ehtimalı | Severity |
|-----------|-----------|-----------|----------------|----------|
| `log-cpu-heavy` | 18–26% | — | 0% | 🔴 Həmişə Critical |
| `lumen-app` | ~3% | ~21% | 5%/s | 🔴 Spike-da Critical |
| `lumen-postgres` | ~5.5% | ~13.8% | 5%/s | 🟠 Spike-da High |
| `log-mongodb` | ~2.2% | ~13.2% | 6%/s | 🟠 Spike-da High |
| `log-analytics` | ~2.5% | ~12.5% | 6%/s | 🟠 Spike-da High |
| `log-search-service` | ~2% | ~13% | 6%/s | 🟠 Spike-da High |
| `lumen-minio` | ~5% | — | 0% | 🟢 Normal |
| Digər 11 kont. | 1.6–3% | — | 0% | 🟢 Normal |

### Environment Switch

```swift
// AppEnvironment.swift
#if DEBUG
static func makeLumenService()   -> LumenService   { MockLumenService() }
static func makeStatsStreaming() -> StatsStreaming  { MockStatsHub.shared }
#else
static func makeLumenService()   -> LumenService   { RealLumenService() }
static func makeStatsStreaming() -> StatsStreaming  { RealStatsHub.shared }
#endif
```

---

## 🎨 Design System

Lumen özünəməxsus `DS` namespace istifadə edir — bütün magic number-lar mərkəzləşdirilmiş:

```swift
// Rənglər
DS.Color.accent / danger / warning / success
DS.Color.bg0 … bg4          // katmanlaşmış fon ierarxiyası
DS.Color.textPrimary / Secondary / Tertiary / Muted

// Tipografiya
DS.Font.headline(_ size:)   // SFRounded Bold
DS.Font.mono(_ size:)       // monospaced — log output
DS.Font.label(_ size:)      // tracked caps
DS.Font.caption(_ size:)

// Spacing & Radius
DS.Space.xs / sm / md / lg / xl / xxl    // 4–32 pt
DS.Radius.xs / sm / md / lg             // 6–20 pt

// Animation
DS.Anim.fast    // .easeOut(0.15s)
DS.Anim.smooth  // .easeInOut(0.35s)
DS.Anim.spring  // spring(response:0.4, dampingFraction:0.75)
```

### Reusable Components

```
GlassCard / NeonBadge / ProStatCard / ProCountCard
MiniSparkline / HealthScoreRing / LumenProgressBar
SkeletonRect / PulseDot / BlinkingCursor
SummaryBanner / SummaryChip / StatusPill
```

---

## 📁 Layihə Strukturu

```
Final Project/
│
├── 📂 Screens/
│   ├── 📂 Dashboard/                   (40+ fayl)
│   │   ├── 📂 Core/
│   │   │   ├── DashboardViewModel      ← @MainActor, health score
│   │   │   ├── DashboardCoordinator    ← timer + stream orkestrası
│   │   │   ├── DashboardConstants      ← centralized constants
│   │   │   ├── DashboardAggregates     ← computeTotals, normalizeToPercent
│   │   │   └── DashboardChartBuilder
│   │   ├── 📂 Views/
│   │   │   ├── DashboardView
│   │   │   ├── DashMainContentView
│   │   │   ├── DashLoadingView
│   │   │   └── DashAmbientBackgroundView
│   │   ├── 📂 Cards/
│   │   │   ├── DashHealthCardView      ← HealthScoreRing + status
│   │   │   ├── DashStatsGridView       ← 4 ProStatCard
│   │   │   ├── DashAlertsSectionView   ← son 5 alert
│   │   │   └── DashTopContributorsView
│   │   ├── 📂 Chart/
│   │   │   ├── DashMultiLineChart      ← interactive multi-series
│   │   │   ├── DashInteractiveChartCanvas
│   │   │   ├── DashTrendChart
│   │   │   ├── DashChartTabSelector
│   │   │   ├── MultiTooltipOverlay
│   │   │   └── SeriesLayer
│   │   ├── 📂 Health/
│   │   │   ├── HealthScoreCalculator   ← hysteresis + penalty
│   │   │   ├── HealthScoreRing         ← animasiyalı halqa
│   │   │   └── HealthStatus
│   │   └── 📂 Models/
│   │       ├── ContainerStatsHistory   ← 40-point rolling buffer
│   │       ├── GlobalStatPoint
│   │       ├── ChartMetrics
│   │       └── TopContributorItem
│   │
│   ├── 📂 Containers/                  (35+ fayl)
│   │   ├── 📂 Images+Network+Volume/
│   │   │   ├── ImagesListView
│   │   │   ├── NetworksListView
│   │   │   └── VolumesListView
│   │   ├── 📂 Premium/
│   │   │   ├── PremiumImageRow
│   │   │   ├── PremiumNetworkRow
│   │   │   ├── PremiumVolumeRow
│   │   │   └── PremiumRowShell
│   │   ├── 📂 ContainersDetail/
│   │   │   ├── ContainerDetailView     ← env vars, ports, mounts
│   │   │   ├── ContainerDetailViewModel← detailLoaded flag
│   │   │   ├── ContainerActionsCard    ← start/stop/restart/remove
│   │   │   ├── ContainerLiveMetricsCard← real-time stats
│   │   │   ├── ContainerCriticalBanner ← system-critical lock
│   │   │   └── ContainerWSStatus       ← WS connection indicator
│   │   ├── ContainersViewModel         ← stream persistence
│   │   ├── ContainersView
│   │   ├── ContainerCard               ← live metric strip
│   │   ├── ContainerCardMetricStrip
│   │   ├── ContainersTabViewModel      ← lazy load images/vol/net
│   │   └── ContainersTabView
│   │
│   ├── 📂 Alerts/                      (20+ fayl)
│   │   ├── 📂 ReusableComponents/
│   │   │   ├── AlertSeverity
│   │   │   ├── AlertFilterType
│   │   │   ├── AlertEvents
│   │   │   └── AlertTimeFormatter
│   │   ├── 📂 ReusableViews/
│   │   │   ├── ProAlertRow             ← glassmorphism alert kart
│   │   │   ├── ProAlertRowGlow / Header / MetricPill / ...
│   │   │   ├── SeverityPill
│   │   │   ├── AlertsSearchBar
│   │   │   └── AlertsFilterRow
│   │   ├── AlertsView
│   │   ├── AlertViewController
│   │   └── AlertViewModel              ← didLoadOnce, 4s refresh
│   │
│   ├── 📂 Logs/                        (20+ fayl)
│   │   ├── LogsView / LogsViewModel
│   │   ├── LogsStreamLogic             ← 1500 limit, 6 retry
│   │   ├── TerminalOutputView
│   │   ├── TerminalLogLine             ← no re-flash on scroll
│   │   ├── TerminalTimestamp / TerminalMessageText
│   │   ├── LogFlashOverlay / BlinkingCursor
│   │   ├── LogLevel / LogLevelBadge / LogLevelChip
│   │   ├── ContainerPickerView
│   │   └── StreamStatusBadge
│   │
│   └── 📂 Settings/                    (25+ fayl)
│       ├── SettingsView / SettingsViewModel ← deinit cancel
│       ├── ServerCardView / ServerSetupSheetView
│       ├── NotificationsCardView
│       ├── AlertFlowCardView           ← CPU threshold slider
│       ├── AlertEmailCardView
│       ├── SignOutCardView
│       ├── FlowConnectorView           ← animated connection diagram
│       ├── ConnectionStatusCapsule
│       └── PrettyHostFormatter
│
├── 📂 Network Layer/
│   ├── 📂 Endpoint/
│   │   ├── LumenService                ← protocol
│   │   ├── RealLumenService            ← REST implementation
│   │   └── PocketLumenEndpoint         ← URL builder
│   ├── 📂 Mock/
│   │   ├── MockStatsHub                ← sin-wave + spike engine
│   │   ├── MockLumenService
│   │   ├── MockLogsHub
│   │   ├── MockData                    ← threshold-uyğun test data
│   │   └── MockWebSocketClient
│   └── 📂 WebSocket/
│       ├── StatsStreaming              ← protocol
│       ├── StatsWebSocketService
│       ├── StatsStreamViewModel        ← 350ms delay, cache
│       ├── StatsCache / CachedStatsEnvelope
│       ├── AlertSeverityHelper         ← cpuHigh=20%, cpuMedium=12%
│       ├── DateParser                  ← nanosecond fix
│       ├── DefaultWebSocketClient
│       ├── WebSocketBackoff            ← exponential retry
│       ├── LogsStreaming / LogsWebSocketService
│       ├── LocalThresholdStore         ← UserDefaults wrapper
│       └── WSRoute / WebSocketState
│
├── 📂 MainTabBar/
│   └── MainTabBarController
│
└── 📂 DesignSystem/
    ├── DS+Color / DS+Font
    ├── DS+Space / DS+Radius / DS+Anim
    └── AppEnvironment                  ← Mock ↔ Real switch
```

---

## 🚀 Quraşdırma

### Tələblər

```
✅  Xcode 15.0+
✅  iOS 17.0+ simulator və ya device
✅  Swift 5.9+
✅  CocoaPods (Firebase üçün)
```

### Addım-addım

```bash
# 1. Repo klonla
git clone https://github.com/username/lumen-ios.git
cd lumen-ios

# 2. Pod-ları yüklə
pod install

# 3. Workspace aç (xcworkspace — xcodeproj DEYİL!)
open "Final Project.xcworkspace"

# 4. Firebase konfiqurasiyası
# GoogleService-Info.plist faylını
# Final Project/ qovluğuna əlavə et

# 5. Build & Run  →  ⌘R
```

### Mock Mode — şəbəkəsiz test

```
DEBUG build → MockLumenService + MockStatsHub avtomatik aktiv
Heç bir server, heç bir konfiqurasiya tələb olunmur ✅
Simulator-da birbaşa işlədilir ✅
```

---

## 🛠️ Tech Stack

| Texnologiya | İstifadə |
|-------------|---------|
| **Swift 5.9** | Əsas proqramlaşdırma dili |
| **SwiftUI 5.0** | Bütün UI komponentlər |
| **UIKit** | Tab navigation layer (push/pop) |
| **Swift Concurrency** | async/await, AsyncThrowingStream |
| **URLSessionWebSocketTask** | Native WebSocket (no 3rd party) |
| **Firebase Auth** | İstifadəçi autentifikasiyası |
| **Combine** | Settings auto-save debounce |
| **UserDefaults** | CPU threshold, preferences |
| **NotificationCenter** | Container refresh cross-view signal |

---

## 📊 Performance Göstəriciləri

```
WebSocket streams    →  hər konteyner üçün 1 stream (1s interval)
Chart history        →  40 nöqtə / konteyner (≈ 1.5 dəqiqə)
Dashboard recalc     →  hər 2s (exponential smoothing ilə)
Alert auto-refresh   →  hər 4s
Container sync       →  hər 15s (yeni konteyner kəşfi)
Log buffer limit     →  max 1500 sətir
WS reconnect         →  max 6 cəhd, backoff 1s→2s→4s→8s→max 30s
Skeleton loading     →  ContainerCardSkeleton + ContainersSkeletonList
```

---

## 🧑‍💻 Kritik Dizayn Qərarları

**1. CPU faiz formatı** — Real backend `cpuUsage: 22.58` göndərir. Bu **22.58% CPU**-dur, 0.2258 fraction deyil. `normalizeToPercent()` yalnız `clamp(0, 100)` edir, `×100` etmir.

**2. Stream persistence** — `ContainersViewModel.onDisappear()` streamTask-ları öldürmür. Bunu etmək container detail-dən geri gəldikdə 1–2s "Connecting..." vəziyyəti yaradırdı.

**3. didLoadOnce pattern** — Tab keçidlərində `onAppear` yenidən çağırılır. `didLoadOnce` flag ilk yükləmədən sonra şəbəkə requestini bloklayır.

**4. Hysteresis** — Score 20%-ə çatanda Critical, amma 19.5%-ə düşəndə dərhal Normal olmur. Exit threshold 15%-dir. Beləliklə 19.5–20% aralığında score titrəmir.

**5. nonisolated deinit** — `DashboardCoordinator` class-level `@MainActor` daşımır. Hər metod ayrıca annotasiya daşıyır. Bu `deinit`-dən `cancelAllTasks()` çağırmasını mümkün edir.

---

<div align="center">

<br/>

**Lumen** — *Cibinizdəki data center.*

⭐ Layihəni bəyəndinizsə star vurun!

<br/>

Made with ❤️ and Swift · Bakı, Azərbaycan 🇦🇿

</div>
