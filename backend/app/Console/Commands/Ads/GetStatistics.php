<?php

namespace App\Console\Commands\Ads;

use App\Api\Vk\Ads;
use App\Models\Target\Client;
use Carbon\Carbon;
use Illuminate\Console\Command;

class GetStatistics extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'ads:get-statistics';

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
    // TODO replace with filtered Client
    $clients = Client::all();
    $ads = new Ads();

    $clients_ids = $clients->pluck('id');
    $ids = $clients_ids->join(',');
    $days = now()->day;

    $monthStatistics = collect(
      $ads->getStatistics('client', $ids, 'month', now()->format('Y-m'), now()->format('Y-m'))
    );
    $weekStatistics = collect(
      $ads->getStatistics('client', $ids, 'week', now()->startOfWeek()->format('Y-m-d'), now()->format('Y-m-d'))
    );
    $dayStatistics = collect(
      $ads->getStatistics('client', $ids, 'day', now()->addDays(-1)->format('Y-m-d'), now()->addDays(-1)->format('Y-m-d'))
    );
    $overallStatistics = collect(
      $ads->getStatistics('client', $ids, 'overall', 0, 0)
    );
    $monthDailyStatistics = collect(
      $ads->getStatistics('client', $ids, 'day', now()->startOfMonth()->format('Y-m-d'), now()->format('Y-m-d'))
    );

    $clientsStats = $clients->map(static function (Client $client) use (
      $days,
      $monthDailyStatistics,
      $overallStatistics,
      $monthStatistics,
      $weekStatistics,
      $dayStatistics
    ) {
      $balance = max($client->all_limit - ($overallStatistics->firstWhere('id', $client->id)['stats'][0]['spent'] ?? 0), 0);
      $monthDailyStats = $monthDailyStatistics->firstWhere('id', $client->id)['stats'];
      $zeroDays = $days - count($monthDailyStatistics->firstWhere('id', $client->id)['stats']);
      foreach ($monthDailyStats as $stat) {
        if (!array_key_exists('spent', $stat) || !$stat['spent']) {
          $zeroDays++;
        }
      }

      if (!$client->low_balance_at && $balance < $client->critical_balance) {
        $client->low_balance_at = Carbon::now();
        $client->save();
      }

      if (!$client->zero_balance_at && !$balance) {
        $client->zero_balance_at = Carbon::now();
        $client->save();
      }

      return [
        'id' => $client->id,
        'name' => $client->name,
        'balance' => $balance,
        'day_spent' => $dayStatistics->firstWhere('id', $client->id)['stats'][0]['spent'] ?? null,
        'week_spent' => $weekStatistics->firstWhere('id', $client->id)['stats'][0]['spent'] ?? null,
        'month_spent' => $monthStatistics->firstWhere('id', $client->id)['stats'][0]['spent'] ?? null,
        'zero_days' => $zeroDays
      ];
    });
    Client::upsert($clientsStats->toArray(), ['id']);

    return self::SUCCESS;
  }
}
