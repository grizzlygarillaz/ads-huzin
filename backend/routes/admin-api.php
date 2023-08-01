<?php

Route::middleware(['auth:sanctum', 'role:admin'])->prefix('admin')->group(function () {
  Route::get('report/invoice', [\App\Http\Controllers\Target\ReportController::class, 'invoice']);
});
