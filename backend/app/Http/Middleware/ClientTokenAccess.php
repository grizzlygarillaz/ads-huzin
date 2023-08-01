<?php

namespace App\Http\Middleware;

use App\Models\Target\Client;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ClientTokenAccess
{
  /**
   * Handle an incoming request.
   *
   * @param Closure(Request): (Response) $next
   */
  public function handle(Request $request, Closure $next): Response
  {
    $client = Client::find($request->cookie('guest_client'));
    if ($client && $client->token === $request->cookie('guest_token')) {
      return $next($request);
    }
    return \response()->json('Нет доступа!', 401);
  }
}
