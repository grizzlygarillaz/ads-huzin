<?php

Route::middleware(['auth:sanctum'])
  ->post('/vk_method/{section}.{method}', [\App\Http\Controllers\Controller::class, 'VkMethodCall']);

Route::prefix('/vk-api')->group(function () {
  Route::get('resolveScreenName/{screenName}', [\App\Api\Vk\Utils::class, 'resolveScreenName']);
});
