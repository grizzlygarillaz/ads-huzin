<?php

namespace App\Api\Senler;


use App\Models\Group;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;
use Illuminate\Support\Facades\Log;
use JsonException;
use RuntimeException;

class SenlerApi
{
  private Client $guzzle;
  private int $v = 2;
  private int $vk_group_id;
  private string $access_token;

  public function __construct(
    Group $group = null,
          $options = [])
  {
    if ($group) {
      $this->vk_group_id = $group->id;
      $this->access_token = $group->senler_token;
    }
    $this->guzzle = new Client([
      ...$options,
      'base_uri' => 'https://senler.ru/api/'
    ]);
  }

  public function request(string $section, string $method, array $body, array $options = [], $repeat = 3, $delay = 0.5)
  {
    do {
      try {
        $requestBody = [
          'v' => $this->v,
          'access_token' => $this->access_token,
          'vk_group_id' => $this->vk_group_id,
          ...$body
        ];
        $response = $this->guzzle->post("$section/$method", [
          'form_params' => $requestBody,
          ...$options
        ]);
        $result = json_decode($response->getBody()->getContents(), true, 512, JSON_THROW_ON_ERROR);
        if (array_key_exists('success', $result) && $result['success']) {
          return $result;
        }
        if (array_key_exists('error_code', $result) && $result['error_code'] === 9) {
          $repeat--;
          usleep($delay * 1000000);
          continue;
        }
        throw new RuntimeException($result['error_message'], $result['error_code']);
      } catch (GuzzleException|JsonException|RuntimeException $e) {
        Log::error("Senler request $section/$method", ['message' => $e->getMessage(), 'request' => $requestBody]);
        return ['error' => ['message' => $e->getMessage(), 'code' => $e->getCode()]];
      }
    } while ($repeat);

    Log::error("Не удалось отправить запрос $section/$method", compact('body'));
    throw new RuntimeException("Не удалось отправить запрос $section/$method", 400);
  }

  /**
   * @param int $vk_group_id
   */
  public function setVkGroupId(int $vk_group_id): void
  {
    $this->vk_group_id = $vk_group_id;
  }

  /**
   * @param string $access_token
   */
  public function setAccessToken(string $access_token): void
  {
    $this->access_token = $access_token;
  }
}
