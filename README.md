# 🛍️ Mini Store - Flutter Mobile Application

## 📌 Project Overview

Mini Store is a simple e-commerce mobile application developed with Flutter. The application allows users to log in, browse products, search for items, view product details, add products to a shopping cart, and simulate the checkout process.

The project was developed as part of a Flutter training program to demonstrate the fundamentals of mobile application development, including UI design, navigation, API integration, local storage, and state management.

---

## ✨ Features

* Splash Screen
* User Login
* Local data storage using SharedPreferences
* Product listing from REST API
* Product search functionality
* Product detail page
* Shopping cart system
* Cart badge showing the number of selected products
* Remove items from cart
* Clear cart
* Checkout simulation
* Logout functionality
* Responsive Material Design UI

---

## 📱 Application Screens

* Splash Screen
* Login Screen
* Product List Screen
* Product Detail Screen
* Shopping Cart Screen

---

## 🛠️ Technologies Used

* Flutter
* Dart
* Material Design
* HTTP Package
* SharedPreferences
* Fake Store API

---

## 📂 Project Structure

```text
lib/
│
├── components/
│   ├── mini_tile.dart
│   └── product_tile.dart
│
├── models/
│   └── product_model.dart
│
├── services/
│   ├── api_service.dart
│   └── local_storage.dart
│
├── views/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── product_screen.dart
│   ├── product_detail_screen.dart
│   └── cart_screen.dart
│
└── main.dart
```

---

## 🌐 API

Product data is retrieved from:

https://fakestoreapi.com/products

---

## 📦 Packages

```yaml
dependencies:
  flutter:
    sdk: flutter
  http:
  shared_preferences:
```

---

## ▶️ Getting Started

1. Clone the repository

```bash
git clone https://github.com/yourusername/mini-store.git
```

2. Navigate to the project directory

```bash
cd mini-store
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the application

```bash
flutter run
```

---

## 📸 Screenshots

Create a folder named **screenshots** inside the project and add the following images:

* splash.png
* login.png
* products.png
* product_detail.png
* cart.png

Example:

```
screenshots/
├── splash.png
├── login.png
├── products.png
├── product_detail.png
└── cart.png
```

---

## 🚀 Flutter Version

```
Flutter 3.x
Dart 3.x
```

You can check your installed version using:

```bash
flutter --version
```

---

## 🎯 Learning Outcomes

This project demonstrates the following Flutter concepts:

* Stateful & Stateless Widgets
* Navigation
* Route Arguments
* GridView
* ListView
* REST API Integration
* JSON Parsing
* Model Classes
* Local Storage
* Search & Filtering
* Basic State Management
* Reusable Components

---

## 👨‍💻 Developer

**Furkan Kaçar**

Developed as a Flutter training project for educational purposes.
