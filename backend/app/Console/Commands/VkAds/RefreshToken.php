<?php

namespace App\Console\Commands\VkAds;

use App\Api\VkAds\AuthApi;
use App\Models\Target\Client;
use Illuminate\Console\Command;

class RefreshToken extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'vk-ads:refresh-token {client?}';

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
    $authApi = new AuthApi();
    $clients = $this->argument('client') ? Client::whereId($this->argument('client'))->get() : Client::all();
    foreach ($clients as $client) {
      $newTokens = $authApi->refreshToken($client->ads_refresh_token);
      $client->ads_token = $newTokens['access_token'];
      $client->ads_refresh_token = $newTokens['refresh_token'];
      $client->save();
    }

    return Command::SUCCESS;
  }
}
