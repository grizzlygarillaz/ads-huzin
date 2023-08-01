<?php

namespace App\Models\Content;

use App\Models\Group;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Story extends Model
{
  use HasFactory;
  protected $guarded = ['created_at', 'updated_at'];
  protected $with = ['content'];

  public function group(): \Illuminate\Database\Eloquent\Relations\BelongsTo
  {
    return $this->belongsTo(Group::class);
  }

  public function createdBy(): \Illuminate\Database\Eloquent\Relations\BelongsTo
  {
    return $this->belongsTo(User::class, 'created_by');
  }

  public function updatedBy(): \Illuminate\Database\Eloquent\Relations\BelongsTo
  {
    return $this->belongsTo(User::class, 'updated_by');
  }

  public function content(): \Illuminate\Database\Eloquent\Relations\BelongsTo
  {
    return $this->belongsTo(Content::class);
  }
}
