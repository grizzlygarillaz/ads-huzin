<?php

namespace App\Console\Commands\Ads;

use App\Api\Vk\Ads;
use App\Models\Target\Client;
use Illuminate\Console\Command;
use Symfony\Component\Console\Command\Command as CommandAlias;

class GetClients extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'ads:get-clients';

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
    Client::where('is_active', true)->update(['is_active' => false]);
    $clients = (new Ads())->getClients();
    foreach ($clients as $index => $client) {
      $clients[$index] += ['entrepreneur' => ''];
      $clients[$index] += ['is_active' => true];
      if (array_key_exists('ord_data', $client) && array_key_exists('client_name', $client['ord_data'])) {
        $clients[$index]['entrepreneur'] = $client['ord_data']['client_name'];
      }
      unset($clients[$index]['ord_data']);
    }
    Client::upsert($clients, ['id'], ['all_limit', 'day_limit', 'name', 'is_active', 'entrepreneur']);
    //; `all_limit` = values(`all_limit`), `day_limit` = values(`day_limit`), `id` = values(`id`), `name` = values(`name`), `entrepreneur` = values(`entrepreneur`), `is_active` = values(`is_active`), `updated_at` = values(`updated_at`))
    return CommandAlias::SUCCESS;
  }
}
