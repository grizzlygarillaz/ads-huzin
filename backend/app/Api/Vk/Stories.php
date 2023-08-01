<?php

namespace App\Api\Vk;

class Stories extends VkApi
{
  protected string $section = 'stories';

  public function __construct($options = [], $version = 5.131)
  {
    parent::__construct($this->section, $options, $version);
  }

  public function getPhotoUploadServer($groupId = null, $addToNews = false)
  {
    return $this->getUploadServer('getPhotoUploadServer', $groupId, $addToNews);
  }

  public function getVideoUploadServer($groupId = null, $addToNews = false)
  {
    return $this->getUploadServer('getVideoUploadServer', $groupId, $addToNews);
  }

  public function save($upload_results)
  {
    $data = [
      'upload_results' => $upload_results,
    ];

    return $this->request('POST', 'save', $data);
  }

  private function getUploadServer($method, $groupId = null, $addToNews = false)
  {
    $data = [
      'group_id' => $groupId,
      'add_to_news' => $addToNews,
      'link_text' => 'order',
      'link_url' => "https://vk.com/market-$groupId"
    ];

    return $this->request('POST', $method, $data);
  }
}
