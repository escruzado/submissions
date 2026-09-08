# Submissions

A Flutter admin application for managing and reviewing form submissions

## Overview

Submissions is a frontend-only Flutter application that displays, filters, and manages form submission records loaded from a local JSON data source. Built using Riverpod for state management.

---

## Setup and Run Instructions

### Prerequisites
- Flutter SDK 3.x (stable channel)
- Android Studio or VS Code with Flutter and Dart plugins
- Android emulator (Pixel device recommended) or physical Android device

### Steps

1. Clone the repository
```bash
git clone <repository-url>
cd submissions
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

4. To run on a specific device
```bash
flutter devices          # list available devices
flutter run -d <device>  # run on specific device
```

---

## Stack and Versions

| Tool / Library | Version |
|---|---|
| Flutter | 3.x (stable) |
| Dart | 3.x |
| flutter_riverpod | ^2.6.1 |
| google_fonts | ^6.2.1 |
| intl | ^0.19.0 |
| uuid | ^4.5.1 |
| Material Design | Material 3 |
| Min Android SDK | 21 (Android 5.0) |
| Target Android SDK | 34 (Android 14) |

---

## Assumptions

- The app is intended for a single admin user with no authentication required
- Data is sourced entirely from a local JSON file 
- The reviewed status is the only mutable field 
- Status and service fields in the JSON may contain inconsistent or malformed values and are normalized on parse
- Submissions without an id field are assigned a generated UUID to ensure reliable identification
- The app targets Android only. No iOS-specific considerations were made
- Date values are expected in ISO 8601 format. 
- Empty strings are treated the same as null for display purposes

---

## AI Tools Used

**Tools used:** Claude && Microsoft Copilot
- Assisted with boilerplate code generation for models, copyWith, extensions, and fromJson
- Suggested the keyword list approach for status normalization
- Review and debug code structure

**How output was validated:**
- all generated code was reviewed and understood before being used.
- tests were made using temporary functions with values outputted in the terminal

## What I Would Like the Reviewer to Focus On
- Data normalization
- Data visualizaton
- Separation of concern
- UI decisions