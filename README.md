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
git clone https://github.com/escruzado/submissions.git
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
flutter devices          
flutter run -d <device>  
```

---


## Stack and Versions

| Tool / Library | Version |
|---|---|
| Flutter | 3.41.9 |
| Dart | 3.11.5 |
| flutter_riverpod | ^3.3.2 |
| google_fonts | ^8.2.1 |
| intl | ^0.20.3 |
| uuid | ^4.6.0 |
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

## Known Limitations and What I Would Do With More Time

**Known limitations:**
- Search is triggered on button press only. No real-time filtering as you type.
- No pagination or lazy loading. This will not scale well with large datasets.
- Inconsistent colors caused by inaccurate monitor was only realized after running the appication on a separate device.
- Filter is limited to a single search query. Sorting and multi-field filtering was not implemented.
- No snackbars implemented to indicate successful operations.

**With more time I would:**
- implement real time search as the user types
- add more filter features to allow multi-criteria filtering 
- write unit tests 
- improve colors, animations, and transitions

## AI Tools Used

**Tools used:** Claude & Microsoft Copilot
- Assisted with boilerplate code generation for models, copyWith, extensions, and fromJson
- Used as a search engine
- Suggested the keyword list approach for status normalization
- Review and debug code structure

**How output was validated:**
- all generated code was reviewed and understood before being used.
- tests were made using temporary functions with values outputted in the terminal

---

## What I Would Like the Reviewer to Focus On
- **Data normalization**        - how messy data are handled in production code
- **Data visualizaton**         - how to gauge which parts of the data should be visible to its user, and how to properly express this through UI design
- **Separation of concern and project planning**     - how to properly structure your files and how to easily plan for the project you are about to do.
- **UI decisions**              - proper conventions, design rule of thumbs. 