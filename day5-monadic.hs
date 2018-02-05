
import Data.Array.ST (STUArray)
import Data.Array.MArray (MArray, getBounds, newListArray, writeArray, readArray)
import Control.Monad.ST (ST, runST)

parseInput :: String -> [Int]
parseInput = map read . lines

withinBounds index arr =
 do (lower, upper) <- getBounds arr
    return $ (lower <= index) && (index <= upper)

solve rule jumps = runST $ (mkArray jumps >>= countJumps 0 1) where
 mkArray jumps =
  (newListArray (1, length jumps) jumps :: ST s (STUArray s Int Int))
 countJumps steps ip jumparr =
  do continue <- withinBounds ip jumparr
     if continue then
      do offset <- readArray jumparr ip
         writeArray jumparr ip (rule offset)
         countJumps (succ steps) (ip + offset) jumparr
     else return steps

firstHalfRule = succ

secondHalfRule n
 | n < 3 = succ n
 | True  = pred n

main =
 do input <- readFile "tmp/day5.txt"
    print $ solve firstHalfRule $ parseInput input
    print $ solve secondHalfRule $ parseInput input

-- $ time ./day5-monadic 
-- 378980
-- 26889114
--
-- real	0m23.582s
-- user	0m22.920s
-- sys	0m0.660s
