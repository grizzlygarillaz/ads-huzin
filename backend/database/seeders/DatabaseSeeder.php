<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\Role;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
  /**
   * Seed the application's database.
   */
  public function run(): void
  {
    Role::upsert([
      ['slug' => 'admin', 'name' => 'Администратор'],
      ['slug' => 'manager', 'name' => 'Менеджер'],
      ['slug' => 'accountant', 'name' => 'Бухгалтер'],
      ['slug' => 'content', 'name' => 'Контент'],
    ],
      'slug',
      ['name']
    );

    if (env('APP_ENV') === 'local') {
      $user = User::updateOrCreate([
        'email' => 'test@example.com',
        'login' => 'test',
      ], [
        'name' => 'Test User',
        'email_verified_at' => now(),
        'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
        'remember_token' => Str::random(10),
        'telegram' => 'AdelZar1pov'
      ]);

      $user->addRoles('admin');
    }
  }
}
