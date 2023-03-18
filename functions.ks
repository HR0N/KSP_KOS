
// documentation:
// navball - https://wiki.kerbalspaceprogram.com/wiki/Navball
// PROGRADE - RETROGRADE; NORMAL - ANTINORMAL; RADIALIN - RADIALOUT; TARGETPROGRADE - TARGETRETROGRADE; MANEUVER; 
// OrbitEta - https://ksp-kos.github.io/KOS/structures/orbits/eta.html




// функция для вывода текста на центр экрана
FUNCTION NOTIFY {
	PARAMETR message.
	HUDTEXT("kOS: " + message, 5, 2, 50, YELLOW, false).
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











