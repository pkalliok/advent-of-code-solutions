
BEGIN { dir = 0; x = 0; y = 0; }

/^N/ { y -= substr($0,2) }
/^S/ { y += substr($0,2) }
/^W/ { x -= substr($0,2) }
/^E/ { x += substr($0,2) }
/^R/ { dir = (dir + 360 - substr($0,2)) % 360 }
/^L/ { dir = (dir + substr($0,2)) % 360 }
/^F/ { arg = substr($0,2);
	y += arg * (dir == 270) - arg * (dir == 90);
	x += arg * (dir == 0) - arg * (dir == 180); }

{ print $0, dir, x, y }

END { print sqrt(x*x) + sqrt(y*y) } # because no abs(), lol
