<?php

namespace App\Http\Controllers\Target;

use App\Http\Controllers\Controller;
use App\Models\Target\Client;

class ReportController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function invoice()
  {

    $clients = Client::with(['currentInvoice', 'users'])->get();
    return response()->json($clients);
  }
}
