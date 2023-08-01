<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('invoices', function (Blueprint $table) {
          $table->string('number', 55)->nullable();
          $table->string('inn', 55)->nullable();
          $table->string('customer', 128)->nullable();
          $table->string('vk_number', 128)->nullable();
          $table->text('description')->nullable();
          $table->boolean('is_vk_paid')->default(false);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('invoices', function (Blueprint $table) {
          $table->dropColumn('number');
          $table->dropColumn('inn');
          $table->dropColumn('customer');
          $table->dropColumn('description');
          $table->dropColumn('vk_number');
          $table->dropColumn('is_vk_paid');
        });
    }
};
