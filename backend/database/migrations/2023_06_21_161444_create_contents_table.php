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
    Schema::create('contents', function (Blueprint $table) {
      $table->id();
      $table->string('path');
      $table->string('name');
      $table->string('link')->nullable();
      $table->char('mime', 128);
      $table->char('extension', 55);
      $table->text('hash');
      $table->timestamps();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::dropIfExists('contents');
  }
};
