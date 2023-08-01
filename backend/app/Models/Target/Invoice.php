<?php

namespace App\Models\Target;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Invoice extends Model
{
  use HasFactory;

  protected $guarded = ['id', 'created_at', 'updated_at'];
  protected $with = ['client'];

  public function client(): \Illuminate\Database\Eloquent\Relations\BelongsTo
  {
    return $this->belongsTo(Client::class);
  }

  protected function description(): Attribute
  {
    return Attribute::make(get: fn ($value) => $value ?: '');
  }
}
