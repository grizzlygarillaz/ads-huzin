<?php

use App\Http\Controllers\Content\ContentController;
use App\Http\Controllers\Content\StoryController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:sanctum'])->prefix('content')->group(function () {
  Route::resource('group.story', StoryController::class)->shallow();

  Route::get('yandex-file', [ContentController::class, 'getFromYandex']);
});
