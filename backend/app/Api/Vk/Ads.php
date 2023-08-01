<?php

namespace App\Api\Vk;

use Carbon\Carbon;

class Ads extends VkApi
{
  protected string $section = 'ads';

  public function __construct(protected ?int $agency = null, $options = [], $version = 5.131)
  {
    $this->agency = $agency ?? config('vk.agency_id');
    parent::__construct($this->section, $options, $version);
  }

  public function getClients()
  {
    $body = [
      'account_id' => $this->agency
    ];
    return $this->request('POST', 'getClients', $body);
  }

  public function getStatistics(
    string $ids_type,
    string $ids,
    string $period,
    string $date_from,
    string $date_to
  )
  {
    $dateFormat = match ($period) {
      'day', 'week' => 'Y-m-d',
      'month' => 'Y-m',
      'year' => 'Y',
      default => 0
    };

    $body = [
      'account_id' => $this->agency,
      'ids_type' => $ids_type,
      'ids' => $ids,
      'period' => $period,
      'date_from' => Carbon::parse($date_from)->format($dateFormat),
      'date_to' => Carbon::parse($date_to)->format($dateFormat),
    ];

    return $this->request('POST', 'getStatistics', $body);
  }

  public function getCampaigns(int $clientId, bool $includeDeleted = false)
  {
    $body = [
      'account_id' => $this->agency,
      'client_id' => $clientId,
      'include_deleted' => (int)$includeDeleted
    ];

    return $this->request('POST', 'getCampaigns', $body);
  }

  public function updateClient(array $data)
  {
    $body = [
      'account_id' => $this->agency,
      'data' => json_encode([$data])
    ];

    return $this->request('POST', 'updateClients', $body);
  }
}
