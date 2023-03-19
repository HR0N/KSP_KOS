
// documentation:
// navball - https://wiki.kerbalspaceprogram.com/wiki/Navball
// PROGRADE - RETROGRADE; NORMAL - ANTINORMAL; RADIALIN - RADIALOUT; TARGETPROGRADE - TARGETRETROGRADE; MANEUVER; 
// OrbitEta - https://ksp-kos.github.io/KOS/structures/orbits/eta.html




// функция для вывода текста на центр экрана
FUNCTION notify {
	parameter msg.
	wait .5.
	HUDTEXT("kOS: " + msg, 5, 2, 50, YELLOW, false).
}


// устанавливаем угол и ждем
FUNCTION waitAngle{
	PARAMETER vector.
  
	//LOCK STEERING TO vector.	// with roll 0
	LOCK STEERING TO lookdirup(vector, ship:facing:topvector). // without roll controll
	WAIT UNTIL VANG(ship:facing:forevector,vector) < .1.	//example vector - ship:srfprograde:vector
	wait 1.
}


Function VelocityCalculator {
  Parameter OrbitHeight.
  
  set height to OrbitHeight * 1000.

  set KerbinRadius to 600000.
  set TotalRadius to height + KerbinRadius.
  set OrbitalPeriod to ship:orbit:period.
  set speed to (2 * 3.1416 * TotalRadius) / OrbitalPeriod.
  return speed.
}


FUNCTION TILT{
	PARAMETER min_altitude.
	PARAMETER angle.
	
	WAIT UNTIL ALTITUDE > min_altitude.
	LOCK STEERING to HEADING(90, angle).
}


FUNCTION CIRCULARIZE {
	set targetV to sqrt(ship:body:mu/(ship:orbit:body:radius + ship:orbit:apoapsis)). //this is the velocity that we need to be going at AP to be circular
	set apVel to sqrt(((1 - ship:orbit:ECCENTRICITY) * ship:orbit:body:mu) / ((1 + ship:orbit:ECCENTRICITY) * ship:orbit:SEMIMAJORAXIS)). //this is how fast we will be going
	set dv to targetV - apVel. // this is the deltaV
	set mynode to node(time:seconds + eta:apoapsis, 0, 0, dv). // create a new maneuver node
	add mynode. // add the node to our trajectory  
}


function apoapsis_circ {
    if not hasnode {
        set m_time to time:seconds + eta:apoapsis.
        set v0 to velocityat(ship,m_time):orbit:mag.
        set v1 to sqrt(body:mu/(body:radius + apoapsis)).
        set circularize to node(m_time, 0, 0, v1 - v0).
        add circularize.
    }
    lock steering to circularize:deltav:direction.
    lock max_acc to ship:maxthrust / ship:mass.
    lock burn_duration to circularize:deltav:mag/max_acc.

    wait until circularize:eta <= burn_duration / 2.
    lock throttle to 1.

    wait until circularize:deltav:mag < 1.
    lock throttle to 0.

    remove circularize.
}


function periapsis_circ {
    if not hasnode {
        set m_time to time:seconds + eta:periapsis.
        set v0 to velocityat(ship,m_time):orbit:mag.
        set v1 to sqrt(body:mu/(body:radius + periapsis)).
        set circularize to node(m_time, 0, 0, v1 - v0).
        add circularize.
    }
    lock steering to circularize:deltav:direction.
    lock max_acc to ship:maxthrust / ship:mass.
    lock burn_duration to circularize:deltav:mag/max_acc.

    wait until circularize:eta <= burn_duration / 2.
    lock throttle to 1.

    wait until circularize:deltav:mag < 1.
    lock throttle to 0.

    remove circularize.
}







function print_data{
	parameter p1.
	parameter p2.

	set count to 0.
	until count < 100 {
		wait .5.
		print p1.
		print p2.
		count set to count + 1.
	}
}


