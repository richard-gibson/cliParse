module Lib ( cliParse ) where

import Options.Applicative
import Data.Semigroup ((<>))

type ItemIndex = Int

type ItemDescription = Maybe String

data Options = Options FilePath ItemIndex ItemDescription deriving Show

optionsParser :: Parser Options
optionsParser = Options
  <$> dataPathParser
  <*> itemIndexParser
  <*> updateItemDescriptionParser

itemIndexParser :: Parser ItemIndex
itemIndexParser = argument auto ( metavar "ITEMINDEX" <> help "item index")

itemDescriptionValueParser :: Parser String
itemDescriptionValueParser =
  strOption (long "desc" <> short 'd' <> metavar "DESCRIPTION" <> help "description")

defaultDataPath :: FilePath
defaultDataPath = "~/.to-do.yaml"

dataPathParser :: Parser FilePath
dataPathParser = strOption $
  value defaultDataPath
  <> long "data-path"
  <> short 'p'
  <> metavar "DATAPATH"
  <> help ("path to data file (default " ++ defaultDataPath ++ ")")

updateItemDescriptionParser :: Parser ItemDescription
updateItemDescriptionParser =
  Just <$> itemDescriptionValueParser
  <|> flag' Nothing (long "clear-desc")

cliParse :: IO ()
cliParse = do
  options <- execParser (info (optionsParser)(progDesc "To-do list manager"))
  putStrLn $ "options=" ++ show options
--  itemIndex <- execParser (info(itemIndexParser)(progDesc "To-do list manager"))
--  putStrLn $ "itemIndex=" ++ show itemIndex
