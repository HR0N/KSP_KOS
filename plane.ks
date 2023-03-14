clearscreen.

wait 0.8.
HUDTEXT("Три", 3, 2, 50, YELLOW, false).
wait 0.8.
HUDTEXT("Два", 3, 2, 50, YELLOW, false).
wait 0.8.
HUDTEXT("Раз", 3, 2, 50, YELLOW, false).
wait 1.
HUDTEXT("Пошел ты нахуй ПИДАРАС !", 3, 2, 50, YELLOW, false).
wait 1.


set Azimuth to 90.

lock Angle to (3000-alt:radar)/3000*90.

lock steering to heading(Azimuth, Angle).

stage.

wait until ship:solidfuel<0.1.

wait 2.
HUDTEXT("Все, это пиздец!  =( !", 3, 2, 50, YELLOW, false).

lock Angle to 90 - VANG(SHIP:VELOCITY:SURFACE, SHIP:UP:VECTOR) + 10.
lock steering to heading(Azimuth, MAX(MIN(Angle, -2), 1)).

wait until alt:radar<200.

wait until alt:radar<30.
lock steering to heading(Azimuth, 15).

wait until (STATUS = "LANDED") OR (STATUS = "SPLASHED").
HUDTEXT("TOUCH DOWN ! ! !", 3, 2, 50, GREEN, false).








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


// switch to 0. run plane.

