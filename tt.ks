//																Variables

set azimuth to 90.
set angle to 90.
lock speed to GROUNDSPEED.
lock fuel to ship:solidfuel.
set target_altitude to 5000.
set launched to false.


//																Functions

// Функція, що виводить інформацію на екран.
function displayInfo{
	  clearscreen.
	
	  print "Altitude (Alt:radar): " + round(ALT:RADAR).
	  print "Speed Surface: " + round(GROUNDSPEED).
	  print "Speed Vertical: " + round(VERTICALSPEED).
	  print "Apoapsis: " + round(Orbit:APOAPSIS, 2).
	  print "Periapsis: " + round(Orbit:PERIAPSIS, 2).
	  print "Inclination: " + round(Orbit:INCLINATION, 2).
	  print "Eccenticity: " + round(Orbit:ECCENTRICITY, 2).
	  print " ".
	  print "Airspeed: " + round(Ship:AIRSPEED, 2).
	  print "Mass: " + round(Ship:MASS, 2) + "t".
	  print "Electricity: " + round(Ship:ELECTRICCHARGE, 2).
}

function landed{
	return (STATUS = "LANDED") OR (STATUS = "SPLASHED").
}

function greetings{
	wait 0.8.
	HUDTEXT("3", 3, 2, 50, YELLOW, false).
	wait 0.8.
	HUDTEXT("2", 3, 2, 50, YELLOW, false).
	wait 0.8.
	HUDTEXT("1", 3, 2, 50, YELLOW, false).
	wait 0.8.
	HUDTEXT("Fuck off, motherfucker!", 3, 2, 50, YELLOW, false).
	wait 1.
	clearscreen.
	print "Починається робота програми.".
}

function getTakeOffAngle{
	set preangle1 to (target_altitude-alt:radar)/target_altitude*90.
	set difference to (ABS(preangle1) - ABS(angle)).
	lock angle to MAX((target_altitude-alt:radar)/target_altitude*90, difference).
}

function getPlanningfAngle{
	if((speed >= 200 and Alt:radar <= 100) or (speed <= 100 and Alt:radar < 50)){
		lock angle to 15.
	}else if(speed > 150 and Alt:radar > 100){
		lock angle to 2.
	}else if(speed <= 150 and Alt:radar > 100){	
		lock angle to -10.
	}
}

function getAngle{
	if(fuel >= 0.1){
		getTakeOffAngle().
	}else if(fuel < 0.1){
		getPlanningfAngle().
	}
}

//																Script executing.

//greetings().
getAngle().
lock steering to heading(azimuth, angle).
wait 1.


set count to 0.
function loop{
	// parameter OrbitHeight.
	
	
	until landed() {
	  
	  
	  displayInfo().
	  
	  getAngle().
	  
	  
	  set count to count + 1.
	  wait .2.
	  if(not launched){stage. set launched to true.}
	}
}
loop().


lock throttle to 0.
print " ".
print " ".

