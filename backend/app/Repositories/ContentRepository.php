<?php

namespace App\Repositories;


use App\Interfaces\ContentRepositoryInterface;
use App\Models\Content\Content;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

class ContentRepository implements ContentRepositoryInterface
{
  public function store(UploadedFile $file, $link = null): Content
  {
    $hash = sha1($file->getContent());
    $sameHash = Content::firstWhere('hash', $hash);
    if ($sameHash) {
      return $sameHash;
    }

    $date = now()->format('Y/m/d');
    $path = "/content/{$date}/{$file->hashName()}";
    Storage::disk('public')->put($path, $file->getContent());

    return Content::create([
      'path' => $path,
      'hash' => $hash,
      'extension' => $file->getClientOriginalExtension(),
      'mime' => $file->getMimeType(),
      'name' => $file->getClientOriginalName(),
      'link' => $link
    ]);
  }
}
