<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GuideStep extends Model
{
    use HasFactory;

    protected $fillable = [
        'guide_id',
        'title',
        'content',
        'step_order',
    ];

    public function guide()
    {
        return $this->belongsTo(Guide::class);
    }
}
