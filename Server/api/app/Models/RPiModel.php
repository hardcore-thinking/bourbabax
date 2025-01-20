<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RPiModel extends Model
{
    use HasFactory;

    protected $id = 0;
    protected $mac_addr = "";
    protected $port = 0;
    protected $last_seen = 0;
    protected $ssh_key = "";
}
