<?php

namespace App\Console;

use App\Models\Target\Client;
use Carbon\Carbon;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{


  /**
   * Define the application's command schedule.
   *
   * @param Schedule $schedule
   */
  protected function schedule(Schedule $schedule): void
  {
    $logFilename = Carbon::now()->format('Y_m_d') . '.log';

    $schedule->command('content:publish-story')
      ->everyMinute()
      ->appendOutputTo(storage_path("/logs/story/$logFilename"));

    $schedule->command('ads:get-clients')->everyFifteenMinutes();
    $schedule->command('ads:get-companies')->hourly();
    $schedule->command('ads:get-statistics')->everyFiveMinutes();

    $schedule->command('telegram:send-alerts')->days([1, 3, 5])->at('12:00');
    $schedule->command('telegram:send-invoice')
      ->days([1, 3, 5])->at('12:00')
      ->appendOutputTo(storage_path("/logs/telegram/send-invoice/{$logFilename}"));;
    $schedule->command('telegram:send-balance')
      ->days([1, 2, 3, 4, 5])->hourly()
      ->appendOutputTo(storage_path("/logs/telegram/send-balance/{$logFilename}"));
    $schedule->command('telegram:send-report')
      ->days([1, 2, 3, 4, 5])->hourly()
      ->appendOutputTo(storage_path("/logs/telegram/send-report/{$logFilename}"));;


    $schedule->call(function () {
      Client::where('is_balance_notified', true)->update(['is_balance_notified' => false]);
    })->daily();
    $schedule->call(function () {
      Client::where('is_report_notified', true)->update(['is_report_notified' => false]);
    })->sundays();
  }

  /**
   * Register the commands for the application.
   */
  protected function commands(): void
  {
    $this->load(__DIR__ . '/Commands');

    include base_path('routes/console.php');

  }

}
