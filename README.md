# todo_app_offline (Flutter)

# Overview
Aplikasi menerapkan arsitektur modular dengan pemisahan controller, service, model, view, dan widget. State management menggunakan GetX untuk mengelola data dan navigasi aplikasi. Seluruh data Todo disimpan secara lokal menggunakan Shared Preferences sehingga aplikasi dapat digunakan tanpa backend maupun koneksi internet.

## Tech Stack

- Flutter 3.24.3
- Dart 3.5.3
- GetX
- Shared Preferences
- UUID


## Requirements

- Flutter 3.24.3
- Dart 3.5.3
- Node.js: 24.14.0
- npm: 11.9.0

---


## Project Structure

```txt
lib/
├── features/
│   └── todo/
│       ├── binding/
│       │   └── todo_binding.dart
│       │
│       ├── controller/
│       │   └── todo_controller.dart
│       │
│       ├── models/
│       │   └── todo.dart
│       │
│       ├── service/
│       │   ├── todo_service.dart
│       │   └── todo_service_impl.dart
│       │
│       ├── view/
│       │   ├── todo_page.dart
│       │   └── todo_form_page.dart
│       │
│       └── widgets/
│           ├── todo_item.dart
│           └── todo_item_content.dart
│
├── shared/
│   │
│   ├── routes/
│   │   ├── app_pages.dart
│   │   └── routes.dart
│   │
│   ├── services/
│   │   └── local_storage.dart
│   │
│   └── widgets/
│       ├── confirm_dialog.dart
│       └── styles.dart
│
└── main.dart
```


---

## Folder Description

| Folder          | Description                                              |
| --------------- | -------------------------------------------------------- |
| binding         | Dependency Injection menggunakan GetX                    |
| controller      | Business logic dan state management                      |
| models          | Model data Todo                                          |
| service         | Operasi Crud pada local storage                          |
| view            | Halaman aplikasi                                         |
| widgets         | Widget khusus fitur Todo                                 |
| routes          | Konfigurasi routing aplikasi                             |
| services        | Service penyimpanan lokal menggunakan Shared Preferences |
| shared/widgets  | Reusable widgets                                         |

---

## Installation

Clone repository:

```bash
git clone https://github.com/Pangestufp/todo-app-offline-flutter
```

---

Masuk ke folder project:

```bash
cd todo-app-offline-flutter
```

---

Install dependency:

```bash
flutter pub get
```

---

Jalankan aplikasi:

```bash
flutter run
```

---

Jalankan aplikasi pada browser:

```bash
flutter run -d chrome
```

---


