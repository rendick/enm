module Commands.Ls where

import Data.List (delete, intercalate, sortBy)
import Data.Ord (comparing)
import System.Directory (getCurrentDirectory, listDirectory)
import System.FilePath (takeFileName)
import System.IO (hPutStrLn, stderr)

lsDir :: IO ()
lsDir = do
  dir <- getCurrentDirectory
  let currentDir = takeFileName dir
  hPutStrLn stderr $ currentDir ++ "@0.0.1 " ++ dir

-- DOESN'T WORK PROPERLY
lsPackages :: IO ()
lsPackages = do
  result <- listDirectory "./node_modules"
  let filtered = delete ".package-lock.json" result
      sorted = sortBy (comparing length) filtered
      currentList = intercalate "\n" sorted
  hPutStrLn stderr currentList

ls :: IO ()
ls = do
  lsDir
  lsPackages
