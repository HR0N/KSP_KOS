
FUNCTION notify {
	parameter msg.
	wait .5.
	HUDTEXT("kOS: " + msg, 5, 2, 50, yellow, false).
}

function function_warp{
	parameter circularize.
	parameter burn_duration.


	set warp to 1.
	wait 1.5.
	set warp to 2.
	wait 1.5.
	set warp to 3.
	wait 1.5.
	if circularize:eta > burn_duration / 2 + 2160 { set warp to 5. }
	else { set warp to 4. }
	

    wait until circularize:eta <= burn_duration / 2 + 1080.
	set warp to 4.

    wait until circularize:eta <= burn_duration / 2 + 360.
	set warp to 3.

    wait until circularize:eta <= burn_duration / 2 + 120.
	set warp to 2.

    wait until circularize:eta <= burn_duration / 2 + 30.
	set warp to 1.

    wait until circularize:eta <= burn_duration / 2 + 15.
	set warp to 0.
}

function go_new_periapsis {
	parameter new_periapsis.
	set new_periapsis to new_periapsis * 1000.

    if not hasnode {
        set m_time to time:seconds + eta:apoapsis.
        set v0 to velocityat(ship,m_time):orbit:mag.	// velocity at apoapsis
        set v1 to sqrt(body:mu * (2/(body:radius + apoapsis) - 2/(2*body:radius + apoapsis + new_periapsis))).	// 
        set circularize to node(m_time, 0, 0, v1 - v0).
        add circularize.
    }
    lock steering to circularize:deltav:direction.
    lock max_acc to ship:maxthrust / ship:mass.
    lock burn_duration to circularize:deltav:mag/max_acc.


	wait until ABS(VANG(ship:facing:vector, circularize:deltav)) <= 0.05.
	function_warp(circularize, burn_duration).
	
    wait until circularize:eta <= burn_duration / 2.
    lock throttle to 1.

    wait until circularize:deltav:mag < 1.
    lock throttle to 0.

	unlock steering.
    remove circularize.
}

function periapsis_circ {
    if not hasnode {
        set m_time to time:seconds + eta:periapsis.
        set v0 to velocityat(ship,m_time):orbit:mag.	// velocity at periapsis
        set v1 to sqrt(body:mu/(body:radius + periapsis)).	// 
        set circularize to node(m_time, 0, 0, v1 - v0).
        add circularize.
    }
    lock steering to circularize:deltav:direction.
    lock max_acc to ship:maxthrust / ship:mass.
    lock burn_duration to circularize:deltav:mag/max_acc.


	wait until ABS(VANG(ship:facing:vector, circularize:deltav)) <= 0.05.
	function_warp(circularize, burn_duration).
	
    wait until circularize:eta <= burn_duration / 2.
    lock throttle to 1.

    wait until circularize:deltav:mag < 1.
    lock throttle to 0.

	unlock steering.
    remove circularize.
}

function change_orbit_handler{
	parameter new_periapsis.
	set p1 to new_periapsis.

	sas off.
	notify("Orbit " + new_periapsis).
	go_new_periapsis(p1).
	print "Node 1 completed".

	wait 2.
	periapsis_circ().
	print "Node 2 completed".
	notify("Maneuver completed.").
}



change_orbit_handler(80).









