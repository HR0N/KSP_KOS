// S T A R T

clearscreen.



Function VelocityCalculator {
  Parameter OrbitHeight.
  
  set height to OrbitHeight * 1000.

  set KerbinRadius to 600000.
  set TotalRadius to height + KerbinRadius.
  set OrbitalPeriod to ship:orbit:period.
  set speed to (2 * 3.1416 * TotalRadius) / OrbitalPeriod.
  return speed.
}


Function test{
	wait 1.
	SAS.
	wait 1.
	SAS OFF.
}

test().









// print ship:orbit:apoapsis. // shows the ship's apoapsis
// print kerbin:orbit:apoapsis. // shows kerbin's apoapsis
// print ship:body:orbit:apoapsis. // shows kerbin's apoapsis if you're currently orbiting kerbin
// print ___:orbit:apoapsis. // shows the apoapsis of whatever you fill in the blank

// print kerbin:name. // shows kerbin
// print kerbin:mass. // shows kerbin's mass
// print kerbin:radius // shows kerbin's radius
// print kerbin:mu // shows kerbin's gravitational parameter
// print ship:body:name. // shows kerbin
// print ship:body:mass. // shows kerbin's mass
// print ship:body:radius // shows kerbin's radius
// print ship:body:mu // shows kerbin's gravitational parameter

