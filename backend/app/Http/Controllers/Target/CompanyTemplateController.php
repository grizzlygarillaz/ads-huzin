<?php

namespace App\Http\Controllers\Target;

use App\Http\Controllers\Controller;
use App\Models\Target\CompanyTemplate;
use F9Web\ApiResponseHelpers;
use Illuminate\Http\Request;

class CompanyTemplateController extends Controller
{
  use ApiResponseHelpers;

  /**
   * Display a listing of the resource.
   */
  public function index(): \Illuminate\Http\JsonResponse
  {
    return response()->json(CompanyTemplate::all());
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(Request $request): \Illuminate\Http\JsonResponse
  {
    $validated = $request->validate([
      'name' => ['required', 'string', 'max:55']
    ]);

    $template = new CompanyTemplate($validated);
    $template->save();

    return response()->json(CompanyTemplate::find($template->id));
  }

  /**
   * Display the specified resource.
   */
  public function show(CompanyTemplate $companyTemplate)
  {
    //
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, CompanyTemplate $companyTemplate)
  {
    $validated = $request->validate([
      'name' => ['required', 'string', 'max:55']
    ]);

    return response()->json($companyTemplate->update($validated));
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(CompanyTemplate $companyTemplate): \Illuminate\Http\JsonResponse
  {
    info($companyTemplate);
    $companyTemplate->tags()->delete();
    $companyTemplate->delete();

    return $this->respondWithSuccess();
  }


  public function storeTags(CompanyTemplate $companyTemplate, Request $request)
  {
    $validated = $request->validate([
      'tags' => ['array'],
      'tags.*.tag' => ['string', 'min:2', 'max:55']
    ]);

    $companyTemplate->tags()->delete();

    $tags = collect($validated['tags'])->map(function ($tag) {
      return ['tag' => mb_strtolower($tag['tag'])];
    })->unique('tag');
    $companyTemplate->tags()->createMany($tags);

    return response()->json($tags->pluck('tag'));
  }
}
