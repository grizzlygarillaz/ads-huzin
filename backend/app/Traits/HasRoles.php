<?php

namespace App\Traits;

use App\Models\Role;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

trait HasRoles
{
  public function roles(): BelongsToMany
  {
    return $this->belongsToMany(Role::class);
  }

  public function hasRole(...$roles): bool
  {
    foreach ($roles as $role) {
      if ($this->roles->contains('slug', $role)) {
        return true;
      }
    }

    return false;
  }

  public function addRoles(...$slugs): void
  {
    $roles = Role::whereIn('slug', $slugs)->get();

    if (!$roles->count()) return;

    $this->roles()->syncWithoutDetaching($roles->pluck('id'));
  }

  public function removeRoles(...$slugs): void
  {
    $roles = Role::whereIn('slug', $slugs)->get();

    if (!$roles->count()) return;

    $this->roles()->detach($roles->pluck('id'));
  }
}
