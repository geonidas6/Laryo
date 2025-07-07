<?php

namespace App\Providers;

use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Spatie\Permission\Models\Permission;

class PluginServiceProvider extends ServiceProvider
{
    public function boot(): void
    {
        $path = base_path('plugins.json');
        if (!file_exists($path)) {
            return;
        }

        $data = json_decode(file_get_contents($path), true);
        if (!is_array($data)) {
            return;
        }

        foreach ($data as $plugin => $enabled) {
            if (!$enabled) {
                continue;
            }

            $routeFile = base_path("modules/{$plugin}/routes.php");
            if (file_exists($routeFile)) {
                Route::middleware('web')->group($routeFile);
            }

            $permFile = base_path("modules/{$plugin}/permissions.php");
            if (file_exists($permFile)) {
                $permissions = require $permFile;
                if (is_array($permissions)) {
                    foreach ($permissions as $permission) {
                        Permission::findOrCreate($permission);
                    }
                }
            }
        }
    }
}
