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
    Schema::table('clients', function (Blueprint $table) {
      $table->integer('zero_days')->default(0);
      $table->integer('budget_adjustment')->default(0);
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::table('clients', function (Blueprint $table) {
      $table->dropColumn('zero_days');
      $table->dropColumn('budget_adjustment');
    });
  }
};
