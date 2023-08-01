<?php

namespace App\Console\Commands;

use App\Models\Target\Client;
use Illuminate\Console\Command;

class MigrateGroups extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'app:migrate-groups';

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
      $group = $client->groups()->first();
      if (!$group) continue;
      $client->group_id = $group->id;
      $client->save();
    }
  }
}
