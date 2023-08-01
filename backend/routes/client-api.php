<?php

use App\Http\Controllers\Target\ClientController;
use App\Http\Controllers\Target\CompanyController;
use App\Http\Controllers\Target\CompanyTemplateController;
use App\Http\Controllers\Target\ClientGroupController;

Route::middleware('token-access')->prefix('guest-stat')->group(function () {
  Route::get('client/{client}', [ClientController::class, 'show']);
  Route::get('client/{client}/stats', [ClientController::class, 'getStatisticByCompanies']);
  Route::get('client/{client}/stats/{companyTemplate}', [ClientController::class, 'getStatisticByCompanies']);

  Route::get('client/{client}/company', [CompanyController::class, 'index']);
  Route::get('company-template', [CompanyTemplateController::class, 'index']);
  Route::get('subscribers_count/{group}/period', [ClientGroupController::class, 'getSubscribersCountByPeriod']);
  Route::get('subscribers_count/{group}/period/{companyTemplate}', [ClientGroupController::class, 'getSubscribersCountByPeriod']);
});
