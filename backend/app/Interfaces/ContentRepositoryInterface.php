<?php

namespace App\Interfaces;

use App\Models\Content\Content;
use Illuminate\Http\UploadedFile;

interface ContentRepositoryInterface
{
  public function store(UploadedFile $file, string $link = null): Content;
}
