<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class GroupStoreRequest extends FormRequest
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
          'id' => ['required', 'numeric'],
          'name' => ['required', 'string'],
          'link' => ['required', 'string', 'max:128'],
          'site' => ['string', 'max:255', 'nullable'],
          'senler_token' => ['string', 'max:128', 'nullable'],
          'screen_name' => ['required', 'string', 'max:55'],
          'city' => ['string', 'max:55', 'nullable'],
          'timezone' => ['numeric'],
          'photo' => ['URL', 'nullable']
        ];
    }
}
