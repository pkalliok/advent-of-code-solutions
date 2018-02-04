
import Data.Array.IO (IOUArray)
import Data.Array.MArray (MArray, getBounds, newListArray, writeArray, readArray)

parseInput :: String -> [Int]
parseInput = map read . lines

withinBounds index arr =
 do (lower, upper) <- getBounds arr
    return $ (lower <= index) && (index <= upper)

solve rule jumps = (mkArray jumps >>= countJumps 0 1) where
 mkArray jumps =
  (newListArray (1, length jumps) jumps :: IO (IOUArray Int Int))
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
    let parsed = parseInput input
    solution1 <- solve firstHalfRule parsed
    solution2 <- solve secondHalfRule parsed
    putStrLn ("First: " ++ show solution1 ++ ", second: " ++ show solution2)

