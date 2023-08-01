<?php

namespace App\Console\Commands\Client;

use App\Models\Target\Client;
use Illuminate\Console\Command;

class ClearInvoice extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'client:clear-invoice';

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
      $paidClients = Client::whereRelation('currentInvoice', 'is_vk_paid', true)
        ->update(['current_invoice_id' => null, 'is_budget_agreed' => false, 'paid_at' => null, 'low_balance_at' => null, 'zero_balance_at' => null]);
    }
}
