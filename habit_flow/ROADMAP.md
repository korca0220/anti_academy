# 🗓️ Roadmap: HabitFlow (Mastery Edition)

**Goal**: Build a Production-Grade Flutter App with Advanced Patterns.

## 🏁 Phase 1-3: The Core (Completed)
- [x] Clean Architecture Setup
- [x] Domain Layer Rules (Entities, UseCases)
- [x] Presentation Layer Shell (Riverpod Notifiers)
- [x] Manual DTO Implementation (No CodeGen Dependency)

## 💾 Phase 4: Data Layer Deep Dive (Current)
- [ ] **Local Storage**: Implementing robust `SharedPreferences` handling.
- [ ] **Error Handling**: Catching distinct exceptions (Cache vs Server).
- [ ] **Repository Implementation**: Binding Data Source to Domain with `Either`.
- [ ] **Testing**: Writing Unit Tests for the Repository layer.

## 🎨 Phase 5: Advanced UI & UX (Visual Polish)
- [ ] **Micro-Interactions**: Hero animations, completion confetti.
- [ ] **Custom Painters**: Drawing custom progress charts/graphs (No libraries).
- [ ] **Reordering**: Drag-and-drop mechanics for habit priority.
- [ ] **Theme System**: Persisted Dark/Light mode switching.

## ☁️ Phase 6: Backend & Offline-First (Architecture)
- [ ] **Supabase Integration**: Authentication & Database.
- [ ] **Optimistic UI**: Updating UI immediately before server response.
- [ ] **Sync Strategy**: Handling offline edits and syncing when online.

## 🛡️ Phase 7: Hardening (Engineering)
- [ ] **Riverpod Observer**: State change logging.
- [ ] **Environment Config**: Flavors (Dev/Prod).
- [ ] **Widget Tests**: Verifying UI flows automatically.
