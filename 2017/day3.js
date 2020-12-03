
var R = require('ramda');
var pr = console.log.bind(console);

var circleOf = R.compose(Math.floor, R.flip(R.divide)(2), R.inc,
		Math.floor, Math.sqrt, R.dec);

var firstOfCircle = R.pipe(R.multiply(2), R.dec,
		R.ap(R.multiply, R.identity), R.inc);

var phase = R.ap(R.subtract, R.pipe(circleOf, firstOfCircle));

var circleLength = R.ap(R.compose(R.subtract, firstOfCircle, R.inc),
		firstOfCircle);

// var sawtoothFromPhaseAndLength =
// 	R.curry((ph, len) => Math.abs(len / 2 - (ph+1) % len));

// lambdabot> pl \ph len -> abs(len / 2 - ((ph + 1) `mod` len))
// = \len -> abs . (-) (len / 2) . (`mod` len) . (1 +)
// = (abs .) . ap ((.) . (-) . (/ 2)) ((. (1 +)) . flip mod)
// = (abs .) . liftM2 (-) (/ 2) . mod . (1 +)

var liftM2 = R.curry((f, g, h) => R.converge(f, [g, h]));
var sawtoothFromPhaseAndLength
	= R.compose(R.partial(R.compose, [Math.abs]),
			liftM2(R.subtract, R.divide(R.__, 2)),
			R.modulo, R.inc);

var distanceOnSide = R.ap(R.compose(sawtoothFromPhaseAndLength, phase),
		R.compose(R.divide(R.__, 4), circleLength, circleOf));

var distance = R.converge(R.add, [circleOf, distanceOnSide]);

// R.forEach((n => pr(n, distance(n))), R.range(0,35));

pr(distance(277678));

