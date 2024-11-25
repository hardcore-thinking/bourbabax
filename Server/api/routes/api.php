<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/register', function (Request $request) {
    return "Registering";
});

Route::get('/ping/{mac}', function (Request $request, string $mac) {
    return shell_exec("ping {$mac}");
});

Route::get('/manage-ports', function (Request $request) {
    return 'Managing ports';
});

Route::get('/test', function (Request $request) {
    return response()->json([
        ['id' => 1, 'name' => 'Produit 1', 'price' => 10.99],
        ['id' => 2, 'name' => 'Produit 2', 'price' => 20.99],
        ['id' => 3, 'name' => 'Produit 3', 'price' => 30.99],
    ]);
});