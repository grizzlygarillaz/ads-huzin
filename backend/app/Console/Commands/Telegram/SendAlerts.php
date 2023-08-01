<?php

namespace App\Console\Commands\Telegram;

use App\Models\Target\Client;
use App\Models\User;
use Illuminate\Console\Command;
use Longman\TelegramBot\Exception\TelegramException;
use Longman\TelegramBot\Request;

class SendAlerts extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'telegram:send-alerts';

  /**
   * The console command description.
   *
   * @var string
   */
  protected $description = 'Command description';

  /**
   * Execute the console command.
   * @throws TelegramException
   */
  public function handle(): void
  {
    foreach (User::whereNotNull('chat_id')->get() as $user) {
      $text = "Привет, $user->name 👋";
      $emptyInfo = true;

      if ($user->hasRole('accountant')) {
        $needInvoiceClients = Client::where('is_budget_agreed', true)
          ->whereNull('current_invoice_id')
          ->get();
        $needPayVkClients = Client::where('is_budget_agreed', true)
          ->whereRelation('currentInvoice', 'is_paid', true)
          ->whereRelation('currentInvoice', 'is_vk_paid', false)
          ->get();

        if ($needInvoiceClients->count()) {
          $emptyInfo = false;
          $text .= "\n\n*Нужно выставить счета для:*";
          foreach ($needInvoiceClients as $client) {
            $text .= "\n_{$client->name}_ *{$client->recommended_budget}*₽";
          }
        }

        if ($needPayVkClients->count()) {
          $emptyInfo = false;
          $text .= "\n\n*Не забудь оплатить ВК:*";
          foreach ($needPayVkClients as $client) {
            $text .= "\n_{$client->name}_";
          }
        }
      } else {
        $text .= "\n\n*Нужно согласовать бюджет у твоих проектов:*";
        $clients = $user->clients()->where('is_budget_agreed', false)->get();
        if (!$clients->count()) continue;

        $emptyInfo = false;
        foreach ($clients as $client) {
          $text .= "\n_{$client->name}_ {$client->balance} / {$client->critical_balance}";
        }
      }
      if ($emptyInfo) continue;

      Request::sendMessage([
        'chat_id' => $user->chat_id,
        'text' => $text,
        'parse_mode' => 'markdown'
      ]);
    }
  }
}
