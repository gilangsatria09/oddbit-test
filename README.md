# Notes App

A full-stack notes application built with Flutter (mobile) and Dart Frog (backend).

## API Reference

[Notes API on SwaggerHub](https://app.swaggerhub.com/apis/gsatria253organizati/notes-local-api/1.0.0)

## Requirements

- Flutter `3.38.4`
- Dart `3.10.3`
- Dart Frog CLI — install once globally:

```bash
dart pub global activate dart_frog_cli
```

## Project Structure

```
oddbit_test/
├── notes_app/      # Flutter mobile app
├── services/       # Dart Frog backend (port 8080)
├── initial_setup.sh
├── start_server.sh
└── run_app.sh
```

## Getting Started

### 1. Initial Setup

Run this once after cloning to generate all required code:

```bash
./initial_setup.sh
```

This runs `build_runner` for both `services` and `notes_app`.

### 2. Start the Server

The app requires the backend to be running before launching:

```bash
./start_server.sh
```

The server will start on `http://localhost:8080`.

### 3. Run the App

```bash
./run_app.sh
```

You will be prompted to select a target:

| Option | Target | Base URL |
|--------|--------|----------|
| 1 | iOS Simulator | `http://localhost:8080` |
| 2 | Android Emulator | `http://10.0.2.2:8080` |
| 3 | Physical Device | `http://<your-ip>:8080` |

For physical device, enter the IP address of the machine running the server when prompted.

## Default Account

On first run, the backend automatically creates a seed account:

| Field    | Value             |
|----------|-------------------|
| Username | `dummy_account1`  |
| Password | `DuMmMyAccount1#` |

You can log in with this account immediately, or register a new one.
