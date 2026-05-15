# 🚚 Delivery Smart Care

A Flutter-based delivery management system that allows delivery drivers to manage orders, track deliveries in real-time, and navigate efficiently between locations.

## Getting Started

---

This project is a starting point for a Flutter delivery application.

## 📌 Prerequisites and Dependencies

A few resources to get you started if this is your first Flutter project:

### 🧠 Programming Language

* Dart SDK: `^3.11.0`

### 📱 Framework

* Flutter SDK (latest stable version)

---

## 📦 Main Dependencies

* **State Management**

  * `flutter_bloc`

* **Networking**

  * `dio`

* **Functional Programming**

  * `dartz`

* **Secure Storage**

  * `flutter_secure_storage`

* **Maps & Location**

  * `google_maps_flutter`
  * `geolocator`
  * `location`

* **UI / UX**

  * `google_fonts`
  * `flutter_svg`
  * `flutter_advanced_drawer`

* **Utilities**

  * `intl`
  * `url_launcher`

---

## 💻 Required Software

* Flutter SDK
* Android Studio or VS Code
* Android SDK
* Git

---

## 🖥 System Requirements

* OS: Windows / macOS / Linux
* RAM: 8GB minimum (16GB recommended)
* Storage: 5GB free space

---

## 🌐 External Services

* REST APIs (used for authentication, orders, delivery tracking, and maps)

---

## ⚙️ Installation Steps

### 1. Clone the repository

```bash
git clone https://github.com/your-repo/delivery-smartcare.git
cd delivery-smartcare
```

---

### 2. Install dependencies

```bash
flutter pub get
```

---

### 3. Configure Environment

Update API base URL inside:

```text
lib/core/api/
```

Example:

```dart
static const String baseUrl = "https://your-api-url.com/";
```

---

## 🧱 Compilation Steps

### Build APK

```bash
flutter build apk --release
```

### Build App Bundle

```bash
flutter build appbundle
```

---

## 🚀 Run Instructions

### Run the app

```bash
flutter run
```

### Run on specific device

```bash
flutter devices
flutter run -d <device_id>
```

---

## 🔧 Environment Setup & Configuration

### 1. Verify Flutter installation

```bash
flutter doctor
```

---

### 2. API Configuration

Make sure backend is running and API URL is correctly set.

---

### 3. Permissions (Android)

Add to `AndroidManifest.xml` if needed:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

---

## 📂 Project Structure

```text
lib/
 ├── core/
 │    ├── api/
 │    ├── services/
 │    ├── styles/
 │    ├── widgets/
 │    ├── app_color.dart
 │    └── app_theme.dart
 │
 ├── features/
 │    ├── auth/
 │    ├── home/
 │    ├── orders/
 │    ├── tracking/
 │    ├── maps/
 │    └── splash/
 │
 └── main.dart
```

---

## 🧠 Architecture

* Feature-based structure
* Bloc state management
* Clean architecture
* API-driven using Dio

---

## 📌 Features

* 🔐 Authentication
* 🏠 Home Screen
* 🛒 Orders Management
* 📍 Live Tracking
* 🗺 Google Maps Integration
* 🚚 Delivery Status Updates


---

## 📄 License

This project is for educational purposes.
