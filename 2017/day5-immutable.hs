
import Data.Array (Array, listArray, bounds, (!))
import Control.Arrow ((***))

parseInput :: String -> Array Int Int
parseInput = (\ls -> listArray (1, length ls) ls) . map read . lines

withinBounds :: Int -> Array Int Int -> Bool
withinBounds index = uncurry (&&) . ((<= index) *** (>= index)) . bounds

solve jumps = countSteps 0 1 (jumps!) where
 countSteps steps ip jumpAt | withinBounds ip jumps =
  let offset = jumpAt ip
      newJumpAt newIp | ip == newIp = succ offset
                      | otherwise   = jumpAt newIp
  in countSteps (succ steps) (ip + offset) newJumpAt
 countSteps steps _ _ = steps

main = readFile "tmp/day5.txt" >>= print . solve . parseInput

