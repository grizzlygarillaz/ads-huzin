<?php

namespace App\Api\VkAds;

use Carbon\Carbon;

class StatisticsApi extends VkAdsApi
{
  protected string $section = 'statistics';

  public function getClientsStatisticByDay(
    string       $dateFrom,
    string       $dateTo,
    array|string $ids = [],
    array|string $metrics = 'base',
  )
  {
    return $this->getStatistic('users', 'day', $dateFrom, $dateTo, $ids, $metrics);
  }

  public function getStatistic(
    string       $idsType,
    string       $period,
    string       $dateFrom = 'now',
    string       $dateTo = 'now',
    array|string $ids = [],
    array|string $metrics = 'base',
  )
  {
    $data = [
      'id' => is_array($ids) ? implode(',', $ids) : $ids,
      'metrics' => is_array($metrics) ? implode(',', $metrics) : $metrics,
    ];
    if ($period === 'day') {
      $data = [
        ...$data,
        'date_from' => Carbon::parse($dateFrom)->format('Y-m-d'),
        'date_to' => Carbon::parse($dateTo)->format('Y-m-d'),
      ];
    }
    return $this->request('GET', "$idsType/$period", $data);
  }

  public function getCompaniesStatisticByDay(
    string       $dateFrom,
    string       $dateTo,
    array|string $ids = [],
    array|string $metrics = 'base',
  )
  {
    return $this->getStatistic('ad_plans', 'day', $dateFrom, $dateTo, $ids, $metrics);
  }

  public function getClientsStatisticOverall(
    array|string $ids = [],
    array|string $metrics = 'base',
  )
  {
    return $this->getStatistic('users', 'summary', ids: $ids, metrics: $metrics);
  }
}
