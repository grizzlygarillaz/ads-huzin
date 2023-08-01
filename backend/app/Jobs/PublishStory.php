<?php

namespace App\Jobs;

use App\Api\Vk\Stories;
use App\Models\Content\Story;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use GuzzleHttp\Psr7;

class PublishStory implements ShouldQueue
{
  use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

  /**
   * Create a new job instance.
   */
  public function __construct(
    public Story $story,
  )
  {
  }

  /**
   * Execute the job.
   */
  public function handle(): void
  {
    $client = new Client();
    $storiesApi = new Stories();
    $content = $this->story->content;
    $group = $this->story->group;
    $path = \Storage::disk('public')->path($content->path);

    try {
      if (\Str::startsWith($content->mime, 'video')) {
        info('vifedo');
        $uploadServer = $storiesApi->getVideoUploadServer($group->id, true);
        $response = $client->request('POST', $uploadServer['upload_url'], [
          'multipart' => [['name' => 'video_file', 'contents' => Psr7\Utils::tryFopen($path, 'r')]]
        ]);
      } else {
        $uploadServer = $storiesApi->getPhotoUploadServer($group->id, true);
        $response = $client->request('POST', $uploadServer['upload_url'], [
          'multipart' => [['name' => 'file', 'contents' => Psr7\Utils::tryFopen($path, 'r')]]
        ]);
      }
      $result = json_decode($response->getBody()->getContents(), true, 512, JSON_THROW_ON_ERROR);
      $save = $storiesApi->save($result['response']['upload_result']);
      $this->story->is_published = true;
    } catch (\JsonException | GuzzleException $e) {
      \Log::error('ERROR job PublishStory', [
        'code' => $e->getCode(),
        'message' => $e->getMessage()
      ]);
      $this->story->error = 'error';
    }

    $this->story->save();
  }
}
