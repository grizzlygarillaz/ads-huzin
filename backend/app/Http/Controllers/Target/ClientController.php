<?php

namespace App\Http\Controllers\Target;

use App\Api\Vk\Ads;
use App\Api\VkAds\StatisticsApi;
use App\Http\Controllers\Controller;
use App\Models\Target\Client;
use App\Models\Target\Company;
use App\Models\Target\CompanyTemplate;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ClientController extends Controller
{

  /**
   * Display a listing of the resource.
   */
  public function index(Request $request): JsonResponse
  {
    $validate = $request->validate([
      'user_id' => ['exists:App\Models\User,id', 'nullable'],
      'with' => ['array'],
      'with.*' => ['string']
    ]);

    $with = array_key_exists('with', $validate) ? $validate['with'] : [];

    if (array_key_exists('user_id', $validate)) {
      return response()->json(User::find($validate['user_id'])->clients()->with($with)->get());
    }

    return response()->json(Client::with($with)->orderBy('name')->get());
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(Request $request)
  {
    //
  }

  /**
   * Display the specified resource.
   */
  public function show(Client $client)
  {
    return response()->json($client);
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, Client $client): JsonResponse
  {
    $validated = $request->validate([
//      'name' => ['string', 'max:50'],
//      'balance' => ['numeric'],
      'critical_balance' => ['numeric'],
//      'all_limit' => ['numeric'],
//      'day_limit' => ['numeric'],
//      'day_spent' => ['numeric'],
//      'week_spent' => ['numeric'],
//      'month_spent' => ['numeric'],
      'month_plan' => ['numeric'],
      'budget_adjustment' => ['numeric']
    ]);

    $client->update($validated);

    return response()->json($client);
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(Client $client)
  {
    //
  }

  public function getStatistic(Client $client, Request $request): JsonResponse
  {
    $validated = $request->validate([
      'period' => ['required', 'string'],
      'date_from' => ['required', 'date'],
      'date_to' => ['required', 'date', 'after:date_from']
    ]);

    $api = new Ads();
    $response = $api->getStatistics(
      'client',
      $client->id,
      ...$validated
    );

    return response()->json($response[0]['stats']);
  }


  public function getAllStatistics(Request $request)
  {
    $validatedBody = $request->validate([
      'period' => ['required', 'string'],
      'date_from' => ['required', 'date'],
      'date_to' => ['required', 'date', 'after:date_from']
    ]);
    $validatedOptions = $request->validate([
      'only_field' => ['array'],
      'only_field.*' => ['string']
    ]);

    $api = new Ads();
    $response = $api->getStatistics(
      'client',
      Client::all()->pluck('id')->join(','),
      ...$validatedBody
    );

    if (!$validatedOptions) {
      return response()->json($response);
    }

    foreach ($response as $clientKey => $client) {
      foreach ($client['stats'] as $statKey => $stat) {
        $result = [];
        foreach ($validatedOptions['only_field'] as $field) {
          if (array_key_exists($field, $stat)) {
            $result[$field] = $stat[$field];
          }
        }
        $response[$clientKey]['stats'][$statKey] = $result;
      }
    }
    return response()->json($response);
  }

  public function getStatisticByCompanies(Client $client, Request $request, ?CompanyTemplate $companyTemplate = null)
  {
    $validated = $request->validate([
      'period' => ['required', 'string'],
      'date_from' => ['required', 'date'],
      'date_to' => ['required', 'date', 'after:date_from']
    ]);

    if ($companyTemplate) {
      if (!$companyTemplate->tags->count()) return response()->json();

      $regex = '/(^|\s)(' . $companyTemplate->tags->pluck('tag')->join('|') . ')/';
      $companies = $client->companies->filter(function (Company $company) use ($regex) {
        return (bool)preg_match($regex, mb_strtolower($company->name));
      });
    } else {
      $companies = $client->companies;
    }

    if (!$companies->count()) {
      return response()->json();
    }

    $api = new Ads();
    $response = $api->getStatistics(
      'campaign',
      $companies->pluck('id')->join(','),
      ...$validated
    );


    return response()->json($response);
  }

  public function toggleWatcher(Client $client, User $user): \Illuminate\Foundation\Application|\Illuminate\Http\Response|\Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\Routing\ResponseFactory
  {
    $toggled = $client->users()->toggle($user->id);
    return response((bool)$toggled['attached']);
  }

  public function updateRecommendation(Client $client, Request $request): JsonResponse
  {
    $validated = $request->validate([
      'is_budget_agreed' => ['boolean'],
      'recommended_budget' => ['numeric', 'nullable']
    ]);

    $client->update($validated);
    $client->save();

    return response()->json($client);
  }
}
