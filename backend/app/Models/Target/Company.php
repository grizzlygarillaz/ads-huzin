<?php

namespace App\Models\Target;

use Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Carbon;

/**
 * App\Models\Company
 *
 * @property int $id
 * @property string $name
 * @property int $status
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * @method static Builder|Company newModelQuery()
 * @method static Builder|Company newQuery()
 * @method static Builder|Company query()
 * @method static Builder|Company whereCreatedAt($value)
 * @method static Builder|Company whereId($value)
 * @method static Builder|Company whereName($value)
 * @method static Builder|Company whereStatus($value)
 * @method static Builder|Company whereUpdatedAt($value)
 * @property int $client_id
 * @method static Builder|Company whereClientId($value)
 * @mixin Eloquent
 */
class Company extends Model
{
  protected $guarded = ['created_at', 'updated_at'];
  use HasFactory;
}
