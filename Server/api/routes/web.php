<?php

use Illuminate\Support\Facades\Route;

Route::get('/test', function () {
    return "test";
});

Route::get("/ping/{test}", function (string $test) {
    return "Pinging ${test}";
});