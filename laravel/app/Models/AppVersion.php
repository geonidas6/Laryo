<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AppVersion extends Model
{
    protected $fillable = [
        'platform',
        'min_version',
        'current_version',
        'changelog',
        'force_update',
    ];
}
