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
      $table->dropColumn('days_in_zero_balance');
      $table->dropColumn('days_in_low_balance');
      $table->timestamp('zero_balance_at')->nullable();
      $table->timestamp('low_balance_at')->nullable();
      $table->timestamp('paid_at')->nullable();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::table('clients', function (Blueprint $table) {
      $table->dropColumn('zero_balance_at');
      $table->dropColumn('low_balance_at');
      $table->dropColumn('paid_at');
      $table->integer('days_in_low_balance')->default(0);
      $table->integer('days_in_zero_balance')->default(0);
    });
  }
};
