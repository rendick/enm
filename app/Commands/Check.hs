module Commands.Check where

import Settings.Config (getConfigValue)

check :: IO ()
check = do
  (url, lol) <- getConfigValue
  putStrLn url
  putStrLn lol
