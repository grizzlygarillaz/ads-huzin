<?php

namespace App\Models\Target;

use Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Carbon;

/**
 * App\Models\CompanyTemplateTag
 *
 * @property int $id
 * @property int $company_template_id
 * @property string $tag
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * @method static Builder|CompanyTemplateTag newModelQuery()
 * @method static Builder|CompanyTemplateTag newQuery()
 * @method static Builder|CompanyTemplateTag query()
 * @method static Builder|CompanyTemplateTag whereCompanyTemplateId($value)
 * @method static Builder|CompanyTemplateTag whereCreatedAt($value)
 * @method static Builder|CompanyTemplateTag whereId($value)
 * @method static Builder|CompanyTemplateTag whereTag($value)
 * @method static Builder|CompanyTemplateTag whereUpdatedAt($value)
 * @mixin Eloquent
 */
class CompanyTemplateTag extends Model
{
  use HasFactory;

  protected $fillable = ['tag'];

  protected function tag(): Attribute
  {
    return Attribute::make(
      get: fn(string $value) => mb_strtolower($value),
      set: fn(string $value) => mb_strtolower($value),
    );
  }
}
