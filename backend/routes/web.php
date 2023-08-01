<?php

use Illuminate\Support\Facades\Route;
use VK\OAuth\Scopes\VKOAuthUserScope;
use VK\OAuth\VKOAuth;
use VK\OAuth\VKOAuthDisplay;
use VK\OAuth\VKOAuthResponseType;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
  return ['Laravel' => app()->version()];
});

Route::get('/vk/code', function () {
  return ['Laravel' => app()->version()];
});

Route::get('/vk/auth', function () {
  $oauth = new VKOAuth();
  $client_id = 7825228;
  $redirect_uri = URL::to('/vk/code');
  $display = VKOAuthDisplay::PAGE;
  $scope = [
    VKOAuthUserScope::ADS
  ];
  $state = 'secret_state_code';

  $browser_url = $oauth->getAuthorizeUrl(VKOAuthResponseType::CODE, $client_id, $redirect_uri, $display, $scope, $state);

  return redirect($browser_url);
});

require __DIR__ . '/auth.php';
https://oauth.vk.com/access_token?client_id=7825228&client_secret=H2Pk8htyFD8024mZaPHm&redirect_uri=localhost::8000/vk/code&code=7a6fa4dff77a228eeda56603b8f53806c883f011c40b72630bb50df056f6479e52a
