# 📱 Project Context: HabitFlow

## 📝 Overview
**HabitFlow** is a habit tracking application designed to demonstrate enterprise-grade Flutter architecture.
It focuses on simplicity, flow state, and beautiful interactions.

## 🛠 Tech Stack
- **Framework**: Flutter
- **Language**: Dart
- **Architecture**: Clean Architecture (Feature-first or Layer-first)
- **State Management**: Riverpod (with riverpod_generator)
- **Navigation**: GoRouter
- **Functional Programming**: fpdart (Either, Option, TaskEither)
- **Data Class**: Freezed
- **Local DB**: SharedPreferences (MVP) -> Hive/Isar (Planned)
- **Remote DB**: Supabase (Planned)

## 📂 Architecture Structure
```
lib/
├── core/           # Shared kernel, failures, usecases, utils
├── features/       # Feature-based modules
│   └── habit/
│       ├── data/
│       │   ├── datasources/  # Local/Remote APIs
│       │   ├── models/       # DTOs (extends Entities, handles JSON)
│       │   └── repositories/ # Repository Implementations
│       ├── domain/
│       │   ├── entities/     # Pure Dart classes (Freezed)
│       │   ├── repositories/ # Interfaces
│       │   └── usecases/     # Business Logic (Single Responsibility)
│       └── presentation/
│           ├── riverpod/     # State Notifiers
│           ├── pages/        # Screens
│           └── widgets/      # Reusable Components
└── main.dart
```

## 🧩 Key Patterns Applied
1.  **Mapper Pattern**: Decoupling `Entity` (Domain) from `Model` (Data) via `toEntity()`/`fromEntity()`.
2.  **Repository Pattern**: Domain defines interface, Data provides implementation.
3.  **Result Object Pattern**: Using `fpdart::Either<Failure, T>` for rigorous error handling.
