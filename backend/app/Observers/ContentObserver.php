<?php

namespace App\Observers;

use App\Models\Content\Content;
use Illuminate\Support\Facades\Storage;

class ContentObserver
{
  /**
   * Handle the Content "created" event.
   */
  public function created(Content $content): void
  {
    //
  }

  /**
   * Handle the Content "updated" event.
   */
  public function updated(Content $content): void
  {
    //
  }

  /**
   * Handle the Content "deleted" event.
   */
  public function deleted(Content $content): void
  {
    $storage = Storage::disk('public');
    info('removing', [
      $storage->fileExists($content->path),
      $storage->path($content->path)
    ]);
    $storage->fileExists($content->path) && $storage->delete($content->path);
  }

  /**
   * Handle the Content "restored" event.
   */
  public function restored(Content $content): void
  {
    //
  }

  /**
   * Handle the Content "force deleted" event.
   */
  public function forceDeleted(Content $content): void
  {
    //
  }
}
