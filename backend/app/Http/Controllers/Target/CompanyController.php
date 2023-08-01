<?php

namespace App\Http\Controllers\Target;

use App\Http\Controllers\Controller;
use App\Models\Target\Client;
use App\Models\Target\Company;
use Illuminate\Http\Request;

class CompanyController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index(Client $client)
  {
    return response()->json($client->companies);
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(Request $request, Client $client)
  {
    //
  }

  /**
   * Display the specified resource.
   */
  public function show(Company $company)
  {
    //
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, Company $company)
  {
    //
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(Company $company)
  {
    //
  }
}
