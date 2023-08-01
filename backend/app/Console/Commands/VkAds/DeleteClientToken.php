<?php

namespace App\Console\Commands\VkAds;

use App\Api\VkAds\AuthApi;
use App\Api\VkAds\VkAdsApi;
use App\Models\Target\Client;
use Illuminate\Console\Command;

class DeleteClientToken extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'vk-ads:delete-client-token';

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
    foreach (Client::all() as $client) {
      $auth = new AuthApi();
      $auth->deleteClientToken($client);
    }
  }
}
