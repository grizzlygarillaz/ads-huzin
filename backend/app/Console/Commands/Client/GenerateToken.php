<?php

namespace App\Console\Commands\Client;

use App\Models\Target\Client;
use Illuminate\Console\Command;
use Str;

class GenerateToken extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'client:generate-token';

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
    Client::all()->each(function (Client $client) {
      $client->token = Str::random(128);
      $client->save();
    });
  }
}
