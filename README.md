# Mess Manager (Flutter Starter)

Modern mess management app foundation with:

- clean architecture (feature-first + `data` / `domain` / `presentation`)
- Riverpod state management
- `go_router` navigation
- responsive UI foundation
- light/dark mode support
- starter modules for auth, chat, expenses, meals, and admin

## Current Structure

```text
lib/
  app/
    app.dart
    router/app_router.dart
    theme/
  core/
    constants/
    responsive/
    widgets/
  features/
    auth/
      data/
      domain/
      presentation/
    chat/
      data/
      domain/
      presentation/
    expenses/
      data/
      domain/
      presentation/
    meals/
      data/
      domain/
      presentation/
    admin/
      data/
      domain/
      presentation/
    home/
      presentation/
```

## Next Steps

- add real auth providers (Firebase Auth / Supabase / custom backend)
- connect chat repository to websocket/Firebase realtime streams
- implement expense and meal repositories with local + remote data sources
- enforce role-based route guards in `app_router.dart`
