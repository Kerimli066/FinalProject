<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0A84FF,50:5E5CE6,100:30D158&height=300&section=header&text=LUMEN&fontSize=110&fontColor=ffffff&fontAlignY=42&desc=Professional%20Docker%20Infrastructure%20Monitor%20for%20iOS&descAlignY=62&descSize=22&descColor=ffffffcc&animation=fadeIn" width="100%"/>

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

> ### 🌟 *"Your entire data center, right in your pocket."*
> **Lumen** is a fully native iOS application built for DevOps engineers, SREs, and system administrators  
> who demand real-time visibility and full control over their Docker infrastructure — from anywhere.

<br/>

</div>

---

<br/>

## 🧭 Table of Contents

| 🔗 | 🔗 |
|---|---|
| [🌟 About](#-about) | [✨ Features](#-features) |
| [🏗️ Architecture](#️-architecture) | [⚡ Dashboard & Health Score](#-dashboard--health-score) |
| [🐳 Container Management](#-container-management) | [🚨 Alert System](#-alert-system) |
| [📜 Live Logs](#-live-logs) | [⚙️ Settings](#️-settings) |
| [🔌 Network Layer](#-network-layer) | [🧪 Mock Backend](#-mock-backend) |
| [🎨 Design System](#-design-system) | [📁 Project Structure](#-project-structure) |
| [🚀 Installation](#-installation) | [🛠️ Tech Stack](#️-tech-stack) |

<br/>

---

<br/>

## 🌟 About

**Lumen** is a professional-grade Docker monitoring application built entirely from scratch for iOS. It connects directly to your Docker backend via WebSocket streams, opens a dedicated real-time channel per container, calculates infrastructure health using a hysteresis-based scoring engine, and delivers instant alerts when critical thresholds are breached — all in pure, native SwiftUI with zero third-party UI dependencies.

Lumen is not just a dashboard. It is a complete infrastructure observability tool designed to feel as fast and reliable as the servers it monitors.

<br/>

<div align="center">

| 👩‍💻 Developer | 📅 Started | 🏙️ Location | 🎯 Platform | 🔐 Auth |
|:---:|:---:|:---:|:---:|:---:|
| Sabina Karimli | February 2026 | Baku, Azerbaijan 🇦🇿 | iPhone · iOS 17+ | Firebase |

</div>

<br/>

---

<br/>

## ✨ Features

<br/>

<table>
<tr>
<td width="50%" valign="top">

### 🖥️ Real-Time Dashboard
A full-screen infrastructure overview that updates every second. Animated Health Score Ring, interactive multi-line charts, top resource consumers, and a live alert panel — everything visible at a single glance without scrolling.

</td>
<td width="50%" valign="top">

### 🐳 Container Management
Live metric cards for every running container. CPU percentage, memory usage, and network traffic update in real time via dedicated WebSocket streams. Tap any container to view environment variables, port mappings, and volume mounts.

</td>
</tr>
<tr>
<td width="50%" valign="top">

### 🚨 Smart Alert System
Severity-based alerting with automatic refresh. Glassmorphism-styled alert cards display the container name, severity level, CPU/memory values, and a relative timestamp. Filter by severity or search by container name instantly.

</td>
<td width="50%" valign="top">

### 📜 Live Log Streaming
A terminal-style real-time log viewer with nanosecond-precision timestamps, log level filtering, auto-scroll, and a line flash animation on every new entry. Supports continuous streaming with automatic reconnection.

</td>
</tr>
<tr>
<td width="50%" valign="top">

### ⚙️ Flexible Settings
Adjustable CPU alert threshold, server URL configuration with connection testing, notification toggle, Firebase email verification display, and secure sign-out — all with auto-save debounce.

</td>
<td width="50%" valign="top">

### 🧪 Offline Mock Mode
A full simulation environment for development and testing. Runs entirely without a server — realistic container behavior, spike simulation, alerts, and log streams all active automatically in DEBUG builds.

</td>
</tr>
</table>

<br/>

---

<br/>

## 🏗️ Architecture

Lumen is built on **MVVM + Coordinator** pattern. A UIKit navigation layer embeds SwiftUI views via `UIHostingController`, combining the declarative power of SwiftUI with the navigation reliability of UIKit.

<br/>

<div align="center">

```
┌──────────────────────────────────────────────────────┐
│              UIKit Navigation Layer                  │
│           MainTabBarController                       │
│   Dashboard · Containers · Alerts · Logs · Settings  │
└────────────────────┬─────────────────────────────────┘
                     │  UIHostingController
┌────────────────────▼─────────────────────────────────┐
│                SwiftUI Views                         │
│                                                      │
│  DashboardView ──── DashboardViewModel               │
│        │                  │                          │
│        │          DashboardCoordinator               │
│        │          ├── snapshotTimer   (4s)           │
│        │          ├── alertTimer      (20s)          │
│        │          ├── containerTimer  (15s)          │
│        │          └── streamTasks     (per WS)       │
│        │                                             │
│  ContainersView ─── ContainersViewModel              │
│        └── ContainerCard × N  ← live metric strips  │
│               └── ContainerDetailView               │
│                      └── StatsStreamViewModel       │
│                                                      │
│  AlertsView · LogsView · SettingsView                │
└────────────────────┬─────────────────────────────────┘
                     │
┌────────────────────▼─────────────────────────────────┐
│                 Service Layer                        │
│                                                      │
│  LumenService (protocol)                             │
│  ├── RealLumenService    →  REST API                 │
│  └── MockLumenService    →  Simulated responses      │
│                                                      │
│  StatsStreaming (protocol)                           │
│  ├── RealStatsHub        →  WebSocket streams        │
│  └── MockStatsHub        →  Sin-wave + spike engine  │
└──────────────────────────────────────────────────────┘
```

</div>

<br/>

### 🧩 Core Architectural Decisions

| 🔑 Pattern | 📍 Where | 💡 Why |
|---|---|---|
| `@MainActor` | All ViewModels | Guarantees thread-safe UI updates |
| `AsyncThrowingStream` | Stats streaming | Structured Swift concurrency |
| `didLoadOnce` flag | AlertVM, DetailVM | Prevents duplicate network requests on tab switch |
| `didStartOnce` flag | DashboardVM | Prevents double-start on tab reappear |
| Hysteresis thresholds | HealthScoreCalculator | Eliminates score flickering at threshold boundaries |
| Exponential smoothing α=0.3 | DashboardVM | Produces smooth, animated health score transitions |
| Protocol-based services | LumenService, StatsStreaming | Seamless Mock ↔ Real swap |
| Coordinator pattern | DashboardCoordinator | Centralized timer and stream lifecycle management |
| Stream persistence | ContainersViewModel | WebSocket streams survive navigation push/pop |
| Optimistic UI updates | Container actions | Zero perceived latency for user interactions |

<br/>

---

<br/>

## ⚡ Dashboard & Health Score

The Dashboard is Lumen's most sophisticated component. It combines three independent techniques to produce a health score that is both accurate and visually stable.

<br/>

### 🏥 Penalty-Based Scoring

Every 2 seconds, metrics from all active containers are collected. The **maximum** CPU value across all containers drives the penalty calculation — not the average — because a single runaway container can destabilize an entire system. The score starts at 100 and penalties are subtracted:

<br/>

<div align="center">

| 🚦 Condition | ⬇️ Base Penalty | ➕ Extra | 🔝 Max |
|:---|:---:|:---:|:---:|
| 🔴 CPU ≥ critical threshold | −15 | −1 per extra 5% | −40 |
| 🟠 CPU ≥ high threshold | −10 | −1 per extra 6% | −20 |
| 🟡 Average CPU moderately elevated | −5 | — | — |
| 🔵 Average CPU slightly elevated | −2 | — | — |
| 🔴 Memory ≥ 80% | −10 (proportional) | — | −20 |
| 🟠 Memory ≥ 60% | −5 (proportional) | — | −12 |
| 🚨 Each critical active alert | −5 | — | −20 |
| ⛔ Each stopped container | −3 | — | −12 |

</div>

<br/>

### 🔀 Hysteresis — Eliminating Score Flutter

Without hysteresis, a container hovering near a threshold would cause the health score to oscillate every second — a terrible user experience. Enter and exit thresholds are deliberately separated to create a stable buffer zone:

<br/>

<div align="center">

| 📊 Metric | 🔴 Enter (penalty applied) | 🟢 Exit (penalty released) | 🛡️ Buffer Zone |
|:---|:---:|:---:|:---:|
| CPU Critical | ≥ 20% | < 15% | 15% – 20% |
| CPU High | ≥ 12% | < 8% | 8% – 12% |
| Memory Critical | ≥ 80% | < 70% | 70% – 80% |
| Memory High | ≥ 60% | < 50% | 50% – 60% |

</div>

<br/>

### 📈 Exponential Smoothing — Fluid Animation

The calculated target score is not displayed immediately. The previous score carries 70% weight while the new target carries 30% (α = 0.3). This produces a smooth, visually pleasing transition instead of an abrupt jump, and keeps the HealthScoreRing animation perfectly in sync.

<br/>

### 🎨 Health Status Levels

<div align="center">

| 💯 Score Range | 🏷️ Status | 🎨 Color | 💬 Meaning |
|:---:|:---:|:---:|:---|
| 70 – 100 | ✅ Healthy | 🟢 Green | System is stable, no critical issues detected |
| 40 – 69 | ⚠️ Warning | 🟡 Yellow | Elevated resource usage, attention recommended |
| 0 – 39 | 🚨 Critical | 🔴 Red | Immediate action required |

</div>

<br/>

### ⏱️ Dashboard Timer Orchestra

The Dashboard runs four independent background timers, all managed by `DashboardCoordinator`:

<br/>

<div align="center">

| ⏰ Timer | 🔄 Interval | 📋 Responsibility | 🎯 Effect |
|:---|:---:|:---|:---|
| 📸 snapshotTimer | 4 seconds | Appends a point to global chart history | Charts update in real time |
| 🚨 alertTimer | 20 seconds | Fetches latest alerts from API | Dashboard alert panel refreshes |
| 🐳 containerTimer | 15 seconds | Discovers new containers, reconciles streams | New streams open automatically |
| 🔢 recalcTimer | 2 seconds | Recalculates aggregates and health score | Ring and metric cards update |

</div>

<br/>

### 📊 Interactive Charts

<div align="center">

| 📈 Tab | 📊 Chart Type | 📋 What It Shows |
|:---|:---:|:---|
| 🖥️ CPU Contribution | Multi-series line | Individual CPU usage per container |
| 📉 CPU Trend | Aggregated line | Total infrastructure CPU over time |
| 💾 Memory Trend | Aggregated line | Total infrastructure memory over time |

</div>

Each chart maintains a rolling buffer of 40 data points per container, appended every 2.5 seconds — approximately 1.5 minutes of live history. Touch any point on the chart to reveal a precise tooltip.

<br/>

---

<br/>

## 🐳 Container Management

### 🔄 Stream Lifecycle — The Critical Design Decision

The most important architectural decision in the container system: **WebSocket streams persist across navigation**. Previously, every `onDisappear` killed all streams. Navigating back from the detail view caused 1–2 seconds of blank cards while streams reconnected — a poor experience. The current approach:

<br/>

<div align="center">

| 📍 Event | 📥 loadTask | 📡 streamTasks | 💡 Result |
|:---|:---:|:---:|:---|
| 🟢 `onAppear()` | 🔄 Refreshed | ✅ Untouched | Cards show live CPU immediately on return |
| 🔴 `onDisappear()` | ❌ Cancelled | ✅ Kept alive | Streams survive navigation push/pop |
| 🔁 `refresh()` | 🔄 Refreshed | 🔄 Full reset | Pull-to-refresh reloads everything |
| ⏱️ `containerTimer` | — | 🔄 Reconciled | New containers get streams; removed ones lose them |

</div>

<br/>

### ⚡ Container Actions

All container operations use **optimistic UI updates** — the interface responds immediately without waiting for the server. If the server returns an error, the UI rolls back gracefully.

<br/>

<div align="center">

| 🎮 Action | ⚡ Optimistic Update | 🔒 System Lock | 📋 Notes |
|:---|:---:|:---:|:---|
| ▶️ Start | Immediately shows "running" 🟢 | — | — |
| ⏹️ Stop | Immediately shows "exited" ⚫ | 🔒 Blocked for critical containers | Critical banner displayed |
| 🔄 Restart | Immediately shows "running" 🟢 | 🔒 Blocked for critical containers | Critical banner displayed |
| 🗑️ Remove | Confirmation dialog required | 🔒 Blocked for critical containers | Irreversible action |

</div>

<br/>

### 🃏 ContainerCard Anatomy

<div align="center">

| 🧩 Component | 📋 Responsibility |
|:---|:---|
| 🎨 `ContainerCardBackground` | Glassmorphism background with severity-aware glow |
| 🖼️ `ContainerCardAvatar` | Color-coded container type icon |
| 📛 `ContainerCardNameBlock` | Container name and image tag |
| 🔴 `ContainerStateBadge` | running / exited / paused status badge |
| 📊 `ContainerCardMetricStrip` | Real-time CPU% and Memory% progress bars |
| 🌐 `ContainerCardNetworkCell` | Download ↓ / Upload ↑ in bytes |
| 💀 `ContainerCardSkeleton` | Animated loading placeholder |

</div>

<br/>

---

<br/>

## 🚨 Alert System

### 🎯 Severity Thresholds

Alert thresholds are centralized in `AlertSeverityHelper` and linked to the user-adjustable CPU threshold in Settings. Changing the slider immediately propagates the new value across the entire alert system — no restart required.

<br/>

<div align="center">

| 🚦 Severity | 🖥️ CPU Condition | 💾 Memory Condition | 🎨 Visual |
|:---|:---:|:---:|:---:|
| 🔴 Critical | ≥ configured high threshold | ≥ 80% | Red glow |
| 🟠 High | ≥ configured medium threshold | ≥ 60% | Orange glow |
| 🟡 Medium | Below high threshold | Below 60% | Yellow glow |

</div>

<br/>

### 🃏 ProAlertRow — Alert Card Anatomy

Every alert is rendered as a `ProAlertRow`, composed of 8 isolated sub-components. This decomposition keeps each visual element independently testable and reusable:

<br/>

<div align="center">

| 🧩 Component | 📋 Responsibility |
|:---|:---|
| 🫧 `ProAlertRowCardBackground` | Glassmorphism card surface |
| ✨ `ProAlertRowGlow` | Ambient glow matching the severity color |
| 📏 `ProAlertRowLeftBar` | Colored severity indicator bar on the left edge |
| 🖼️ `ProAlertRowIcon` | Container type icon |
| 📛 `ProAlertRowHeader` | Container name + SeverityPill badge |
| 💬 `ProAlertRowMessage` | Human-readable alert description |
| 💊 `ProAlertRowMetricPill` | CPU% and Memory% values at time of alert |
| 🕐 `ProAlertRowTime` | Relative timestamp ("2 minutes ago") |

</div>

<br/>

---

<br/>

## 📜 Live Logs

### 🖥️ Terminal Components

The Logs screen replicates the look and feel of a real terminal session. Every visual element is an independent SwiftUI component:

<br/>

<div align="center">

| 🧩 Component | 📋 Responsibility |
|:---|:---|
| ⌨️ `BlinkingCursor` | Animated blinking cursor in the top-left corner |
| 🔢 `TerminalLineNumber` | Fixed left-column line numbers |
| 🕐 `TerminalTimestamp` | Nanosecond-precision date and time |
| 🏷️ `LogLevelBadge` | DEBUG / INFO / WARN / ERROR colored badge |
| 📝 `TerminalMessageText` | Level-colored log message text |
| ✨ `LogFlashOverlay` | Brief highlight flash on each new incoming line |
| ➖ `TerminalSeparator` | Thin divider between log lines |
| 📊 `LineCountPill` | Current line count in the buffer |
| 🟢 `StreamStatusBadge` | Connected / Connecting / Error indicator |

</div>

<br/>

### 📊 Stream Parameters

<div align="center">

| ⚙️ Parameter | 📊 Value | 💡 Rationale |
|:---|:---:|:---|
| 🗂️ Max buffer size | 1,500 lines | Balances performance with sufficient history |
| 🔁 Max reconnect attempts | 6 | Prevents infinite retry loops |
| ⏱️ Retry strategy | Exponential backoff | Avoids overwhelming a recovering server |
| 🕐 Timestamp precision | Nanoseconds (9 digits) | Full compatibility with Docker log format |
| 💡 Re-flash on scroll | Disabled | Previously seen lines do not re-animate |

</div>

<br/>

### 🔵 Log Level System

<div align="center">

| 🏷️ Level | 🎨 Color | 📋 Usage |
|:---:|:---:|:---|
| 🔵 DEBUG | Blue | Development tracing and diagnostic information |
| ⚪ INFO | White | Normal operational events |
| 🟡 WARN | Yellow | Conditions that deserve attention |
| 🔴 ERROR | Red | Failures and unexpected errors |

</div>

<br/>

---

<br/>

## ⚙️ Settings

### 🎚️ CPU Threshold Slider

The CPU threshold slider is one of Lumen's most powerful features. Dragging it from 1% to 99% does two things simultaneously: it persists the value to `UserDefaults` and immediately updates the global threshold inside `AlertSeverityHelper`. The entire alert system adapts in real time — no restart, no confirmation, zero friction.

<br/>

### 🖥️ Server Configuration

Opening the Server Setup sheet reveals an animated `FlowConnectorView` that visually represents the data flow from your phone to the Docker host. The `ConnectionStatusCapsule` displays a color-coded badge the moment the connection test completes. `PrettyHostFormatter` sanitizes and formats the entered URL into a clean, readable string.

<br/>

### 🔔 Notifications

The Notifications card and CPU threshold slider are intentionally placed together inside `AlertFlowCardView`. This layout lets users see at a glance exactly which threshold triggers notifications and adjust both settings in the same interaction.

<br/>

### 💾 Auto-Save

Every change in Settings is debounced by 800 milliseconds before writing to disk. Rapidly dragging the slider does not trigger a save on every frame — only after the user pauses. The `autoSaveTask` is cancelled in `deinit`, guaranteeing no memory leaks or orphaned background writes.

<br/>

---

<br/>

## 🔌 Network Layer

### 🌐 REST API Endpoints

<div align="center">

| 🔧 Method | 🔗 Endpoint | 📋 Description |
|:---:|:---|:---|
| 🟢 `GET` | `/containers` | Full list of all containers |
| 🟢 `GET` | `/containers/:id` | Single container detail (env, ports, mounts) |
| 🟡 `POST` | `/containers/:id/start` | Start a stopped container |
| 🟡 `POST` | `/containers/:id/stop` | Stop a running container |
| 🟡 `POST` | `/containers/:id/restart` | Restart a container |
| 🔴 `DELETE` | `/containers/:id` | Permanently remove a container |
| 🟢 `GET` | `/images` | All Docker images |
| 🟢 `GET` | `/volumes` | All Docker volumes |
| 🟢 `GET` | `/networks` | All Docker networks |
| 🟢 `GET` | `/alerts` | Complete alert history |
| 🔴 `DELETE` | `/alerts` | Clear all alert history |

</div>

<br/>

### 📡 WebSocket Stats Payload

A JSON message arrives from `ws://{host}/stats?containerId={id}` approximately once per second:

<br/>

<div align="center">

| 📦 Field | 🔢 Type | 📋 Description | ⚠️ Note |
|:---|:---:|:---|:---|
| `cpuUsage` | Double | CPU percentage | **22.58 means 22.58%** — not a fraction |
| `memoryUsage` | Int | Memory in use | Bytes |
| `memoryLimit` | Int | Memory ceiling | Bytes |
| `memoryPercent` | Double | Memory percentage | 0.0 – 100.0 |
| `networkRx` | Int | Bytes received | — |
| `networkTx` | Int | Bytes transmitted | — |

</div>

<br/>

> ⚠️ **Important:** `cpuUsage` is always in percentage format. `normalizeToPercent()` only applies `clamp(0, 100)` — there is no multiplication. Multiplying by 100 would turn `22.58%` into `2258%`.

<br/>

### 🔌 WebSocket Stack Components

<div align="center">

| 🧩 Component | 📋 Responsibility |
|:---|:---|
| 🔗 `DefaultWebSocketClient` | Native wrapper around `URLSessionWebSocketTask` |
| 🔁 `WebSocketBackoff` | Exponential retry: 1s → 2s → 4s → 8s → max 30s |
| 💾 `StatsCache` | Caches the most recent stats in `CachedStatsEnvelope` |
| 🕐 `DateParser` | Trims 9-digit nanosecond timestamps to standard ISO 8601 |
| 📡 `StatsStreamViewModel` | 350ms startup delay so the detail view animation completes first |
| 🗺️ `WSRoute` | Centralizes all WebSocket URL construction |
| 📊 `WebSocketState` | Enum: connecting / connected / disconnected / error |

</div>

<br/>

---

<br/>

## 🧪 Mock Backend

Lumen ships with a complete simulation environment that activates automatically in `DEBUG` builds. No server, no configuration, no network required. Everything mirrors the exact format of the real backend.

<br/>

### 🌊 Sin-Wave + Spike Engine

`MockStatsHub` assigns every container a unique behavioral profile. CPU values oscillate on a sine wave with added random noise. Occasionally, a spike multiplier kicks in to simulate a sudden load surge:

**CPU = baseCPU + amplitude × sin(phase) + noise + (if spike: baseCPU × spikeMult)**

The result is clamped to a valid percentage range, producing realistic, continuously varying metrics that exercise every part of the UI.

<br/>

### 🧪 Container Behavior Categories

<div align="center">

| 🏷️ Category | 📊 CPU Behavior | ⚡ Spike Behavior | 🚦 Severity Impact |
|:---|:---|:---|:---:|
| 🔴 **Always Critical** | Persistently high CPU | No spikes needed | Critical at all times |
| 🟠 **Spike to High** | Normal CPU baseline | Occasional spikes push above high threshold | High during spikes |
| 🟠 **Spike to Critical** | Low CPU baseline | Rare, intense spikes breach critical threshold | Critical during spikes |
| 🟢 **Always Normal** | Low, stable CPU | No spikes | Healthy at all times |
| 💾 **Memory Heavy** | Low CPU, high RAM | Occasional memory spikes | Warning on memory |

</div>

<br/>

### 🔁 Environment Switch

The switch between real and mock services is handled by a single compile-time flag. No code change is required — just build for `DEBUG` or `Release`:

<br/>

<div align="center">

| 🏗️ Build Configuration | 🔧 LumenService | 📡 StatsStreaming |
|:---:|:---:|:---:|
| 🧪 DEBUG | `MockLumenService` | `MockStatsHub` |
| 🚀 Release | `RealLumenService` | `RealStatsHub` |

</div>

<br/>

---

<br/>

## 🎨 Design System

Every visual constant in Lumen lives inside the `DS` namespace. There are no magic numbers scattered across the codebase — every padding, radius, color, and animation duration is defined once and referenced everywhere.

<br/>

<div align="center">

<table>
<tr>
<td width="50%" valign="top">

**🎨 Colors**

| Token | Role |
|---|---|
| `DS.Color.accent` | Primary blue — interactive elements |
| `DS.Color.danger` | Critical red — errors and alerts |
| `DS.Color.warning` | Amber — warnings and caution |
| `DS.Color.success` | Green — healthy states |
| `DS.Color.bg0 – bg4` | Layered background hierarchy |
| `DS.Color.textPrimary` | Main readable text |
| `DS.Color.textSecondary` | Supporting text |
| `DS.Color.textMuted` | Dimmed, de-emphasized text |

</td>
<td width="50%" valign="top">

**⚙️ Spacing, Radius & Animation**

| Token | Value |
|---|---|
| `DS.Space.xs` | 4 pt |
| `DS.Space.sm` | 8 pt |
| `DS.Space.md` | 12 pt |
| `DS.Space.lg` | 16 pt |
| `DS.Space.xl` | 24 pt |
| `DS.Space.xxl` | 32 pt |
| `DS.Anim.fast` | easeOut · 0.15s |
| `DS.Anim.smooth` | easeInOut · 0.35s |
| `DS.Anim.spring` | response 0.4 · damping 0.75 |

</td>
</tr>
</table>

</div>

<br/>

### 🧩 Reusable Component Library

`GlassCard` · `NeonBadge` · `ProStatCard` · `ProCountCard` · `MiniSparkline` · `HealthScoreRing` · `LumenProgressBar` · `CircularProgress` · `SkeletonRect` · `PulseDot` · `BlinkingCursor` · `SummaryBanner` · `SummaryChip` · `StatusPill` · `SectionHeader` · `DividerLine` · `CenteredEmpty` · `CenteredLoader`

<br/>

<br/>

## 🚀 Installation

### 📋 Requirements

<div align="center">

| 🛠️ Tool | ✅ Minimum Version |
|:---:|:---:|
| 🍎 Xcode | 15.0+ |
| 📱 iOS Deployment Target | 17.0+ |
| 🦅 Swift | 5.9+ |
| 📦 CocoaPods | Latest |

</div>

<br/>

### ⚡ Quick Start

```bash
git clone https://github.com/username/lumen-ios.git
cd lumen-ios
pod install
open "Final Project.xcworkspace"
```

Add your `GoogleService-Info.plist` to the `Final Project/` directory, then press **⌘R** to build and run.

<br/>

### 🧪 Running Without a Server

`DEBUG` builds activate the full mock environment automatically. No configuration, no network, no Docker host required. Simply run the app in the simulator and everything — container streams, alerts, logs, health scoring — works out of the box.

<br/>

### 🌐 Connecting to a Real Docker Host

Open **Settings → Server** and enter your host URL. Tap the connection test button. A green status capsule confirms a successful connection. WebSocket streams open automatically for every discovered container.

<br/>

---

<br/>

## 🛠️ Tech Stack

<div align="center">

| ⚙️ Technology | 📋 Role |
|:---|:---|
| 🦅 **Swift 5.9** | Primary language |
| 🎨 **SwiftUI 5.0** | All UI components — zero third-party UI frameworks |
| 📱 **UIKit** | Tab navigation via `UIHostingController` embedding |
| ⚡ **Swift Concurrency** | `async/await` · `AsyncThrowingStream` · `Task` |
| 🔌 **URLSessionWebSocketTask** | Native WebSocket — no third-party WebSocket library |
| 🔐 **Firebase Auth** | User authentication and email verification |
| 🔗 **Combine** | 800ms auto-save debounce in Settings |
| 💾 **UserDefaults** | CPU threshold and notification preference persistence |
| 📢 **NotificationCenter** | Cross-view container refresh signaling |

</div>

<br/>

---

<br/>

## 📊 Performance

<div align="center">

| 📈 Metric | ⚡ Value | 💡 Notes |
|:---|:---:|:---|
| 🔌 WebSocket update interval | ~1 second | One dedicated stream per container |
| 📊 Chart history buffer | 40 points | Approximately 1.5 minutes of live data |
| 🔢 Dashboard recalculation | Every 2s | With exponential smoothing applied |
| 🚨 Alert refresh interval | Every 4s | Fully automatic |
| 🐳 Container sync interval | Every 15s | Detects new and removed containers |
| 📜 Log buffer limit | 1,500 lines | Hours of streaming without degradation |
| 🔁 WebSocket reconnect limit | 6 attempts | 1s → 2s → 4s → 8s → max 30s backoff |
| ⏱️ StatsStream startup delay | 350ms | Waits for detail view animation to complete |

</div>

<br/>

---

<br/>

## 💡 Key Design Decisions

<br/>

**🔄 Stream Persistence across Navigation** — `onDisappear` does not kill WebSocket streams. Only the `loadTask` is cancelled. This means navigating into a container's detail view and returning shows live metrics instantly — no reconnection delay, no blank cards.

**🔒 didLoadOnce / didStartOnce** — SwiftUI's `onAppear` fires on every tab switch and every navigation push/pop. These flags ensure network requests only happen once per session, preventing redundant API calls and duplicate stream initialization.

**🎯 Hysteresis** — Without enter/exit threshold separation, a container hovering near 20% CPU would cause the health ring to flash between green and red every two seconds. The buffer zones eliminate this entirely.

**🧵 nonisolated deinit** — `DashboardCoordinator` avoids class-level `@MainActor`. Every method carries its own actor annotation. This design allows `cancelAllTasks()` to be called safely from `deinit` — something the Swift compiler prohibits when the entire class is isolated to the main actor.

**⚡ Optimistic Updates** — Container start/stop/restart operations update the UI before waiting for a server response. Users experience zero latency. A rollback mechanism handles the rare case where the server rejects the action.

**📐 Percentage Format Consistency** — The real backend sends `cpuUsage` as a percentage (e.g., `22.58` means 22.58%). `normalizeToPercent()` only clamps to `[0, 100]`. Multiplying by 100 would produce values like `2258%` — a subtle but critical bug that was fixed early in development.

<br/>

---

<br/>

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:30D158,50:5E5CE6,100:0A84FF&height=160&section=footer&text=Made%20with%20%E2%9D%A4%EF%B8%8F%20in%20Baku%2C%20Azerbaijan%20%F0%9F%87%A6%F0%9F%87%BF&fontSize=22&fontColor=ffffff&fontAlignY=55" width="100%"/>

<br/>

**Lumen** — *Your entire data center, right in your pocket.*

<br/>

⭐ If you find this project useful, please consider giving it a star — it means a lot!

<br/>

[![GitHub stars](https://img.shields.io/github/stars/username/lumen-ios?style=social)](https://github.com/username/lumen-ios)
[![GitHub forks](https://img.shields.io/github/forks/username/lumen-ios?style=social)](https://github.com/username/lumen-ios)

<br/>

*Built with Swift · SwiftUI · Baku, Azerbaijan 🇦🇿 · 2026*

</div>
