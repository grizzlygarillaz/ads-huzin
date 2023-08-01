<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
  /**
   * Run the migrations.
   */
  public function up(): void
  {
    Schema::create('clients', function (Blueprint $table) {
      $table->id();
      $table->string('name');
      $table->integer('balance')->nullable();
      $table->integer('critical_balance')->default(0);
      $table->integer('all_limit')->nullable();
      $table->integer('day_limit')->nullable();
      $table->integer('day_spent')->nullable();
      $table->integer('week_spent')->nullable();
      $table->integer('month_spent')->nullable();
      $table->integer('month_plan')->default(50000);
      $table->timestamps();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::dropIfExists('clients');
  }
};
