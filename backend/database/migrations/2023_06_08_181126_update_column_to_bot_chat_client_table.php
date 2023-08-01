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
        Schema::table('bot_chat_client', function (Blueprint $table) {
          $table->bigInteger('bot_chat_id')->change();
          $table->foreign('bot_chat_id')->references('id')->on('bot_chat');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('bot_chat_client', function (Blueprint $table) {
          $table->foreignId('bot_chat_id');
        });
    }
};
