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
    Schema::create('groups', function (Blueprint $table) {
      $table->id();
      $table->string('name');
      $table->char('link', 128);
      $table->char('site', 255)->nullable();
      $table->char('screen_name', 55);
      $table->char('city', 55)->nullable();
      $table->smallInteger('timezone')->nullable();
      $table->char('senler_token', 55)->nullable();
      $table->char('photo')->nullable();
      $table->foreignId('client_id');
      $table->timestamps();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::dropIfExists('groups');
  }
};
