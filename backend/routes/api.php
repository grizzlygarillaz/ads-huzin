<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

include_once "target-api.php";
include_once "content-api.php";
include_once "admin-api.php";

include_once "vk-api.php";
include_once "client-api.php";

Route::middleware(['auth:sanctum'])->get('/me', function (Request $request) {
  return $request->user();
});

Route::middleware(['auth:sanctum'])->group(function () {
  Route::resource('user', \App\Http\Controllers\UserController::class);
  Route::resource('group', \App\Http\Controllers\GroupController::class);
  Route::post('group/{group}/link', [\App\Http\Controllers\GroupController::class, 'setLinkedGroups']);
  Route::get('group/{group}/link', [\App\Http\Controllers\GroupController::class, 'getLinkedGroups']);
});
