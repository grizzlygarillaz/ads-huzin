<?php

namespace App\Telegram;

use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;

abstract class CustomCommand extends \Longman\TelegramBot\Commands\UserCommand
{
  protected $params = [];
  /**
   * @inheritDoc
   */
  protected function getParams(): bool|array
  {
    info('Telegram get params', [$this->getMessage()->getText()]);
    $paramsCount = count($this->params);
    if (!$paramsCount) {
      return true;
    }
    $text = preg_replace('/\s+/', ' ', trim($this->getMessage()->getText(true)));
    $words = $text ? explode(' ', $text) : [];
    if (count($words) < $paramsCount) {
      return false;
    }
    $paramsValue = [];

    foreach ($this->params as $key => $param) {
      $paramsValue[$param] = $words[$key];
    }
    return $paramsValue;
  }
}
