<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('experiment_assignments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->foreignId('experiment_id')->constrained()->onDelete('cascade');
            $table->string('variant');
            $table->timestamps();
            $table->unique(['user_id', 'experiment_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('experiment_assignments');
    }
};
