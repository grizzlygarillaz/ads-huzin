<?php

namespace App\Api\Vk;

class Utils extends VkApi
{
  protected string $section = 'utils';

  public function resolveScreenName($screenName)
  {
    $response = $this->request('POST', 'resolveScreenName', [
      'screen_name' => $screenName
    ]);
    return response()->json($response);
  }
}
