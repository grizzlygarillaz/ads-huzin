<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('food_tags', function (Blueprint $table) {
            $table->id();
            $table->char('name');
            $table->char('nominative');
            $table->char('genitive');
            $table->char('accusative');
            $table->char('dative');
            $table->char('instrumental');
            $table->char('prepositional');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('food_tags');
    }
};
