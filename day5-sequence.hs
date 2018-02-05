
import Data.Sequence (Seq, fromList, lookup, adjust')
import Control.Arrow ((&&&))

parseInput :: String -> Seq Int
parseInput = fromList . map read . lines

solve rule = countSteps 0 0 where
 countSteps steps ip jumps =
  case Data.Sequence.lookup ip jumps of
     Nothing  -> steps
     Just dip -> countSteps (succ steps) (ip + dip) (adjust' rule ip jumps)

firstHalfRule = succ
secondHalfRule n
 | n < 3 = succ n
 | True  = pred n

main = readFile "tmp/day5.txt" >>=
       print . (solve firstHalfRule &&& solve secondHalfRule) . parseInput

-- $ time ./day5-sequence 
-- (378980,26889114)
--
-- real	0m19.754s
-- user	0m18.968s
-- sys	0m0.716s
