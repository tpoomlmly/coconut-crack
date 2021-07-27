module Lib ( play ) where

play :: Int -> Int -> Int -> [Int]
play 1 _ _ = [1]
play _ _ _ = []