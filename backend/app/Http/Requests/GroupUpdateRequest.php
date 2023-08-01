<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class GroupUpdateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\Rule|array|string>
     */
    public function rules(): array
    {
        return [
          'name' => ['string'],
          'link' => ['string', 'max:128'],
          'senler_token' => ['string', 'max:128', 'nullable'],
          'screen_name' => ['string', 'max:55', 'nullable'],
          'city' => ['string', 'max:55', 'nullable'],
          'timezone' => ['numeric', 'nullable'],
          'photo' => ['URL', 'nullable'],
        ];
    }
}
