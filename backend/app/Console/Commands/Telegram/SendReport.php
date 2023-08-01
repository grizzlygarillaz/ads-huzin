<?php

namespace App\Console\Commands\Telegram;

use App\Models\Target\Client;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Longman\TelegramBot\Exception\TelegramException;
use Longman\TelegramBot\Request;

class SendReport extends Command
{
  protected int $startTime = 10;
  protected int $endTime = 18;
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'telegram:send-report {client?} {--without_time}';

  /**
   * The console command description.
   *
   * @var string
   */
  protected $description = 'Command description';

  /**
   * Execute the console command.
   */
  public function handle(): int
  {
    if ($this->argument('client')) {
      $client = Client::find($this->argument('client'));
      if ($client && $client->has('botChats')) {
        $this->sendReport($client);
      }
      return Command::SUCCESS;
    }

    $prevWeek = Carbon::now()->addWeeks(-1)->timestamp;
    $clients = Client::where('created_at', '>=', $prevWeek)
      ->where('is_report_notified', false)
      ->where('is_stopped', false)
      ->has('botChats')
      ->get();

    foreach ($clients as $client) {
      $this->sendReport($client);
    }
    return Command::SUCCESS;
  }

  private function sendReport(Client $client): void
  {
    $clientTime = Carbon::now()->addHours($client->timezone)->hour;
    $url = env('FRONTEND_URL');
    $stats_full_link = "$url/client_report/{$client->id}/{$client->token}";

    if (!$this->option('without_time')) {
      if ($clientTime < $this->startTime || $clientTime > $this->endTime) {
        return;
      }
    }

    $message = <<<EOT
                👋🏻 Добрый день, коллеги, высылаю отчет по *$client->name*:

                EOT;
    if ($client->google_table) {
      $message .= <<<EOT
                📊 [Анализ  продаж и маркетинга]($client->google_table)
                EOT;
    } else {
      $message .= <<<EOT
                📊 [Отчёт по рекламным компаниям]($stats_full_link)
                EOT;
    }

    //                Вот тут краткое видео как работать с отчетами ССЫЛКА
    $time = Carbon::now()->format('H:i');
    foreach ($client->botChats as $chat) {
      try {
        Request::sendMessage([
          'chat_id' => $chat->id,
          'text' => $message,
          'parse_mode' => 'markdown'
        ]);
        $client->is_report_notified = true;
        $client->save();
        echo "$time {$client->name}";
      } catch (TelegramException $e) {
        \Log::error('telegram:send-report', ['message' => $e->getMessage(), 'code' => $e->getCode()]);
        echo "ERROR $time {$client->name} {$e->getMessage()}";
      }
    }
  }
}
