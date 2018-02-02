{-# LANGUAGE FlexibleContexts #-}

import Data.Array.ST (STUArray)
import Data.Array.MArray (MArray, getBounds, newListArray, writeArray, readArray)
import Control.Monad.ST (ST, runST)

parseInput :: String -> [Int]
parseInput = map read . lines

withinBounds index arr =
 do (lower, upper) <- getBounds arr
    return $ (lower <= index) && (index <= upper)

countJumps :: MArray a Int m => Int -> Int -> a Int Int -> m Int
countJumps steps ip jumparr =
  do continue <- withinBounds ip jumparr
     if continue then
      do offset <- readArray jumparr ip
         writeArray jumparr ip (succ offset)
         countJumps (succ steps) (ip + offset) jumparr
     else return steps

solve jumps = runST
 $ ((newListArray (1, length jumps) jumps :: ST s (STUArray s Int Int))
    >>= countJumps 0 1)

main = readFile "tmp/day5.txt" >>= print . solve . parseInput

