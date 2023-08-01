<?php

namespace App\Api\Senler;

use App\Models\Group;
use Carbon\Carbon;

class Subscribers extends SenlerApi
{

  public function __construct(Group $group = null, $options = [])
  {
    parent::__construct($group, $options);
  }

  public function statCount($date_from, $date_to, $subscription_id = [])
  {
    $request = [
      'date_from' => Carbon::parse($date_from)->format('d.m.Y H:i:s'),
      'date_to' => Carbon::parse($date_to)->format('d.m.Y H:i:s'),
      'subscription_id' => $subscription_id
    ];

    return $this->request('subscribers', 'statCount', $request);
  }

  public function getSubscribersGroup($count = null, $offset = null)
  {
    $request = [
      'count' => $count,
      'offset' => $offset
    ];

    return $this->request('subscriptions', 'get', $request);
  }

}
