# flutterapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Services

`ApiService` in `lib/services/api_service.dart` wraps the HTTP calls to the
Laravel API (login, register and profile). The base URL comes from the
`API_BASE_URL` environment variable. Tokens returned by the API are persisted via
`AuthService` so the user stays logged in.
