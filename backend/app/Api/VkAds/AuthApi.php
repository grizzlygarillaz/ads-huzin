<?php

namespace App\Api\VkAds;

use App\Models\Target\Client;

class AuthApi extends VkAdsApi
{
  protected string $section = 'oauth2';

  public function auth(string $agency = null, $grant_type = 'agency_client_credentials')
  {
    return $this->request('POST', 'token', [
      'grant_type' => $grant_type,
      'client_id' => config('vk_ads.client_id'),
      'client_secret' => config('vk_ads.client_secret'),
      'agency_client_id' => $agency ?? config('vk_ads.agency_id'),
    ]);
  }

  public function refreshToken($refreshToken)
  {
    return $this->request('POST', 'token', [
      'grant_type' => 'refresh_token',
      'client_id' => config('vk_ads.client_id'),
      'client_secret' => config('vk_ads.client_secret'),
      'refresh_token' => $refreshToken
    ]);
  }

  public function deleteClientToken(Client $client)
  {
    return $this->request('POST', 'token/delete', [
      'client_id' => config('vk_ads.client_id'),
      'client_secret' => config('vk_ads.client_secret'),
      'user_id' => $client->id
    ]);
  }
}
