# Minimal Flutter App

A polished **minimal Flutter app** demonstrating smooth **Hero transitions**, **animated service cards**, **favorite toggling**, and a **detail screen** with scrollable content. The app uses **Provider** for state management and follows **Material 3** design principles.

---

## Features

* **Animated Service Cards**

  * Gradient background, shadow, and rounded corners.
  * Smooth Hero transitions to detail screen.

* **Detail Screen**

  * Hero transition for selected card.
  * Scrollable content with "About" and "Reviews" sections.
  * Actionable buttons: Book & Favorite.

* **Favorites Management**

  * Toggle favorite status using Provider.
  * Animated icon updates on toggle.

* **Responsive Design**

  * Prevents RenderFlex overflow errors on different screen sizes.
  * Scrollable content for smaller devices.

---

## Project Structure

```
lib/
├─ models/
│  └─ item.dart              # Model class for services/items
├─ providers/
│  └─ app_state.dart         # App state and favorite management
├─ screens/
│  ├─ home_screen.dart       # Home screen with list/grid of services
│  └─ detail_screen.dart     # Detail screen for each service
├─ widgets/
│  └─ service_card.dart      # Animated card widget
└─ main.dart                 # Entry point of the app
```

---

## Dependencies

* **flutter**: >=3.0.0
* **provider**: ^6.0.0

Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
```

---

## Getting Started

1. **Clone the repository:**

```bash
git clone <repository-url>
cd minimal_flutter_app
```

2. **Install dependencies:**

```bash
flutter pub get
```

3. **Run the app:**

```bash
flutter run
```

---

## How to Use

* Tap on a **Service Card** to navigate to the **Detail Screen** with Hero animation.
* Click **Book** to simulate a booking action.
* Tap **Heart Icon** to toggle favorite status.
* Scroll down in the detail screen to see "About" and "Reviews".

---

## Notes

* Designed to prevent **RenderFlex overflow errors**.
* Works on **both Android and iOS** devices.
* Uses **Material 3** design and **light/dark themes**.

---

## License
Rajdeep Kumar


