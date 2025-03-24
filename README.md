# iOS Code Challenge

Welcome to this coding challenge! The goal is to **fetch and display hierarchical JSON data** in a native iOS app, with a well-structured and maintainable codebase. This repository demonstrates how to build an app that:

- **Retrieves** JSON data from a remote endpoint using a networking layer.
- **Displays** pages, sections, and questions in a hierarchical manner (with corresponding font sizes).
- **Opens** images in full screen when tapped, with caching and offline capability (optional).

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Installation & Setup](#installation--setup)  
3. [Features & Requirements](#features--requirements)  
4. [Architecture](#architecture)  
5. [Usage](#usage)  
6. [Offline Support](#offline-support-bonus)  

---

## Project Overview

This iOS app fetches hierarchical JSON content from:
https://run.mocky.io/v3/9b27a9ff-886d-42b6-9501-950e1fd1598b

It displays that JSON in a structured view:

1. **Pages**  
   - Large font title, can contain sections or questions.
2. **Sections**  
   - Medium font title, can be nested (subsections).
3. **Questions** (two types):
   - **Text question**: shows a small text label.
   - **Image question**: shows a small image thumbnail; tapping it opens a new screen with the full-sized image.

### Highlights

- **Hierarchical UI** with indentation and font-size changes to reflect the nested structure.  
- **Image Zoom Screen** for full-sized viewing.  
- **Dark Mode** support included.  
- **Offline Support** (optional bonus): caches JSON to local storage.  
- **Error Handling** for network failures, displaying fallback data when offline.

---

## Installation & Setup

1. **Clone this repository**:
   ```bash
   git clone https://github.com/YourUsername/AssessmentApp.git
   cd AssessmentApp
2. Open in Xcode
Double-click AssessmentApp.xcodeproj
3. Install Swift Packages
- **When prompted by Xcode, it will automatically fetch and resolve packages like Moya, RxSwift, SnapKit, etc.

- **Alternatively, go to File → Add Packages... in Xcode and verify the required dependencies are present.
4. Configure SwiftLint (optional but recommended)

**Install SwiftLint if you haven't already:**:
   ```bash
    brew install swiftlin
  ```
5. Run the Project

- **In Xcode, select the AssessmentApp scheme and your desired simulator/device.

- **Press Cmd + R (or click the Run button) to build and run.

---

## Features & Requirements

- **iOS 15+** (configurable in `Info.plist`).
- **Swift 5+**.
- Uses the following libraries:
  - **[SwiftLint](https://github.com/realm/SwiftLint)** for style consistency.
  - **[Alamofire](https://github.com/Alamofire/Alamofire)** (often used by Moya under the hood).
  - **[Factory](https://github.com/hmlongco/Factory)** for dependency injection.
  - **[Kingfisher](https://github.com/onevcat/Kingfisher)** for image fetching and caching.
  - **[Moya](https://github.com/Moya/Moya)** for the networking layer on top of Alamofire.
  - **[ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift)** & **[RxSwift](https://github.com/ReactiveX/RxSwift)** for reactive programming.
  - **[SnapKit](https://github.com/SnapKit/SnapKit)** for Auto Layout in code.
  - **[SwiftEntryKit](https://github.com/huri000/SwiftEntryKit)** for custom alerts and popups.
  - **[Toast](https://github.com/scalessec/Toast-Swift)** for simple toast messages.
  - **[XCoordinator](https://github.com/quickbirdstudios/XCoordinator)** for a coordinator-based navigation approach.

---

## Architecture

The app is structured around a **clean MVVM** MVVM + Coordinators approach, with clear separation of concerns:

- **Domain**  
  Contains core business logic, models, repositories, and protocol definitions.

- **Networking**  
  Handles requests via **Moya**, sets up a `Provider` to fetch JSON from the mock endpoint, and includes custom plugins/interceptors.

- **Presentation**  
  SwiftUI/Storyboard/UIViewController code (depending on your preference) that displays the hierarchical structure using data from the Domain layer.  
  - Additional subfolders hold custom UI elements, toasts, etc.

- **AppDesignSystem**  
  - Global fonts, color definitions, and theming.  
  - Ensures a consistent style across the app (including Dark Mode support).

- **Scenes**  
  - Holds each major screen’s View, ViewModel, and routing logic (e.g., using `XCoordinator` or your chosen approach).

---


## Usage

When you launch the app:

- The **Main Screen** displays the Pages from the JSON.
- Under each Page, you’ll see:
  - **Sections**: bold, medium-size font (nested sections get progressively smaller).
  - **Questions**:  
    - **Text** → displayed as a small text label.  
    - **Image** → displayed as a thumbnail; tapping it navigates to a separate screen showing the full-size image and its title.

> **Dark Mode** is supported automatically if you enable it in the iOS Simulator or device settings.

---

## Offline Support (Bonus)

the project demonstrates **offline support**:

- **Local Cache**: After a successful fetch, the JSON is stored in a local cache (`FormLocalRepository`).
- **Network Failover**: If the network is offline, the app show ToastView.

To force offline mode, disable your internet connection and relaunch the app. You should still see the last-cached data.

---

**Thank you for exploring this repository!**  
If you have any questions or run into issues, please open an issue or submit a pull request.

> *Happy Coding!*

---




