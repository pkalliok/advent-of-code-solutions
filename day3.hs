
import Data.List (tails, concatMap, find)
import Data.Array (listArray, (!), elems)

adjCellsForSide :: Int -> Int -> Int -> [[Int]]
adjCellsForSide start length innerStart = firstAdj : restAdj where
 firstAdj = [innerStart, innerStart + 1, start - 2, start - 1]
 restAdj = zipWith (++) innerAdj thisRoundAdj
 innerAdj = map (take 3) $ tails [innerStart .. innerStart + length - 2]
 thisRoundAdj = map (:[]) [start .. start + length - 2]

adjCellsForCircle :: Int -> Int -> Int -> [[Int]]
adjCellsForCircle start len inner = side1 ++ side2 ++ side3 ++ side4 where
 side1 = side1Start ++ side1Rest
 side1Start = [[inner, start - 1], [inner, inner + 1, start - 1, start]]
 side1Rest = drop 2 $ adjCellsForSide start len (inner-1)
 side2 = adjCellsForSide (start + len) len (inner - 3 + len)
 side3 = adjCellsForSide (start + len*2) len (inner - 1 + (len-2)*2)
 side4 = init $ adjCellsForSide (start + len*3) (len+1) (inner - 1 + (len-2)*3)

uncurry3 f (a, b, c) = f a b c

adjCellsForSpiral :: [[Int]]
adjCellsForSpiral = initSeq ++ outerCircles where
 initSeq = [[1], [1,2], [1,2,3], [1,4], [1,4,5], [1,6], [1,2,6,7], [1,2,8]]
 outerCircles = concatMap (uncurry3 adjCellsForCircle) circleParams
 circleParams = zip3 (tail circleStarts) [4,6..] circleStarts
 circleStarts = map (1+) $ map (^2) [1,3..]

memoryContents =
 listArray (1,99) $ 1 : map addFromAdjCells adjCellsForSpiral
 where addFromAdjCells cells = sum $ map (memoryContents!) cells

main = print $ find (> 277678) $ elems memoryContents

