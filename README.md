# 🛍️ Ecommerce App

A responsive and feature-rich e-commerce application built using **Flutter**, supporting both mobile and tablet layouts. This app allows users to browse products, manage their shopping cart, and place orders through a complete checkout flow.

---

## 🚀 Features

### 🛒 Product Catalog
- Displays products in a `MasonryGridView`
- Sort by: Price, Popularity, Newest
- Filter by: Category, Price Range, Rating
- Search with 400ms debounce

### 📦 Product Details
- Shows product image, title, rating, price, description
- Allows size and color selection
- Quantity increment/decrement
- "Add to Bag" button to add items to cart

### 🧺 Cart
- Lists cart items with image, title, size, color, price, quantity
- Quantity adjustment support
- "Checkout" button to proceed to order summary

### 🚚 Checkout Flow
- **Order Summary**: Subtotal, shipping, and tax
- **Shipping Page**: Form for full name, phone, address, city, postal code, country
- Delivery options: Standard and Express

### 💳 Payment Page
- Payment methods:
  - Credit/Debit Card (Cardholder Name, Card Number, Expiry, CVV)
  - UPI/Net Banking (UPI ID, Bank Name)
  - Cash on Delivery (no fields)
- Dynamic form rendering based on selection

### ✅ Order Confirmation
- Shows Order ID, estimated delivery date, total amount, and selected payment method
- "Continue Shopping" button navigates back to product catalog

---

## 📱 Responsiveness
- Supports both mobile and tablet devices
- Built with responsive layouts and scalable UI

---

## 🧰 Tech Stack

| Tech              | Usage                                 |
|------------------|----------------------------------------|
| **Flutter**       | UI Framework                          |
| **Bloc/Cubit**    | State Management                      |
| **go_router**     | Routing & Navigation                  |
| **Hive**          | Local Storage for Cart Persistence    |
| **get_it**        | Dependency Injection                  |
| **dartz**         | Functional Programming                |
| **google_fonts**  | Custom Font Integration               |

---

## 🎨 Additional Features

- Hero animations and page transitions
- Clean Architecture and modular structure
- Feature-wise folder organization
- Search with debounce
- Form validation

---

## 🧪 Testing

- **Manual Testing**: Performed on Android device and tablet using `device_preview`
- Validated all flows: product browsing → cart → checkout → payment → confirmation

---

## 📦 Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/Sumit-9900/e-commerce-app

2. Navigate to the project folder:
    ```bash
    cd e-commerce-app

3. Install dependencies:
    ```bash
    flutter pub get

4. Run the app:
    ```bash
    flutter run

---

## ✅ Conclusion

This e-commerce app demonstrates a complete shopping experience with clean architecture, responsive design, and smooth state management. It's a solid foundation for scalable, production-ready Flutter applications.
