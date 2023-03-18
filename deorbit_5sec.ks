// Author of the original script - https://gist.github.com/KK4TEE/5d5e5586ca85c446df2b

//Set a parking orbit that we will do the final deorbit from. This should be circular.
set LandingOrbitAltitude to 75000. //In this case, 75km up.

clearscreen.
  
// Lets get some math out of the way, shall we?
lock shipLatLng to SHIP:GEOPOSITION. //This is the ship's current location above the surface
//This variable store the altitude above sea level that the ground below the ship is at.
lock surfaceElevation to shipLatLng:TERRAINHEIGHT.

lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).
     //Depending on what other mods you have installed ALT:RADAR may not work properly,
     // so instead I calculate it using the sea level altitude minus the ground elevation
lock impactTime to betterALTRADAR / -VERTICALSPEED. // Time until we hit the ground
                
// Calculate the theoretical throttle level to hover in place ( 1/TWR)
set GRAVITY to (constant():G * body:mass) / body:radius^2.
lock TWR to MAX( 0.001, MAXTHRUST / (MASS*GRAVITY)).



set runmode to 20. //Let's use runmodes that weren't used in the previous video. 
                   // This way we can easily combine scripts later if we choose to.
                   
if PERIAPSIS < LandingOrbitAltitude * 1.05 and APOAPSIS < LandingOrbitAltitude * 1.05 { 
        // If the orbit already meets the requirements, go ahead and skip changing Ap/Pe
    set runmode to 24.
    }


until runmode = 0 { //Run until we end the program

    if runmode = 20 { //Time warp to Apoapsis
        set TVAL to 0. //Engines off.
        if (SHIP:ALTITUDE > 70000) and (ETA:APOAPSIS > 60) {
            if WARP = 0 {        // If we are not time warping
                wait 1.         //Wait to make sure the ship is stable
                SET WARP TO 3. //Be really careful about warping
                }
            }
        else if ETA:APOAPSIS < 60 {
            SET WARP to 0.
            set runmode to 21.
            }
        else { 
            print "SHIP IS OUT OF POSITION".
            set runmode to 0. //If we're unable to get to the Ap, give up.
            }        
    }

    if runmode = 21 { //Lower Periapsis to transfer orbit.
        lock STEERING to RETROGRADE. //Point retrograde
        if ETA:APOAPSIS < 5 or VERTICALSPEED < 0 { 
                //If we're less 5 seconds from Ap or loosing altitude
            set TVAL to 1.1 - (LandingOrbitAltitude / PERIAPSIS). 
                //Lower the throttle the closer we get to our target
            }
        else{
            set TVAL to 0.
            }
        if PERIAPSIS < LandingOrbitAltitude {
            set TVAL to 0.
            set runmode to 22.
            }
        }

    if runmode = 22 { //Time warp to Periapsis
        set TVAL to 0. //Engines off.
        if (SHIP:ALTITUDE > 70000) and (ETA:PERIAPSIS > 60) {
            if WARP = 0 {        // If we are not time warping
                wait 1.         //Wait to make sure the ship is stable
                SET WARP TO 3. //Be really careful about warping
                }
            }
        else if ETA:PERIAPSIS < 60 {
            SET WARP to 0.
            set runmode to 23.
            }
        }

    if runmode = 23 { //Lower Apoapsis to transfer orbit.
        lock STEERING to RETROGRADE. //Point retrograde
        if ETA:PERIAPSIS < 5 or VERTICALSPEED > 0 { 
                //If we're less 5 seconds from Pe or gaining altitude
            set TVAL to 1.1 - (LandingOrbitAltitude / APOAPSIS). 
                //Lower the throttle the closer we get to our target
            }
        else {
            set TVAL to 0.
            }
        if Apoapsis < MAX(LandingOrbitAltitude, PERIAPSIS * 1.05) {
                //Here we use a MAX  function to pick the largest of the two values
            set TVAL to 0.
            set runmode to 24.
            }
		set runmode to 0.
        }

	}
        
    

    set finalTVAL to TVAL.
    lock throttle to finalTVAL. //Write our planned throttle to the physical throttle 

    //Print data to screen.
    print "RUNMODE:    " + runmode + "      " at (5,4).
    print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
    print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).
    print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,7).
    print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
    print "ETA to Pe:  " + round(ETA:PERIAPSIS) + "      " at (5,9).
    print "Impact Time:" + round(impacttime,1) + "      " at (5,10).
    
    print "LAT:  " + round(shipLatLng:LAT,3) + "      " at (5,12).
    print "LNG:  " + round(shipLatLng:LNG,3) + "      " at (5,13).
    
    }