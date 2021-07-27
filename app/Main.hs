module Main where

import Lib
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
         <> help "No. of pieces a coconut cracks into"
         <> showDefault
         <> value 2
         <> metavar "INT" )

main :: IO ()
main = play =<< execParser opts
  where
    opts = info (argParser <**> helper)
      ( fullDesc
     <> progDesc "Simulate a single game of Coconut Crack with PLAYERS players"
     <> header "Coconut Crack simulator" )

play :: Args -> IO ()
play (Args players coconuts pieces) = putStrLn $ "players: " ++ show players ++ ", coconuts: " ++ show coconuts
