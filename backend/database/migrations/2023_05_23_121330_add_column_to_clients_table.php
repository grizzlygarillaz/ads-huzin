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
      $table->integer('recommended_budget')->nullable();
      $table->integer('days_in_low_balance')->default(0);
      $table->integer('days_in_zero_balance')->default(0);
      $table->boolean('is_budget_agreed')->default(false);
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::table('clients', function (Blueprint $table) {
      $table->dropColumn('recommended_budget');
      $table->dropColumn('days_in_low_balance');
      $table->dropColumn('days_in_zero_balance');
      $table->dropColumn('is_budget_agreed');
    });
  }
};
