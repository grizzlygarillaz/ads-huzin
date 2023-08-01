<?php

namespace App\Http\Controllers\Target;

use App\Api\Senler\Subscribers;
use App\Http\Controllers\Controller;
use App\Http\Requests\GroupStoreRequest;
use App\Http\Requests\UpdateGroupequest;
use App\Http\Requests\UpdateGroupRequest;
use App\Models\Group;
use App\Models\Target\Client;
use App\Models\Target\CompanyTemplate;
use Carbon\Carbon;
use Illuminate\Http\Request;

class ClientGroupController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index(Client $client): \Illuminate\Http\JsonResponse
  {
    return response()->json($client->group);
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(GroupStoreRequest $request, Client $client)
  {
    if ($trashed = Group::withTrashed()->find($request->validated('id'))) {
      $trashed->restore();
    }
    $group = Group::updateOrCreate(
      ['id' => $request->validated('id')],
      $request->validated()
    );
    $client->group()->associate($group);
    $client->save();
    return response()->json($group);
  }


  /**
   * Remove the specified resource from storage.
   */
  public function destroy(Client $client, Group $group)
  {
    $client->group()->dissociate();
    return $group->delete();
  }

  public function getSubscribersCount(Group $group, Request $request)
  {
    $validated = $request->validate([
      'date_from' => ['required', 'date'],
      'date_to' => ['required', 'date', 'after:date_from'],
      'subscription_id' => ['array'],
      'subscription_id.*' => ['numeric']
    ]);

    $senler = new Subscribers($group);

    return response()->json($senler->statCount(...$validated));
  }

  public function getSubscribersCountByPeriod(Group $group, Request $request, CompanyTemplate $companyTemplate = null): \Illuminate\Http\JsonResponse
  {
    $validated = $request->validate([
      'date_from' => ['required', 'date'],
      'date_to' => ['required', 'date', 'after:date_from'],
      'period' => ['string']
    ]);

    $result = [];
    $senler = new Subscribers($group);
    $dateFrom = Carbon::parse($validated['date_from']);
    $dateTo = Carbon::parse($validated['date_to']);
    $subscriptionIds = [];
    if ($companyTemplate) {
      if (!$companyTemplate->tags->count()) return response()->json();

      $regex = '/(^|\s)(' . $companyTemplate->tags->pluck('tag')->join('|') . ')/';
      $subGroups = $senler->getSubscribersGroup();
      foreach ($subGroups['items'] as $subGroup) {
        if (preg_match($regex, mb_strtolower($subGroup['name']))) {
          $subscriptionIds[] = $subGroup['subscription_id'];
        }
      }

      if (!$subscriptionIds) return response()->json();
    }

    switch ($validated['period']) {
      case 'day':
      {
        $dateTo = $dateTo->addDay();
        while ($dateFrom->lte($dateTo)) {
          $from = $dateFrom->startOfDay()->format('Y-m-d');
          $to = $dateFrom->endOfDay()->format('Y-m-d H:i:s');
          $result[$from] = $senler->statCount($from, $to, $subscriptionIds);
          $dateFrom->addDay();
        }
        break;
      }
      case 'week' :
      {
        while ($dateFrom->lte($dateTo)) {
          $from = $dateFrom->startOfWeek()->format('Y-m-d');
          $to = $dateFrom->addWeek()->format('Y-m-d');
          $result[$from] = $senler->statCount($from, $to, $subscriptionIds);
        }
        break;
      }
      case 'month' :
      {
        while ($dateFrom->lte($dateTo)) {
          $from = $dateFrom->startOfMonth()->format('Y-m');
          $to = $dateFrom->addMonth()->format('Y-m-d');
          $result[$from] = $senler->statCount($from, $to, $subscriptionIds);
        }
        break;
      }
      default :
      {
        $result[$dateFrom->format('Y-m-d')] = $senler->statCount($dateFrom, $dateTo->endOfDay(), $subscriptionIds);
        break;
      }
    }

    return response()->json($result);
  }

  public function getAllSubscribersCount(Request $request)
  {
    $validated = $request->validate([
      'date_from' => ['required', 'date'],
      'date_to' => ['required', 'date', 'after:date_from'],
      'subscription_id' => ['array'],
      'subscription_id.*' => ['numeric']
    ]);

    $senler = new Subscribers();
    $result = Client::all()->mapWithKeys(function (Client $client) use ($validated, $senler) {
      $group = $client->group;
      if (!$group) {
        return [$client->id => null];
      }
      if (!$group->senler_token) {
        return [$client->id => ['group_id' => $group->id]];
      }
      $senler->setVkGroupId($group->id);
      $senler->setAccessToken($group->senler_token);
      return [$client->id => [...$senler->statCount(...$validated), 'group_id' => $group->id]];
    });

    return response()->json($result);
  }
}
