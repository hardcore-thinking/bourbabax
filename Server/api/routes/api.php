<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;


Route::get('/register/{mac}', function (Request $request, string $mac) {
    return "Registering {$mac}";
});

Route::get('/heartbeat', function (Request $request, string $mac) {
    return "Heartbeat from {$mac}";
});

Route::get('/manage-ports', function (Request $request) {
    return "Managing ports";
});
