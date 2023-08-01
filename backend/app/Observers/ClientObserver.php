<?php

namespace App\Observers;

use App\Models\Target\Client;
use Str;

class ClientObserver
{
  /**
   * Handle the Client "created" event.
   */
  public function created(Client $client): void
  {
    if (!$client->token) {
      $client->token = Str::random(128);
      $client->save();
    }
  }

  /**
   * Handle the Client "updated" event.
   */
  public function updated(Client $client): void
  {
    //
  }

  /**
   * Handle the Client "deleted" event.
   */
  public function deleted(Client $client): void
  {
    //
  }

  /**
   * Handle the Client "restored" event.
   */
  public function restored(Client $client): void
  {
    //
  }

  /**
   * Handle the Client "force deleted" event.
   */
  public function forceDeleted(Client $client): void
  {
    //
  }
}
