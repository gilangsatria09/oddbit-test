# notes_app

A Flutter notes application built for the Oddbit technical test. Users can register, log in, and manage personal notes through a clean interface backed by a Dart Frog REST API.

## Features

- User registration and login with JWT-based authentication
- Create, view, update, and delete notes
- Persistent secure token storage across sessions
- Real-time loading states and error feedback

## Architecture

The app follows **Clean Architecture** with a feature-first folder structure:

```
lib/
├── core/                  # Shared infrastructure
│   ├── di/                # Dependency injection (get_it + injectable)
│   ├── network/           # Dio HTTP clients, interceptors
│   ├── router/            # GoRouter navigation
│   ├── storage/           # Secure token storage
│   └── bloc/              # Base BLoC state types
├── features/
│   ├── authentication/
│   │   ├── login/         # Login feature (data / domain / presentation)
│   │   └── register/      # Register feature (data / domain / presentation)
│   └── home/              # Notes CRUD feature (data / domain / presentation)
└── shared_ui/             # Reusable widgets and theme
```

Each feature is split into three layers:

| Layer | Responsibility |
|---|---|
| **Data** | HTTP data sources, models, repository implementations |
| **Domain** | Entities, use cases, repository interfaces |
| **Presentation** | BLoC, pages, widgets |

## Tech Stack

| Package | Purpose |
|---|---|
| `flutter_bloc` + `bloc` | State management |
| `go_router` | Declarative navigation |
| `dio` | HTTP client |
| `get_it` + `injectable` | Dependency injection |
| `freezed` + `json_serializable` | Immutable models and JSON serialization |
| `dartz` | Functional error handling (`Either`) |
| `flutter_secure_storage` | Encrypted JWT token persistence |
| `logger` | Structured logging |

## Getting Started

### Prerequisites

- Flutter SDK `^3.10.3`
- The `services` backend running (see [services README](../services/README.md))

### Run

```bash
# From the notes_app directory

# Install dependencies
flutter pub get

# Run code generation (freezed, injectable, json_serializable)
dart run build_runner build --delete-conflicting-outputs

# Run pointing at the local backend (default)
flutter run

# Run with a custom backend URL
flutter run --dart-define=BASE_URL=http://<host>:<port>
```

The app defaults to `http://localhost:8080` when `BASE_URL` is not provided.

### Code Generation

The project uses `build_runner` for generated files. Re-run whenever you modify any file annotated with `@freezed`, `@injectable`, or `@JsonSerializable`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

If you encounter errors during code generation, add `--force-jit` to bypass AOT compilation issues:

```bash
dart run --force-jit build_runner build --delete-conflicting-outputs
```

## Environment

| Variable | Default | Description |
|---|---|---|
| `BASE_URL` | `http://localhost:8080` | Base URL of the Dart Frog backend |

Pass via `--dart-define=BASE_URL=<value>` at run time.

## Authentication Flow

1. The app starts on the **Login** screen.
2. On successful login, a JWT token is stored securely via `flutter_secure_storage`.
3. The `AuthInterceptor` attaches the token as a `Bearer` header on all protected requests.
4. Login and register endpoints are exempt from the auth header.
