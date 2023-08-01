<?php

namespace App\Api\VkAds;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;
use Illuminate\Support\Facades\Log;
use JsonException;
use RuntimeException;

class VkAdsApi
{
  protected int $version = 2;
  protected string $section = '';
  protected bool $isJSON = true;

  private Client $api;

  public function __construct(
    $options = [],
    $token = null
  )
  {
    $token = $token ?? config('vk_ads.token');
    $headers = $options['headers'] ?? [];
    $this->api = new Client([
      ...$options,
      'base_uri' => config('vk_ads.base_url', "https://ads.vk.com/api/") . "v$this->version/",
      'headers' => [
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => "Bearer $token",
        ...$headers
      ],
    ]);
  }

  public function request(string $httpMethod, string $method, array $body = [], array $options = [], $repeat = 3, $delay = 1)
  {
    $requestBody = [
      ...$body
    ];
    $section = $this->section ? "$this->section/" : '';
    $extension = $this->isJSON ? '.json' : '';
    $endpoint = $section . $method . $extension;

    do {
      try {
        $requestType = match (strtolower($httpMethod)) {
          'get' => 'query',
          default => 'form_params'
        };
        $response = $this->api->request($httpMethod, $endpoint, [
          $requestType => $requestBody,
          ...$options
        ])->getBody()->getContents();

        if (!$response) {
          return null;
        }
        return json_decode($response, true, 512, JSON_THROW_ON_ERROR);
      } catch (GuzzleException|RuntimeException|JsonException $e) {
        if ($e->getCode() === 429) {
          $repeat--;
          sleep($delay);
          continue;
        }
        Log::error(
          "VkAdsApi request $endpoint",
          ['message' => $e->getMessage(), 'request' => $requestBody, 'code' => $e->getCode(), 'type' => $e->getTrace()]
        );
        return ['error' => ['message' => $e->getMessage(), 'code' => $e->getCode()]];
      }
    } while ($repeat);
    Log::error("Не удалось отправить запрос $endpoint", [$requestBody]);
    throw new RuntimeException("Не удалось отправить запрос $endpoint", 400);
  }
}
