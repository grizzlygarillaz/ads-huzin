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
    Schema::table('invoices', function (Blueprint $table) {
      $table->dropColumn(['is_paid', 'is_vk_paid', 'budget']);
      $table->integer('sum');
      $table->integer('order')->default(0);
      $table->string('entrepreneur');
      $table->timestamp('paid_at')->nullable();
      $table->timestamp('vk_paid_at')->nullable();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::table('invoices', function (Blueprint $table) {
      $table->dropColumn(['sum', 'paid_at', 'vk_paid_at', 'order', 'entrepreneur']);
      $table->boolean('is_paid')->default(false);
      $table->boolean('is_vk_paid')->default(false);
      $table->integer('budget')->default(0);
    });
  }
};
