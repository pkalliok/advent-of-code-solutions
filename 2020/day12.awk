
BEGIN { dir = 0; x1 = 0; y1 = 0; wpx = 10; wpy = -1; x2 = 0; y2 = 0; }

{ arg = substr($0,2); }

/^N/ { y1 -= arg; wpy -= arg; }
/^S/ { y1 += arg }
/^W/ { x1 -= arg }
/^E/ { x1 += arg }
/^R/ { dir = (dir + 360 - arg) % 360 }
/^L/ { dir = (dir + arg) % 360 }
/^F/ { y1 += arg * (dir == 270) - arg * (dir == 90);
	x1 += arg * (dir == 0) - arg * (dir == 180); }

{ print $0, dir, x1, y1 }

END { print sqrt(x1*x1) + sqrt(y1*y1) } # because no abs(), lol
