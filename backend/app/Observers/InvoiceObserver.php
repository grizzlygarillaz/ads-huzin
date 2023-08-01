<?php

namespace App\Observers;

use App\Models\Target\Invoice;
use Illuminate\Support\Facades\Storage;

class InvoiceObserver
{
  /**
   * Handle the Invoice "created" event.
   */
  public function created(Invoice $invoice): void
  {
    //
  }

  /**
   * Handle the Invoice "updated" event.
   */
  public function updated(Invoice $invoice): void
  {
    //
  }

  /**
   * Handle the Invoice "deleted" event.
   */
  public function deleted(Invoice $invoice): void
  {
    Storage::fileExists($invoice->path) && Storage::delete($invoice->path);
  }

  /**
   * Handle the Invoice "restored" event.
   */
  public function restored(Invoice $invoice): void
  {
    //
  }

  /**
   * Handle the Invoice "force deleted" event.
   */
  public function forceDeleted(Invoice $invoice): void
  {
    //
  }
}
