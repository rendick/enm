module Commands.Ls where

import Data.List (delete, intercalate, sortBy)
import Data.Ord (comparing)
import System.Directory (getCurrentDirectory, listDirectory)
import System.FilePath (takeFileName)
import System.IO (hPutStrLn, stderr)
import Control.Exception (try, SomeException)

lsDir :: IO ()
lsDir = do
  dir <- getCurrentDirectory
  let currentDir = takeFileName dir
  hPutStrLn stderr $ currentDir ++ "@0.0.1 " ++ dir

-- DOESN'T WORK PROPERLY
lsPackages :: IO ()
lsPackages = do
  result <- try  (listDirectory "./node_modules") :: IO (Either SomeException [FilePath])
  case result of 
   Left err -> hPutStrLn stderr $ "Error: " ++ show err
   Right files -> do
    let filtered = delete ".package-lock.json" files
        sorted = sortBy (comparing length) filtered
        currentList = intercalate "\n" sorted
    hPutStrLn stderr currentList

ls :: IO ()
ls = do
  lsDir
  lsPackages
