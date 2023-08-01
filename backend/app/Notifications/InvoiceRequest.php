<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use NotificationChannels\Telegram\TelegramFile;

class InvoiceRequest extends Notification
{
  use Queueable;

  /**
   * Create a new notification instance.
   */
  public function __construct()
  {
    //
  }

  /**
   * Get the notification's delivery channels.
   *
   * @return array<int, string>
   */
  public function via(object $notifiable): array
  {
    return ['telegram'];
  }

  /**
   * Get the mail representation of the notification.
   */
  public function toTelegram(object $notifiable): MailMessage
  {

    $chats = property_exists($notifiable, 'botChats') && $notifiable->botChats;
    $message = "Счёт 80 т  таргет РК ВК ИП Габдулхаев Окинава Нефтекамск";
    if ($chats) {
      foreach ($chats as $chat) {
        return TelegramFile::create()->to($chat->id)->content('⬆️ ');
      }
    }
  }

}
