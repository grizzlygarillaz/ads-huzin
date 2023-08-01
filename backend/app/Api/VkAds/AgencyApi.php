<?php

namespace App\Api\VkAds;

class AgencyApi extends VkAdsApi
{
  protected string $section = 'agency';

  public function getClients(int $offset = 0, int $limit = 50, array $filters = [])
  {
    return $this->request('GET', 'clients', [
      'limit' => $limit,
      'offset' => $offset,
      ...$filters
    ]);
  }
}
