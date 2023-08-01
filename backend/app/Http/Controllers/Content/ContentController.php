<?php

namespace App\Http\Controllers\Content;

use App\Http\Controllers\Controller;
use App\Models\Content\Content;
use Illuminate\Http\Request;
use Storage;

class ContentController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index()
  {
    //
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(Request $request)
  {
    //
  }

  /**
   * Display the specified resource.
   */
  public function show(Content $content)
  {
    //
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, Content $content)
  {
    //
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(Content $content)
  {
    //
  }

  public function getFromYandex(Request $request)
  {
    $validation = $request->validate([
      'url' => ['required', 'url']
    ]);
    $client = new \GuzzleHttp\Client([
      'base_uri' => 'https://cloud-api.yandex.net'
    ]);

    $downloader = $client->get('v1/disk/public/resources/download', ['query' => [
      'public_key' => $validation['url']
    ]]);

    $downloaderArray = json_decode($downloader->getBody()->getContents(), true);

    if (!array_key_exists('href', $downloaderArray)) {
      return response()->json(['message' => 'Неудалось загрузить котнент'], 401);
    }
    parse_str( parse_url( $downloaderArray['href'], PHP_URL_QUERY), $query );

    Storage::disk("local")->put($query['filename'], file_get_contents($downloaderArray['href']));

    return response()->file(Storage::disk("local")->path($query['filename']))->deleteFileAfterSend();
  }
}
