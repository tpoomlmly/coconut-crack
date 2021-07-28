module Lib ( play ) where

type PlayerNum = Int
-- |A player with a coconut
-- |or with n coconut pieces and a ordinal of which one was last checked
data Player = Coconut PlayerNum
            | Crack PlayerNum Int Int

rotateList :: [a] -> [a]
rotateList [] = []
rotateList (x:xs) = xs ++ [x]

-- |Performs the 'coconut' action - moves round to the next coconut fragment.
coconut :: [Player] -> [Player]
coconut (Crack playerNum pieceCount piece : players)
  | piece == pieceCount = rotateList (Crack playerNum pieceCount 1 : players)
  | otherwise           = Crack playerNum pieceCount (piece+1) : players
coconut players = rotateList players

-- |Performs the 'crack' action - moves round and cracks the next coconut.
crack :: Int -> [Player] -> [Player]
crack maxPieces players = crack' maxPieces (head rotated) : tail rotated
  where
    rotated = coconut players
    -- |Cracks the player's coconut.
    crack' :: Int -> Player -> Player
    crack' maxPieces (Coconut playerNum)                = Crack playerNum maxPieces 1
    crack' _         (Crack playerNum pieceCount piece) = Crack playerNum (pieceCount-1) (piece-1)


play :: Int -> Int -> Int -> [Int]
play 1 _ _ = [1]
play _ _ _ = []