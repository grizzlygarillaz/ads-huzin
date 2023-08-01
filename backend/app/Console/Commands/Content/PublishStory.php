<?php

namespace App\Console\Commands\Content;

use App\Api\Vk\Stories;
use App\Models\Content\Story;
use Carbon\Carbon;
use Illuminate\Console\Command;

class PublishStory extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'content:publish-story';

  /**
   * The console command description.
   *
   * @var string
   */
  protected $description = 'Command description';

  /**
   * Execute the console command.
   */
  public function handle(): void
  {
    $time = now()->format('Y-m-d H:i');
    $stories = Story::where('date', 'like', $time . '%')->get();
    $storiesApi = new Stories();

    foreach ($stories as $story) {
      $content = $story->content;
      $group = $story->group;
      $path = \Storage::disk('public')->path($content->path);
      echo `$time: $story->id DATE $story->date` . PHP_EOL;

      try {
        $isVideo = \Str::startsWith($content->mime, 'video');
        $uploadServer = $isVideo
          ? $storiesApi->getVideoUploadServer($group->id, true)
          : $storiesApi->getPhotoUploadServer($group->id, true);

        $content = fopen($path, 'r');
        $response = \Http::attach($isVideo ? 'video_file' : 'file', $content)
          ->post($uploadServer['upload_url'])
          ->json();
        fclose($content);

        if (array_key_exists('response', $response) && array_key_exists('upload_result', $response['response'])) {
          $storiesApi->save($response['response']['upload_result']);
          $story->is_published = true;
        } else {
          var_dump($response);
        }
      } catch (\Exception $e) {
        echo 'ERROR' . PHP_EOL;
        var_dump([$e->getCode(), $e->getMessage(), $e->getFile(), $e->getLine()]);
        $story->error = 'error';
      }

      $story->save();
    }
  }
}
