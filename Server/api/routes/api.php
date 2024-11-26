<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;


Route::get('/register', function (Request $request, string $mac) {
    
});

Route::get('/heartbeat', function (Request $request, string $mac) {
    return $reponse->json(["message", "Heartbeat"]);  
});

Route::get('/manage-ports', function (Request $request) {

});
