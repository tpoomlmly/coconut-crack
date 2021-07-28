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

-- |Simulates 1 round of the game - by default coconut-coconut-coconut-crack.
runRound :: Int -> Int -> [Player] -> [Player]
runRound coconuts maxPieces players = crack maxPieces $ iterate coconut players !! max 0 coconuts

isLoser :: Player -> Bool
isLoser (Crack _ pieceCount _) | pieceCount < 1 = True
isLoser _                      = False

playerId :: Player -> Int
playerId (Coconut n)   = n
playerId (Crack n _ _) = n

-- |Simulates the game until the last player stands. Returns the players in the order that they go out.
play :: Int -> Int -> Int -> [Int]
play playerCount coconuts maxPieces = play' coconuts maxPieces $ take playerCount $ map Coconut [1..]
  where
    play' :: Int -> Int -> [Player] -> [Int]
    play' _ _ [] = []
    play' coconuts maxPieces players = playerId loser : play' coconuts maxPieces survivors
      where
        -- Run rounds until someone is eliminated. They'll be at the head of the list when that happens.
        loser : survivors = head $ dropWhile (not . isLoser . head) $ iterate (runRound coconuts maxPieces) players