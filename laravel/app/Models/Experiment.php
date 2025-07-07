<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Experiment extends Model
{
    use HasFactory;

    protected $fillable = [
        'key',
        'variants',
    ];

    protected $casts = [
        'variants' => 'array',
    ];
}
