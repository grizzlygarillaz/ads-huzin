<?php

namespace App\Models\Target;

use Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Carbon;

/**
 * App\Models\CompanyTemplate
 *
 * @property int $id
 * @property string $name
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * @property-read Collection<int, CompanyTemplateTag> $tags
 * @property-read int|null $tags_count
 * @method static Builder|CompanyTemplate newModelQuery()
 * @method static Builder|CompanyTemplate newQuery()
 * @method static Builder|CompanyTemplate query()
 * @method static Builder|CompanyTemplate whereCreatedAt($value)
 * @method static Builder|CompanyTemplate whereId($value)
 * @method static Builder|CompanyTemplate whereName($value)
 * @method static Builder|CompanyTemplate whereUpdatedAt($value)
 * @mixin Eloquent
 */
class CompanyTemplate extends Model
{
  use HasFactory;

  protected $fillable = ['name'];
  protected $with = ['tags'];

  public function tags(): HasMany
  {
    return $this->hasMany(CompanyTemplateTag::class);
  }
}
