<?php

namespace App\Models\Target;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BotChat extends Model
{
  use HasFactory;

  protected $table = 'bot_chat';

  public function clients(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
  {
    return $this->belongsToMany(Client::class);
  }
}
