<?php

namespace App\Http\Controllers;

use App\Models\RPiModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Database\Schema\Blueprint;

class RPiController extends Controller {
    // PURPOSE: Display a listing of the resource.
    public function index() {
        return;        
    }

    // PURPOSE: Store a newly created resource in storage (for /register route).
    public function store(Request $request) {
        $body = json_decode($request->getContent());

        // check for correct inputs in the API
        $mac = $body->mac ?? null;
        $sshKey = $body->sshKey ?? null;
        $requestedPorts = $body->ports ?? null;

        // if all or some are missing
        if ($mac == null || $sshKey == null || $requestedPorts == null) {
            return response()->json([
                "status" => Response::HTTP_BAD_REQUEST,
                "reason" => "The MAC address of the Raspberry Pi, the SSH key or the requested ports are missing from the body. Be advised those are mandatory."
            ], Response::HTTP_BAD_REQUEST);
        }        

        // getting entry
        $entryForMac = DB::table("raspberries")->where("mac_addr", $mac)->first();
        $usedPorts = DB::table("raspberries")->select("port")->get();

        // verify if MAC exists
        $macExists = ($entryForMac != null);

        // if it DOESN'T exists
        if (!$macExists) {
            // insert MAC and SSH key
            $port = -1;
            
            // get available port
            foreach ($requestedPorts as $requestedPort) {
                if (!$usedPorts->contains("port", $requestedPort)) {
                    $port = $requestedPort;

                    // insert new entry for new RPi
                    DB::table("raspberries")->insert([
                        [
                            "mac_addr" => $mac,
                            "port" => $port,
                            "last_seen" => now(),
                            "ssh_key" => $sshKey
                        ]
                    ]);

                    break;
                }
            }

            // if no port is available in the ones requested
            if ($port == -1) {
                return response()->json([
                    "status" => Response::HTTP_CONFLICT,
                    "reason" => "Required ports are all unavailable. Please choose different ones."
                ], Response::HTTP_CONFLICT);
            }

            // return assigned ports
            return response()->json([
                "status" => Response::HTTP_CREATED,
                "port" => $port
            ], Response::HTTP_CREATED);
        }
        
        // if it DOES exists
        else {
            // return currently assigned ports
            return response()->json([
                "status" => Response::HTTP_NOT_MODIFIED,
                "ports" => $entryForMac->port
            ], Response::HTTP_NOT_MODIFIED);
        }
    }

    // PURPOSE: Display the specified resource.
    public function show(RPiModel $rPiModel) {
        return;
    }

    // PURPOSE: Update the specified resource in storage (for /heartbeat route).
    public function update(Request $request, RPiModel $rPiModel) {
        $body = json_decode($request->getContent());

        // check for correct inputs in the API
        $mac = $body->mac ?? null;

        // if all or some are missing
        if ($mac == null) {
            return response()->json([
                "status" => Response::HTTP_BAD_REQUEST,
                "reason" => "The MAC address of the Raspberry Pi is missing from the body. Be advised it is mandatory."
            ], Response::HTTP_BAD_REQUEST);
        }

        // check if mac already exists in DB
        $macExists = DB::table("raspberries")->where("mac_addr", $mac)->first() != null;

        if ($macExists) {
            // updated last seen date in database
            DB::table("raspberries")->where("mac_addr", $mac)->update([ "last_seen" => now() ]);

            // return status for successful update
            return response()->json([
                "status" => Response::HTTP_OK
            ], Response::HTTP_OK);
        }

        else {
            // can't update non-existing mac entry
            return response()->json([
                "status" => Response::HTTP_NOT_FOUND,
                "reason" => "Cannot update a non-existing MAC entry. Make sure there is no typo in the MAC address."
            ], Response::HTTP_NOT_FOUND);
        }
    }

    // PURPOSE: Remove the specified resource from storage.
    public function destroy(RPiModel $rPiModel) {
        return;
    }
}
