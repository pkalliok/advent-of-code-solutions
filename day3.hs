
import Data.List (tails, find)
import Data.Array (listArray, (!), elems)

adjCellsForSide :: Int -> Int -> Int -> [[Int]]
adjCellsForSide start length innerStart = firstAdj : restAdj where
 firstAdj = [start - 2, start - 1, innerStart, innerStart + 1]
 restAdj = zipWith (:) [start .. start + length - 2] innerAdj
 innerAdj = map (take 3) $ tails [innerStart .. innerStart + length - 2]

adjCellsForCircle :: Int -> Int -> Int -> [[Int]]
adjCellsForCircle start len inner = side1Start ++ rest where
 side1Start = [[start - 1, inner], [start - 1, start, inner, inner + 1]]
 rest = init $ drop 2 $ concat $ zipWith makeSide [0..] [0,0,0,1]
 makeSide side diff =
  adjCellsForSide (start + len*side) (len+diff) (inner - 1 + (len-2)*side)

adjCellsForSpiral :: [[Int]]
adjCellsForSpiral = initSeq ++ outerCircles where
 initSeq = [[1], [1,2], [1,2,3], [1,4], [1,4,5], [1,6], [1,2,6,7], [1,2,8]]
 outerCircles =
  concat $ zipWith3 adjCellsForCircle (tail circleStarts) [4,6..] circleStarts
 circleStarts = map (1+) $ map (^2) [1,3..]

memoryContents =
 listArray (1,99) $ 1 : map addFromAdjCells adjCellsForSpiral
 where addFromAdjCells cells = sum $ map (memoryContents!) cells

main = print $ find (> 277678) $ elems memoryContents

