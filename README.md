# 🍿 Netflix Movies Discovery App

A high-performance, Netflix-inspired movie discovery Flutter application built using **Clean Architecture**, **BLoC (Business Logic Component)** state management, and **TMDB (The Movie Database) API**.

---

## 📱 Features & Highlights

- **✨ Splash & Profile Switcher**: Animated Netflix splash intro routing to a 2×2 profile selection grid (Emenalo, Onyeka, Thelma, Kids + Add Profile).
- **🎬 Dynamic Featured Hero Banner**: Top navigation (`TV Shows`, `Movies`, `My List`), Netflix 'N' logo badge, dynamic TOP 10 ranking badge with movie name, and `Play` / `My List` / `Info` actions.
- **🌀 Circular Previews Rail**: Horizontally scrollable circular preview avatars positioned right above trending movies.
- **🔄 Infinite Scroll & Pagination**: Automatic pagination across all Dashboard rails (`Trending This Week`, `Popular`, `Now Playing`, `Top Rated`) with seamless deduplication.
- **🔍 400ms Debounced Search**: Real-time live movie search with shimmer loading skeletons, error recovery, and empty states.
- **📅 Coming Soon & Notifications Feed**: Live upcoming movie feed with reminder toggle, share actions, dynamic genre pills, and top "New Arrival" notification tiles.
- **📥 Smart Downloads & More Screens**: Figma-matching Downloads UI and More Screen with profile manager, "Tell friends about Netflix" referral card with Copy Link & Social Share (WhatsApp, Facebook, Gmail, More), and settings menu.

---

## 🌐 API-Driven vs. Mock Breakdown

| Feature / Screen | Type | TMDB Endpoint / Implementation Details |
|---|:---:|---|
| **Splash Screen** | 🎭 Mock | Logo scale & fade animation, routes to Profile Selection. |
| **Profile Selection** | 🎭 Mock | 2×2 user profiles (`Rectangle 2-5.png`) with `add.png` button. |
| **Dashboard — Featured Banner** | ⚡ **Live API** | Dynamic TMDB backdrop with TOP 10 badge & live movie title. |
| **Dashboard — Previews Rail** | ⚡ **Live API** | Circular avatars loaded dynamically from TMDB trending movies. |
| **Dashboard — 4 Movie Rails** | ⚡ **Live API** | `/trending/all/week`, `/movie/popular`, `/movie/now_playing`, `/movie/top_rated` with infinite scroll pagination. |
| **Search Screen** | ⚡ **Live API** | `/search/movie` with 400ms query debouncing, live TMDB search. |
| **Coming Soon Screen** | ⚡ **Live API** | `/movie/upcoming` with release date formatting and notification tiles. |
| **Movie Details Screen** | ⚡ **Live API** | Backdrop hero header, metadata, overview, and player mock trigger. |
| **Downloads Screen** | 🎭 Mock | Smart Downloads UI with setup action & "Find Something to Download". |
| **More Screen** | 🎭 Mock | Profile switcher, referral card with copy link & social sharing. |

---

## 🏗️ Architecture Overview

The codebase is organized using **Feature-First Clean Architecture** with strict layer decoupling:

```
lib/
├── core/
│   ├── config/              # Environment config & API keys
│   ├── constants/           # App, API, and Asset constants
│   ├── di/                  # GetIt service locator setup
│   ├── network/             # Dio client, AuthInterceptor, Error handling
│   ├── theme/               # Dark theme, color palette & typography
│   ├── utils/               # Debouncer & helper utilities
│   └── widgets/             # Reusable UI (CachedImage, Shimmer, ErrorView, EmptyView)
└── features/
    ├── splash/              # Splash screen
    ├── profile_selection/   # 2x2 Profile picker
    ├── main_nav/            # Persistent bottom navigation
    ├── dashboard/           # Live API rails, banner, previews, BLoC, models, repo
    ├── search/              # Live API search, BLoC, repo, search cards
    ├── coming_soon/         # Live API upcoming releases, BLoC, notification cards
    ├── movie_details/       # Movie detail screen & backdrop
    ├── watchlist/           # Smart Downloads screen
    └── profile/             # More screen (Profiles, Share, Settings)
```

### Layer Responsibilities
1. **Data Layer (`data/`)**:
   - `models/`: JSON serialization/deserialization classes (`MovieModel`, `MovieResponse`).
   - `datasources/`: Remote HTTP calls via `ApiClient` and query parameters.
   - `repositories/`: Repository implementations mapping raw responses to domain entities.
2. **Domain Layer (`domain/`)**:
   - Abstract repository contracts enforcing clean inversion of control.
3. **Presentation Layer (`presentation/`)**:
   - `bloc/`: Predictable event-driven state management with `flutter_bloc`.
   - `screens/` & `widgets/`: Pure UI components consuming BLoC states with zero business logic.

---

## 📦 Packages Used

| Package | Version | Purpose |
|---|---|---|
| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | `^9.1.1` | Predictable state management across all screens and events. |
| [`dio`](https://pub.dev/packages/dio) | `^5.9.1` | Robust HTTP networking with custom interceptors and query params. |
| [`get_it`](https://pub.dev/packages/get_it) | `^9.2.1` | Dependency injection service locator. |
| [`cached_network_image`](https://pub.dev/packages/cached_network_image) | `^3.4.1` | Efficient image caching and loading for posters & backdrops. |
| [`shimmer`](https://pub.dev/packages/shimmer) | `^3.0.0` | Skeleton loading animations during network calls. |
| [`google_fonts`](https://pub.dev/packages/google_fonts) | `^6.3.3` | Clean Netflix-style Inter typography. |
| [`intl`](https://pub.dev/packages/intl) | `^0.20.2` | Date formatting for upcoming releases and notifications. |
| [`equatable`](https://pub.dev/packages/equatable) | `^2.0.7` | Value equality for immutable BLoC states and events. |
| [`mocktail`](https://pub.dev/packages/mocktail) | `^1.0.4` | Mocking dependencies in automated unit and widget tests. |
| [`bloc_test`](https://pub.dev/packages/bloc_test) | `^10.0.0` | Declarative testing of BLoC states and transitions. |

---

## 🚀 Setup & Installation

### 1. Prerequisites
- **Flutter SDK**: `^3.10.0` (Dart `^3.10.0`)
- **Android Studio** or **VS Code** with Flutter & Dart extensions
- An active Android Emulator or Physical Device

### 2. Clone and Install Dependencies
```bash
git clone <repository-url>
cd movies_app
flutter pub get
```

### 3. How to Configure the TMDB API Key

The application has fallback keys pre-configured in `lib/core/config/environment_config.dart`. To configure your own TMDB credentials:

#### Option A: Local Key File (Recommended for Local Dev)
Create a file at `lib/core/config/env_keys.dart`:
```dart
class EnvKeys {
  static const String tmdbApiKey = 'YOUR_TMDB_API_KEY';
  static const String tmdbApiReadAccessToken = 'YOUR_TMDB_READ_ACCESS_TOKEN';
}
```

#### Option B: Via Dart Define Command Line Flags
```bash
flutter run --dart-define=TMDB_API_KEY=your_api_key --dart-define=TMDB_ACCESS_TOKEN=your_token
```

---

## ⚠️ Important: TMDB Network Access & VPN Requirement

> [!IMPORTANT]
> **TMDB API Connection & VPN Usage**:
> Depending on your location and Internet Service Provider (ISP), direct connections to `api.themoviedb.org` and `image.tmdb.org` may be throttled or blocked by regional firewalls / ISP DNS filters (resulting in `DioException [connection timeout]` or `SocketException`).
>
> **If movie data or images fail to load on your emulator/device**:
> 1. **Enable a VPN** on your development machine, emulator, or physical device.
> 2. Alternatively, configure **Android Private DNS** under *Settings → Network & Internet → Private DNS* to `1dot1dot1dot1.cloudflare-dns.com` or `dns.google`.

---

## 🧪 Running Tests & Quality Checks

Run all automated unit and widget test suites:
```bash
flutter test
```

Run static analysis to verify zero lint or type errors:
```bash
flutter analyze
```

---

## 📱 Running the Application

```bash
flutter run
```
