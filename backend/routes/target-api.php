<?php

use App\Http\Controllers\Target\ClientController;
use App\Http\Controllers\Target\CompanyController;
use App\Http\Controllers\Target\CompanyTemplateController;
use App\Http\Controllers\Target\ClientGroupController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:sanctum', 'role:manager,accountant'])->prefix('target')->group(function () {
  Route::resource('client', ClientController::class);
  Route::patch('client/{client}/watcher/{user}', [ClientController::class, 'toggleWatcher']);

  Route::get('statistic/client/{client}', [ClientController::class, 'getStatisticByCompanies']);
  Route::get('statistic/client/{client}/template/{companyTemplate}', [ClientController::class, 'getStatisticByCompanies']);
  Route::get('statistic/client', [ClientController::class, 'getAllStatistics']);

  Route::resource('client.group', ClientGroupController::class)->except(['update', 'show']);
  Route::get('senler/subscribers_count/{group}', [ClientGroupController::class, 'getSubscribersCount']);
  Route::get('senler/subscribers_count/{group}/period', [ClientGroupController::class, 'getSubscribersCountByPeriod']);
  Route::get('senler/subscribers_count', [ClientGroupController::class, 'getAllSubscribersCount']);

  Route::resource('client.company', CompanyController::class)->shallow();
  Route::resource('company-template', CompanyTemplateController::class);
  Route::post('company-template/{companyTemplate}/tag', [CompanyTemplateController::class, 'storeTags']);
  Route::patch('client/{client}/recommendation', [ClientController::class, 'updateRecommendation']);

  Route::get('invoice/client/{client}/current', [\App\Http\Controllers\Target\InvoiceController::class, 'showCurrent']);
  Route::resource('client.invoice', \App\Http\Controllers\Target\InvoiceController::class)->shallow();
  Route::post('invoice/{invoice}/paid', [\App\Http\Controllers\Target\InvoiceController::class, 'setPaid']);
  Route::post('invoice/{invoice}/vk_paid', [\App\Http\Controllers\Target\InvoiceController::class, 'setVkPaid']);
  Route::post('invoice/parse', [\App\Http\Controllers\Target\InvoiceController::class, 'parse']);
});
