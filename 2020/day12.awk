
BEGIN { dir = 0; x1 = 0; y1 = 0; wpx = 10; wpy = -1; x2 = 0; y2 = 0; }

{ arg = substr($0,2); }

/^N/ { y1 -= arg; wpy -= arg; }
/^S/ { y1 += arg; wpy += arg; }
/^W/ { x1 -= arg; wpx -= arg; }
/^E/ { x1 += arg; wpx += arg; }
/^R/ { dir = (dir + 360 - arg) % 360 }
/^L/ { dir = (dir + arg) % 360 }
/^(R90|L270)$/ { tmp = wpx; wpx = -wpy; wpy = tmp; }
/^(L90|R270)$/ { tmp = -wpx; wpx = wpy; wpy = tmp; }
/^[LR]180$/ { wpx = -wpx; wpy = -wpy; }
/^F/ { y1 += arg * (dir == 270) - arg * (dir == 90);
	x1 += arg * (dir == 0) - arg * (dir == 180);
	y2 += arg * wpy; x2 += arg * wpx; }

END { print sqrt(x1*x1) + sqrt(y1*y1) } # because no abs(), lol
END { print sqrt(x2*x2) + sqrt(y2*y2) }
