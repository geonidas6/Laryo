<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExperimentAssignment extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'experiment_id',
        'variant',
    ];

    public function experiment()
    {
        return $this->belongsTo(Experiment::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
