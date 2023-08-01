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
      $table->dropColumn(['paid_at', 'current_invoice_id']);
      $table->string('entrepreneur')->nullable();
      $table->integer('new_budget')->nullable();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::table('clients', function (Blueprint $table) {
      $table->dropColumn(['entrepreneur', 'new_budget']);
      $table->timestamp('paid_at')->nullable();
      $table->foreignId('current_invoice_id')->nullable();
    });
  }
};
