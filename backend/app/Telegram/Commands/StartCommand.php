<?php


namespace App\Telegram\Commands;


use App\Models\User;
use App\Telegram\CustomCommand;
use Longman\TelegramBot\Entities\ServerResponse;

class StartCommand extends CustomCommand
{

  /** @var string Command name */
  protected $name = 'start';
  /** @var string Command description */
  protected $description = 'Start';
  /** @var string Usage description */
  protected $usage = '/start';
  /** @var string Version */
  protected $version = '1.0.0';

  public function execute(): ServerResponse
  {
    $chat = $this->getMessage()->getChat();
    if ($chat->getType() !== 'private') {
      return $this->replyToChat('Эта команда работает в личных сообщениях 👉👈');
    }

    $userName = $chat->getUsername();
    $user = User::where('telegram', $userName)->first();
    $text = "Я не смог найти вас в системе 👀
Пожалуйста, обратитесь к администратору";

    if ($user) {
      $text = "Привет, {$user->name} 👋
Теперь я буду отправлять тебе важную информацию";

      $user->chat_id = $chat->getId();
      $user->save();
    }

    return $this->replyToChat($text, [
      'parse_mode' => 'markdown'
    ]);
  }

}
