<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::post('/register', function (Request $request) {

});

Route::get('/ping/{mac}', function (Request $request, string $mac) {
    return shell_exec("ping {$mac}");
});

Route::get('/manage-ports', function (Request $request) {
    return 'Managing ports';
});
