# Laryo
micro framework Flutter adapté à Laravel te permettra de fluidifier et standardiser le développement fullstack mobile + API Laravel.

## Prerequisites

- PHP 8.x and [Composer](https://getcomposer.org/)
- [Node.js](https://nodejs.org/) and npm
- [Flutter SDK](https://flutter.dev/docs/get-started/install)

## Installation

1. **Install PHP dependencies**

   ```bash
   cd laravel
   composer install
   npm install
   cp .env.example .env
   php artisan key:generate
   ```

2. **Run database migrations**

   ```bash
   php artisan migrate
   ```

3. **Start the Laravel development server**

   ```bash
   php artisan serve
   ```

## Running the Flutter app

Install Flutter packages then launch for a specific platform:

```bash
cd flutterapp
flutter pub get
```

- Android/iOS: `flutter run`
- Web: `flutter run -d chrome`

### Environment variables

The mobile app can receive the API base URL using a dart define:

```bash
flutter run --dart-define=API_URL=http://localhost:8000
```

In Laravel, configure `APP_URL` and your database credentials in `.env`.

## Swagger UI

Pour consulter la documentation de l'API :

1. Rendez-vous dans le dossier `laravel` :

   ```bash
   cd laravel
   ```

2. Lancez le serveur de développement :

   ```bash
   php artisan serve
   ```

3. Ouvrez votre navigateur à l'adresse [http://localhost:8000/swagger](http://localhost:8000/swagger).

La documentation se base sur le fichier `public/swagger.yaml`.

## Plugins

See [docs/plugins.md](docs/plugins.md) for details on creating and registering modular plugins for both Laravel and Flutter.
