<?php

namespace App\Models;

use App\Models\Content\Story;
use App\Models\Target\Client;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * App\Models\Group
 *
 * @property int $id
 * @property string $name
 * @property string $link
 * @property string $screen_name
 * @property string|null $city
 * @property int|null $timezone
 * @property string|null $senler_token
 * @property string|null $photo
 * @property int $client_id
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Target\Client|null $client
 * @method static \Illuminate\Database\Eloquent\Builder|Group newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Group newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Group query()
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereCity($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereClientId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereLink($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group wherePhoto($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereScreenName($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereSenlerToken($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereTimezone($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereUpdatedAt($value)
 * @property string|null $site
 * @property-read string|null $senler_token_protected
 * @method static \Illuminate\Database\Eloquent\Builder|Group whereSite($value)
 * @mixin \Eloquent
 */
class Group extends Model
{
  use HasFactory, SoftDeletes;

  protected $guarded = ['created_at', 'updated_at'];
  protected $appends = ['senler_token_protected'];
  protected $hidden = ['senler_token'];

  public function client(): \Illuminate\Database\Eloquent\Relations\BelongsTo
  {
    return $this->belongsTo(Client::class);
  }

  public function getSenlerTokenProtectedAttribute(): ?string
  {
    return $this->senler_token ? substr_replace($this->senler_token, '****', 4, -4) : null;
  }

  public function stories(): \Illuminate\Database\Eloquent\Relations\HasMany
  {
    return $this->hasMany(Story::class);
  }

  public function linkedToGroups(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
  {
    return $this->belongsToMany(self::class, 'linked_groups', 'parent_id', 'child_id');
  }

  public function linkedGroups(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
  {
    return $this->belongsToMany(self::class, 'linked_groups', 'child_id', 'parent_id');
  }
}
