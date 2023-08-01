<?php

namespace App\Console\Commands\Telegram;

use App\Models\Target\BotChat;
use App\Models\Target\Client;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Longman\TelegramBot\Exception\TelegramException;
use Longman\TelegramBot\Request;

class SendBalance extends Command
{
  protected int $startTime = 10;
  protected int $endTime = 18;
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'telegram:send-balance {client?}';

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
    $clientId = $this->argument('client');

    if ($clientId) {
      $this->sendWithArgument($clientId);
      return;
    }

    $this->sendWithoutArgument();
  }

  protected function sendWithArgument($clientId): void
  {
    $client = Client::find($clientId);
    if ($client) {
      $message = <<<EOT
❗️ Баланс ниже критического

🔥 *$client->name*
_Текущий баланс:_ *{$client->balance}* ₽
_Критический минимум:_ *{$client->critical_balance}* ₽

EOT;

      foreach ($client->botChats as $chat) {
        try {
          Request::sendMessage([
            'chat_id' => $chat->id,
            'text' => $message,
            'parse_mode' => 'markdown'
          ]);
          $client->is_balance_notified = true;
          $client->save();
        } catch (TelegramException $e) {
          var_dump($e);
        }
      }
    }
  }

  protected function sendWithoutArgument(): void
  {
    $time = Carbon::now()->format('H:i');
    $clientHour = now()->hour;
    $notifiedClients = collect();

    foreach (BotChat::all() as $chat) {
      $message = "❗️ Баланс ниже критического" . PHP_EOL . PHP_EOL;
      $clientsMessage = [];
      $notifiedTemp = collect();
      $clients = $chat->clients()
        ->where('is_balance_notified', false)
        ->where('is_stopped', false)
        ->get();

      foreach ($clients as $client) {
        $isWorkHour = $clientHour > $this->startTime && $clientHour < $this->endTime;
        $isLowBalance = $client->balance < $client->critical_balance;

        if (!$isWorkHour || !$isLowBalance) {
          continue;
        }

        $clientsMessage [] = <<<EOT
🔥 *$client->name*
_Текущий баланс:_ *{$client->balance}* ₽
_Критический минимум:_ *{$client->critical_balance}* ₽

EOT;
        $notifiedTemp->push($client);
      }

      if (!$clientsMessage) {
        continue;
      }

      try {
        Request::sendMessage([
          'chat_id' => $chat->id,
          'text' => $message . implode(PHP_EOL, $clientsMessage),
          'parse_mode' => 'markdown'
        ]);
        $notifiedClients = $notifiedClients->merge($notifiedTemp);
      } catch (TelegramException $e) {
        \Log::error('telegram:send-balance', ['message' => $e->getMessage(), 'code' => $e->getCode(), 'clients' => $notifiedTemp]);
        echo "ERROR $time {$e->getMessage()}";
      }
    }

    foreach ($notifiedClients->unique() as $client) {
      $client->is_balance_notified = true;
      $client->save();
      echo "$time $client->name" . PHP_EOL;
    }
  }
}
