<?php


namespace App\Telegram\Commands;


use App\Models\Target\Client;
use App\Models\User;
use App\Telegram\CustomCommand;
use Longman\TelegramBot\Entities\ServerResponse;

class RegisterCommand extends CustomCommand
{

  /** @var string Command name */
  protected $name = 'register';
  /** @var string Command description */
  protected $description = '';
  /** @var string Usage description */
  protected $usage = '/register <client_id>';

  protected $params = ['client_id'];

  /** @var string Version */
  protected $version = '1.0.0';

  public function execute(): ServerResponse
  {
    $message = $this->getMessage();
    $user = User::firstWhere('telegram', $message->getFrom()->getUsername());

    if (!$user) {
      return $this->replyToChat('У вас нет доступа к этой команде 🤷‍');
    }

    $params = $this->getParams();
    if (!$params) {
      return $this->replyToChat('Не удалось найти параметры для команды 🔍');
    }

    $client = Client::find($this->getParams()['client_id']);
    if (!$client) {
      return $this->replyToChat('Клиент не найден 🙈');
    }

    if (!$client->users()->find($user->id)) {
      $client->users()->attach($user->id);
    }
    $chatId = $message->getChat()->getId();

    if ($client->botChats()->find($chatId)) {
      return $this->replyToChat("*$client->name* уже зарегистрирован 👌", [
        'parse_mode' => 'markdown'
      ]);
    }

    $client->botChats()->attach($chatId);

    return $this->replyToChat("Клиент *$client->name* зарегистрирован 👏", [
      'parse_mode' => 'markdown'
    ]);
  }

}
