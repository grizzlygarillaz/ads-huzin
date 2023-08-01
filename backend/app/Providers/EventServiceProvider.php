<?php

namespace App\Providers;

use App\Models\Content\Content;
use App\Models\Target\Client;
use App\Models\Target\Invoice;
use App\Observers\ClientObserver;
use App\Observers\ContentObserver;
use App\Observers\InvoiceObserver;
use Illuminate\Auth\Events\Registered;
use Illuminate\Auth\Listeners\SendEmailVerificationNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
  /**
   * The event to listener mappings for the application.
   *
   * @var array<class-string, array<int, class-string>>
   */
  protected $listen = [
    Registered::class => [
      SendEmailVerificationNotification::class,
    ],
  ];

  /**
   * Register any events for your application.
   */
  public function boot(): void
  {
    Client::observe(ClientObserver::class);
    Invoice::observe(InvoiceObserver::class);
    Content::observe(ContentObserver::class);
  }

  /**
   * Determine if events and listeners should be automatically discovered.
   */
  public function shouldDiscoverEvents(): bool
  {
    return false;
  }
}
