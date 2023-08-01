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
      $table->timestamp('agreed_at')->nullable();
      $table->tinyInteger('timezone')->default(0);
      $table->string('google_table')->nullable();
      $table->boolean('is_balance_notified')->default(false);
      $table->boolean('is_report_notified')->default(false);
      $table->boolean('is_stopped')->default(false);
      $table->boolean('is_active')->default(false);
      $table->integer('balance')->default(0)->change();
    });
  }

  /**
   * Reverse the migrations.
   */
  public function down(): void
  {
    Schema::table('clients', function (Blueprint $table) {
      $table->dropColumn('agreed_at');
      $table->dropColumn('timezone');
      $table->dropColumn('google_table');
      $table->dropColumn('is_balance_notified');
      $table->dropColumn('is_report_notified');
      $table->dropColumn('is_stopped');
      $table->dropColumn('is_active');
      $table->integer('balance')->nullable()->change();
    });
  }
};
