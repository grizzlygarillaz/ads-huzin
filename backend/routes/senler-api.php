<?php

Route::middleware(['auth:sanctum'])->prefix('senler')->group(static function () {
  Route::get('/client/{client}/statCount', []);
});
