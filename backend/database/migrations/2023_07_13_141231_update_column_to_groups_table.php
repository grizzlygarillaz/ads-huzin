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
    Schema::table('groups', function (Blueprint $table) {
      $table->smallInteger('timezone')->change()->default(0)->nullable(false);
      $table->foreignId('content_plan_id')->nullable();
      $table->foreignId('border_id')->nullable();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::table('groups', function (Blueprint $table) {
      $table->smallInteger('timezone')->change()->nullable();
      $table->dropColumn(['content_plan_id', 'border_id']);
    });
  }
};
