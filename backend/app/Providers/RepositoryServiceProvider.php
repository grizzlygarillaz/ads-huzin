<?php

namespace App\Providers;

use App\Interfaces\ContentRepositoryInterface;
use App\Repositories\ContentRepository;
use Illuminate\Support\ServiceProvider;

class RepositoryServiceProvider extends ServiceProvider
{
  /**
   * Register services.
   */
  public function register(): void
  {
    $this->app->bind(ContentRepositoryInterface::class, ContentRepository::class);
  }

  /**
   * Bootstrap services.
   */
  public function boot(): void
  {
    //
  }
}
