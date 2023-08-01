<?php

namespace App\Console\Commands\Telegram;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Storage;
use Longman\TelegramBot\Request;

class SendInvoice extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'telegram:send-invoice';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
      $clients = \App\Models\Target\Client::whereNotNull('current_invoice_id')
        ->whereRelation('currentInvoice', 'is_paid', false)
        ->get();

      foreach ($clients as $client) {
        $chats = $client->botChats;
        $invoice = $client->currentInvoice;
        $invoiceBudget = number_format($invoice->budget, 0, '.', ' ');

        foreach ($chats as $chat) {
          Request::sendDocument([
            'chat_id' => $chat->id,
            'document' => Storage::path($invoice->path),
            'caption' => "⬆️ Счёт на оплату РК ВК \nСумма к оплате: *{$invoiceBudget}* ₽ \n$client->name",
            'parse_mode' => 'markdown'
          ]);
        }
      }
    }
}
