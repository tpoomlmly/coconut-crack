module Main where

import Lib ( play )
import Options.Applicative
import Data.Semigroup ((<>))

data Args = Args
  { players  :: Int
  , coconuts :: Int
  , pieces   :: Int }

argParser :: Parser Args
argParser = Args
      <$> argument auto
          ( metavar "PLAYERS"
         <> help "No. of players in the game" )
      <*> option auto
          ( long "coconuts"
         <> short 'c'
         <> help "No. of coconuts before a crack"
         <> showDefault
         <> value 3
         <> metavar "INT" )
      <*> option auto
          ( long "pieces"
         <> short 'p'
         <> help "No. of pieces a coconut cracks into - 0 means the coconut is destroyed on the 1st crack"
         <> showDefault
         <> value 2
         <> metavar "INT" )

main :: IO ()
main = validateAndRun =<< execParser opts
  where
    opts = info (argParser <**> helper)
      ( fullDesc
     <> progDesc "Simulate a single game of Coconut Crack with PLAYERS players"
     <> header "Coconut Crack simulator" )

validateAndRun :: Args -> IO ()
validateAndRun (Args players coconuts pieces)
  | players < 1  = putStrLn "You need at least 1 player to play!"
  | coconuts < 0 = putStrLn "You need at least 0 coconuts before each crack!"
  | pieces < 0   = putStrLn "Coconuts have to split into at least 0 pieces!"
  | otherwise    = do putStrLn $ show (players - 1) ++ " player(s) lose in this order:"
                      sequence_ $ printResult (play players coconuts pieces)

printResult :: [Int] -> [IO ()]
printResult []       = [putStrLn ""]
printResult [winner] = [putStrLn $ show winner ++ " wins"]
printResult (loser:players) = print loser : printResult players
