<?php

namespace App\Models\Target;

use App\Models\Group;
use App\Models\User;
use Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Carbon;

/**
 * App\Models\Target\Client
 *
 *
 * @property int $id
 * @property string $name
 * @property int|null $balance
 * @property int $critical_balance
 * @property int|null $all_limit
 * @property int|null $day_limit
 * @property int|null $day_spent
 * @property int|null $week_spent
 * @property int|null $month_spent
 * @property int $month_plan
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * @method static Builder|Client newModelQuery()
 * @method static Builder|Client newQuery()
 * @method static Builder|Client query()
 * @method static Builder|Client whereAllLimit($value)
 * @method static Builder|Client whereBalance($value)
 * @method static Builder|Client whereCreatedAt($value)
 * @method static Builder|Client whereCriticalBalance($value)
 * @method static Builder|Client whereDayLimit($value)
 * @method static Builder|Client whereDaySpent($value)
 * @method static Builder|Client whereId($value)
 * @method static Builder|Client whereMonthPlan($value)
 * @method static Builder|Client whereMonthSpent($value)
 * @method static Builder|Client whereName($value)
 * @method static Builder|Client whereUpdatedAt($value)
 * @method static Builder|Client whereWeekSpent($value)
 * @property-read Collection<int, Group> $groups
 * @property-read int|null $groups_count
 * @property int $active
 * @property-read Collection<int, Company> $companies
 * @property-read int|null $companies_count
 * @property-read bool $is_mine
 * @property-read Collection<int, User> $users
 * @property-read int|null $users_count
 * @method static Builder|Client whereActive($value)
 * @mixin Eloquent
 */
class Client extends Model
{
  use HasFactory, Notifiable;

  protected $guarded = ['created_at', 'updated_at'];
  protected $appends = ['is_mine', 'has_telegram'];

  protected static function booted(): void
  {
    static::addGlobalScope('active', function (Builder $builder) {
      $builder->where('is_active', true);
    });
  }

  public function companies(): HasMany
  {
    return $this->hasMany(Company::class);
  }

  public function getIsMineAttribute(): bool
  {
    if (!request()->user()) {
      return false;
    }
    return (bool)$this->users()->find(request()->user()->id);
  }

  public function users(): BelongsToMany
  {
    return $this->belongsToMany(User::class);
  }

  public function group(): \Illuminate\Database\Eloquent\Relations\BelongsTo
  {
    return $this->belongsTo(Group::class);
  }

  public function botChats(): BelongsToMany
  {
    return $this->belongsToMany(BotChat::class);
  }

  public function invoices(): HasMany
  {
    return $this->hasMany(Invoice::class);
  }

  protected function timezone(): Attribute
  {
    return Attribute::get(
      fn(int|null $value) => $value === null ? $this->group->timezone : $value
    );
  }

  public function currentInvoice(): \Illuminate\Database\Eloquent\Relations\BelongsTo
  {
    return $this->belongsTo(Invoice::class, 'current_invoice_id');
  }

  public function getHasTelegramAttribute(): bool
  {
    return (bool)$this->botChats()->count();
  }
}
