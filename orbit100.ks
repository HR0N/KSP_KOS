// S T A R T

function test1{
	print "yes".
}

clearscreen.

print "Починається робота програми.".
wait 2.



set count to 0.
function loop{
	// parameter OrbitHeight.
	
	
	until count > 2 {
	  clearscreen.
	
	
	  print "Altitude (Alt:radar): " + round(ALT:RADAR).
	  print "Speed Surface: " + round(GROUNDSPEED).
	  print "Speed Vertical: " + round(VERTICALSPEED).
	  
	  test1().
	  
	  
	  set count to count + 1.
	  wait .2.
	}
}
loop().

print " ".
print " ".

