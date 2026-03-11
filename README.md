# Shopistry - Modern Furniture E-commerce

Shopistry is a premium furniture e-commerce mobile application built with Flutter, demonstrating professional architecture and modern development practices.

![App Header](assets/images/readme_header.png)

## 🌟 Overview

Shopistry is designed to provide a seamless and visually appealing shopping experience. It follows **Clean Architecture** principles to ensure a scalable, maintainable, and testable codebase. The app features a sophisticated "Taupical" theme—a curated palette of taupe and grey shades—providing a modern and minimalist aesthetic.

## 🚀 Key Features

- **Product Discovery**: Browse a curated collection of furniture with category filtering.
- **Search & Filter**: Find specific items using a robust search and filtering system.
- **Wishlist Management**: Save your favorite items for later.
- **Shopping Cart**: Full-featured cart management with quantity adjustments.
- **Simulated Checkout**: A complete end-to-end checkout flow.
- **Localization**: Support for multiple languages (English and Yoruba).
- **Responsive UI**: Optimized for various screen sizes using ScreenUtil.

## 🛠 Tech Stack & Architecture

This project serves as a showcase for high-quality Flutter development:

- **Clean Architecture**: Separated into Presentation, Domain, and Data layers.
- **State Management**: 
  - **Bloc/Cubit**: Handles complex business logic and UI state transitions.
  - **Riverpod**: Used for dependency injection and shared services.
- **Functional Programming**: Integrated **fpdart** for safer error handling using the `Either` type.
- **Design System**: 
  - Custom **Taupical** theme.
  - Robust text theme using **Google Fonts**.
- **Responsive Design**: Implemented with **flutter_screenutil**.
- **Localization**: Standard Flutter l10n with fallback delegates.

## 🏗 Project Structure

```text
lib/
├── core/             # Core utilities, theme, and shared components
├── features/         # Feature-based modules (Clean Architecture)
│   ├── home/         # Product browsing and discovery
│   ├── cart/         # Shopping cart logic
│   ├── checkout/     # Checkout process
│   ├── favorites/    # Wishlist management
│   └── profile/      # User settings and preferences
├── l10n/             # Localization files
└── main.dart         # Entry point
```

## ⚙️ Development Approach

Shopistry is built as if a real backend exists. All data operations are defined through repositories and data sources. While current implementations use mocked data, the architecture allows for a seamless transition to a live API by simply swapping the data source implementations.

## 📱 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/shopistry.git
   ```
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Run the app**
   ```bash
   flutter run
   ```

---

*Developed as a portfolio project to demonstrate professional Flutter engineering.*
