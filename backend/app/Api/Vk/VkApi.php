<?php

namespace App\Api\Vk;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;
use Illuminate\Support\Facades\Log;
use JsonException;
use RuntimeException;

class VkApi
{
  private Client $client;
  private float $version;

  public function __construct(
    protected string $section = '',
                     $options = [],
  )
  {
    $token = config('vk.token');
    $headers = $options['headers'] ?? [];
    $this->client = new Client([
      ...$options,
      'base_uri' => config('vk.base_url', 'https://api.vk.com/method/'),
      'headers' => ['Content-Type' => 'application/x-www-form-urlencoded', 'Authorization' => "Bearer $token", ...$headers],
    ]);
    $this->version = config('vk.api_version', '5.131');
  }

  public function request(string $httpMethod, string $method, array $body, array $options = [], $repeat = 3, $delay = 1)
  {
    $requestBody = [
      'v' => $this->version,
      ...$body
    ];
    do {
      try {
        $response = $this->client->request($httpMethod, "$this->section.$method", [
          'form_params' => $requestBody,
          ...$options
        ]);
        $result = json_decode($response->getBody()->getContents(), true, 512, JSON_THROW_ON_ERROR);
        if (array_key_exists('response', $result)) {
          return $result['response'];
        }
        $errorCode = $result['error']['error_code'];
        if ($errorCode === 9 || $errorCode === 6) {
          $repeat--;
          sleep($delay);
          continue;
        }
        throw new RuntimeException($result['error']['error_msg'], $result['error']['error_code']);
      } catch (GuzzleException|JsonException|RuntimeException $e) {
        Log::error("VkApi request $this->section.$method", ['message' => $e->getMessage()]);
        return ['error' => ['message' => $e->getMessage(), 'code' => $e->getCode()]];
      }
    } while ($repeat);
    Log::error("Не удалось отправить запрос $this->section.$method", [$requestBody]);
    throw new RuntimeException("Не удалось отправить запрос $this->section.$method", 400);
  }

  public function getContent(string $method, array $body)
  {
    $token = config('vk.token');
    $request = "https://api.vk.com/method/{$this->section}.$method/?access_token={$token}&v={$this->version}&" . http_build_query($body);
    try {
      $requestResult = json_decode(file_get_contents($request), true, 512, JSON_THROW_ON_ERROR);
      info('VKApi getContents', [$requestResult]);
      return $requestResult['response'];
    } catch (JsonException|RuntimeException $e) {
      return ['error' => ['message' => $e->getMessage(), 'code' => $e->getCode()]];
    }
  }

  public function getGuzzleClient(): Client
  {
    return $this->client;
  }
}
