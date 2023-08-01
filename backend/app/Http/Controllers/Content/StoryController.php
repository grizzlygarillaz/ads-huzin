<?php

namespace App\Http\Controllers\Content;

use App\Http\Controllers\Controller;
use App\Interfaces\ContentRepositoryInterface;
use App\Models\Content\Story;
use App\Models\Group;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Validation\Rules\File;

class StoryController extends Controller
{
  private ContentRepositoryInterface $contentRepository;

  public function __construct(ContentRepositoryInterface $contentRepository)
  {
    $this->contentRepository = $contentRepository;
  }

  /**
   * Display a listing of the resource.
   */
  public function index(Group $group)
  {
    $fromDate = now()->addDays(-1)->hour(0);
    $stories = $group->stories()->where('date', '>=', $fromDate)->orderBy('date')->get();
    return response()->json($stories);
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(Request $request, Group $group)
  {
    $validated = $request->validate([
      'content' => [
        'required',
        File::types(['jpg', 'png', 'gif', 'mp4', 'mav', 'mov'])
          ->min(3)
          ->max(10 * 1024)],
      'date' => ['required', 'date', 'after:now'],
      'with_linked' => ['boolean'],
      'from_msk' => ['boolean'],
      'link' => ['string', 'nullable']
    ]);
    $content = $this->contentRepository->store($request->file('content'), $request->link);

    $story = new Story();
    $story->date = Carbon::parse($validated['date']);
    $story->locale_date = Carbon::parse($validated['date'])->addHours($group->timezone);
    $story->content()->associate($content);
    $story->group()->associate($group);
    $story->createdBy()->associate($request->user());
    $story->save();

    if ($validated['with_linked']) {
      foreach ($group->linkedGroups as $linkedGroup) {
        $linkedStory = $story->replicate();
        if ($validated['from_msk']) {
          $linkedStory->locale_date = Carbon::parse($linkedStory->date)->addHours($linkedGroup->timezone);
        } else {
          $linkedStory->date = Carbon::parse($story->locale_date)
            ->addHours(-$linkedGroup->timezone);
        }
        $linkedStory->group()->associate($linkedGroup);
        $linkedStory->save();
      }
    }
    // TODO add sending with linked

    return response()->json($story);
  }

  /**
   * Display the specified resource.
   */
  public function show(Story $story)
  {
    //
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, Story $story)
  {
    //
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(Story $story)
  {
    $story->delete();

    return response()->json($story);
  }
}
