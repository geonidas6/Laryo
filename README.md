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

The mobile app can receive the API base URL using a dart define or from `flutterapp/.env`:

```bash
flutter run --dart-define=API_URL=http://localhost:8000
```

In Laravel, configure `APP_URL` and your database credentials in `.env`.

## SSO Authentication

After installing the dependencies with:

```bash
composer require laravel/socialite laravel/sanctum
```

You can authenticate users via third party providers.

- `GET /api/sso/redirect/{provider}` redirects the user to the chosen provider.
- `GET /api/sso/callback/{provider}` returns a JSON response containing a Sanctum token.

Example response:

```json
{
  "token": "<token>",
  "user": { /* user attributes */ }
}
```

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
## Authentication with Socialite & Sanctum

This boilerplate can be extended to support OAuth login and API tokens. Install
the packages and publish Sanctum's configuration:

```bash
cd laravel
composer require laravel/socialite laravel/sanctum
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
```

Add Sanctum's middleware to the `api` group in `app/Http/Kernel.php` and run the
migrations. Each Socialite provider (Google, GitHub…) requires credentials in
`config/services.php` and matching variables in `.env`:

```php
'github' => [
    'client_id' => env('GITHUB_CLIENT_ID'),
    'client_secret' => env('GITHUB_CLIENT_SECRET'),
    'redirect' => env('GITHUB_REDIRECT_URI'),
],
```

After configuration you can authenticate via the provider and receive a Sanctum
token for the Flutter app.

## Running migrations for `ui_templates` and `features`

When installing optional modules such as `ui_templates` or `features`, run their
migrations after publishing the package files:

```bash
php artisan migrate --path=vendor/vendor-name/ui_templates/database/migrations
php artisan migrate --path=vendor/vendor-name/features/database/migrations
```

Adjust the path according to where the packages store their migrations.

## Flutter services

The mobile project exposes a small API client in `lib/services`. `ApiService`
reads `API_BASE_URL` from the Flutter `.env` file and provides methods for
`login`, `register` and retrieving the authenticated profile. Tokens are
persisted using `AuthService`, backed by `shared_preferences`. These services
consume the Laravel endpoints described in `swagger.yaml`.
=======
## License

Ce projet est distribue sous la licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus d'informations.
