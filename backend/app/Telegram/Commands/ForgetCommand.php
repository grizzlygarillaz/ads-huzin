<?php


namespace App\Telegram\Commands;


use App\Models\Target\BotChat;
use App\Models\Target\Client;
use App\Models\User;
use App\Telegram\CustomCommand;
use Longman\TelegramBot\Entities\ServerResponse;

class ForgetCommand extends CustomCommand
{

  /** @var string Command name */
  protected $name = 'forget';
  /** @var string Command description */
  protected $description = '';
  /** @var string Usage description */
  protected $usage = '/forget';
  /** @var string Version */
  protected $version = '1.0.0';

  public function execute(): ServerResponse
  {
    $message = $this->getMessage();

    if (!User::where('telegram', $message->getFrom()->getUsername())->count()) {
      return $this->replyToChat('У вас нет доступа к этой команде 🤷‍');
    }

    $params = $this->getParams();
    $clientId = $params['client_id'] ?? null;
    $chatId = $message->getChat()->getId();
    $chat = BotChat::find($chatId);

    if ($clientId === null && $chat) {
      $chat->clients()->detach();
      return $this->replyToChat("Все клиенты убраны из уведомлений в этом чате", [
        'parse_mode' => 'markdown'
      ]);
    }

    $client = Client::find($clientId);

    if (!$client) {
      return $this->replyToChat('Клиент не найден 🙈');
    }

    if ($client->botChats()->find($chatId)) {
      $client->botChats()->detach($chatId);
      return $this->replyToChat("Клиент *{$client->name}* убран из уведомлений в этом чате", [
        'parse_mode' => 'markdown'
      ]);
    }

    return $this->replyToChat("Клиент и так не получает уведомления в этом чате", [
      'parse_mode' => 'markdown'
    ]);
  }
}
