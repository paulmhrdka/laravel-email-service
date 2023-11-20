<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class MailController extends Controller
{
    public function sendEmail(Request $request)
    {
        $data = [
            'name' => $request->input('name'),
            'body' => $request->input('body'),
        ];

        Mail::send('emails.test', $data, function ($message) use ($request) {
            $message->to($request->input('recipient_email'), $request->input('recipient_name'))
                    ->subject($request->input('subject', 'Test Email'));
        });

        return response()->json(['message' => 'Email sent successfully']);
    }
}
