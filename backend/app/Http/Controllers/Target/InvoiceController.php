<?php

namespace App\Http\Controllers\Target;

use App\Api\Vk\Ads;
use App\Http\Controllers\Controller;
use App\Models\Target\Client;
use App\Models\Target\Invoice;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\Rules\File;

class InvoiceController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index()
  {
    return response()->json(Invoice::all());
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(Request $request, Client $client): \Illuminate\Http\JsonResponse
  {
    $validated = $request->validate([
      'file' => ['required', File::types(['pdf'])->max(20 * 1024)],
      'inn' => ['numeric', 'required'],
      'sum' => ['numeric', 'required'],
      'number' => ['numeric', 'required'],
      'entrepreneur' => ['string', 'required'],
      'description' => ['string', 'nullable'],
    ]);

    $time = now()->format('Y_m_d');
    $path = Storage::putFileAs(
      "/invoices/" . now()->format('Y/m'),
      $validated['file'],
      "invoice_{$client->id}_$time.pdf"
    );
    $invoice = $client->invoices()->create([
      ...$validated,
      'path' => $path
    ]);

    return response()->json($invoice);
  }

  /**
   * Display the specified resource.
   */
  public function show(Client $client, Invoice $invoice)
  {
    //
  }

  public function showCurrent(Client $client)
  {
    $invoice = $client->currentInvoice;
    if ($invoice) {
      return response()->file(Storage::path($invoice->path), ['Content-Type'=>'application/json; charset=utf-8']);
    }

    return response()->json(null);
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, Invoice $invoice)
  {
    $validate = $request->validate([
      'number' => ['numeric', 'nullable'],
      'inn' => ['numeric', 'nullable'],
      'customer' => ['string', 'nullable'],
      'description' => ['string', 'nullable'],
    ]);

    $invoice->update($validate);
    $invoice->save();

    return response()->json($invoice);
  }

  public function setPaid(Invoice $invoice, Request $request): \Illuminate\Http\JsonResponse
  {
    $client = $invoice->client;
//    $client->all_limit = $client->all_limit + $invoice->budget;
    $client->paid_at = Carbon::now();

//    $adsApi = new Ads();
//    $updated = $adsApi->updateClient([
//      'client_id' => $client->id,
//      'all_limit' => $client->all_limit
//    ]);
//    if (array_key_exists('error', $updated)) {
//      return response()->json(['error' => 'Не удалось обновить данные клиента']);
//    }

    $client->save();

    $invoice->is_paid = true;
    $invoice->save();

    return response()->json($invoice);
  }

  public function setVkPaid(Invoice $invoice, Request $request)
  {
    $validate = $request->validate([
      'vk_number' => ['required', 'numeric']
    ]);
    if (!$invoice->is_paid) {
      return response()->json(['message' => 'Счёт должен быть оплачен'], 403);
    }

    $invoice->vk_number = $validate['vk_number'];
    $invoice->is_vk_paid = true;
    $invoice->save();

    return response()->json($invoice);
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(Invoice $invoice)
  {
    if ($invoice->is_paid) {
      return response()->json(['message' => 'Счёт уже оплачен'], 403);
    }

    $invoice->delete();

    return response()->json($invoice);
  }

  public function parse(Request $request)
  {
    $validated = $request->validate([
      'file' => ['required', File::types(['pdf'])->max(20 * 1024)]
    ]);

    $parser = new \Smalot\PdfParser\Parser();
    $pdf = $parser->parseFile($validated['file']->path());
    $text = $pdf->getText();
    info('parse text', [$text]);

    $number = Str::match("/Счет на оплату № (\d+)/", $text);
    $inn = Str::match("/(?<=Покупатель\\n\(Заказчик\):).*(?<=ИНН)\s*(\d+)/", $text);
    $entrepreneur = Str::match("/(?<=Покупатель\\n\(Заказчик\): )(.*)(?=, ИНН)/", $text);
    $sum = Str::replace(' ', '', Str::match("/Всего к оплате: ([\d\s]+)/", $text));

    return response()->json(compact('number', 'inn', 'entrepreneur', 'sum'));
  }
}
