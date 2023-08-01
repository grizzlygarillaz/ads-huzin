<?php

namespace App\Http\Controllers;

use App\Http\Requests\GroupStoreRequest;
use App\Http\Requests\GroupUpdateRequest;
use App\Models\Group;
use Illuminate\Http\Request;

class GroupController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index()
  {
    return response()->json(Group::orderBy('name')->get());
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(GroupStoreRequest $request)
  {
    if ($trashed = Group::withTrashed()->find($request->validated('id'))) {
      $trashed->restore();
    }
    $group = Group::updateOrCreate(
      ['id' => $request->validated('id')],
      $request->validated()
    );
    return response()->json($group);
  }


  /**
   * Display the specified resource.
   */
  public function show(Group $group)
  {
    return response()->json($group);
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(GroupUpdateRequest $request, Group $group)
  {
    $group->update($request->validated());

    return response()->json($group);
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(Group $group)
  {
    $group->delete();
    return response()->json($group);
  }

  public function getLinkedGroups(Group $group): \Illuminate\Http\JsonResponse
  {
    return response()->json($group->linkedGroups);
  }

  public function setLinkedGroups(Group $group, Request $request)
  {
    $validate = $request->validate([
      'groups' => ['array'],
      'groups.*' => ['exists:' . Group::class . ',id']
    ]);

    $group->linkedGroups()->sync($validate['groups']);

    foreach ($group->linkedGroups as $linked) {
      if (!$linked->linkedGroups->contains($group)) {
        $linked->linkedGroups()->attach($group);
      }
    }

    foreach ($group->linkedToGroups as $linkedTo) {
      if (!in_array($linkedTo->id, $validate['groups'])) {
        $linkedTo->linkedGroups()->detach($group);
      }
    }

    return response()->json($group->linkedGroups);
  }
}
