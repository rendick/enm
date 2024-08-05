module Commands.Ls where

import System.Directory (getCurrentDirectory)
import System.FilePath (takeFileName)
import System.IO (hPutStrLn, stderr)

ls :: IO ()
ls = do
 dir <- getCurrentDirectory
 let currentDir = takeFileName dir
 hPutStrLn stderr $ currentDir ++ "@0.0.1 " ++ dir
