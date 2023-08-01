<?php

namespace App\Console\Commands\Ads;

use App\Api\Vk\Ads;
use App\Api\Vk\VkApi;
use App\Api\VkAds\VkAdsApi;
use App\Models\Target\Client;
use App\Models\Target\Company;
use Illuminate\Console\Command;

class GetCompanies extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'ads:get-companies';

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
    $api = new Ads();
    $agencyId = config('vk.agency_id');
    $companies = [];
    foreach (Client::all() as $client) {
      foreach ($api->getCampaigns($client->id, true) as $campaign) {
        $companies[] = [
          'id' => $campaign['id'],
          'name' => $campaign['name'],
          'client_id' => $client->id
        ];
      }
    }
    Company::upsert($companies, ['id'], ['name']);

    return self::SUCCESS;
  }
}
