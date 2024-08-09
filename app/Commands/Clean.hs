module Commands.Clean where

import System.Directory (doesFileExist, removeFile, doesDirectoryExist, removeDirectoryRecursive)
import Text.Printf (printf)

clean :: IO ()
clean = do
  let fileName = ["package-lock.json", "node_modules"]
  mapM_ cleanFile fileName
  where 
    cleanFile :: FilePath -> IO ()
    cleanFile path = do
      fileExist <- doesFileExist path
      dirExist <- doesDirectoryExist path
      if fileExist
        then do 
          removeFile path
          printf "%s%s%s reports %sFILE DELETION%s %s\n"         
            ("\x1b[1m" :: String)
            "enm"
            ("\x1b[0m" :: String)
            ("\x1b[34m" :: String)
            ("\x1b[0m" :: String)
            path
        else if dirExist
          then do 
            removeDirectoryRecursive path 
            printf "%s%s%s reports %sDIRECTORY DELETION%s %s\n"         
              ("\x1b[1m" :: String)
              "enm"
              ("\x1b[0m" :: String)
              ("\x1b[34m" :: String)
              ("\x1b[0m" :: String)
              path
          else do 
            printf "%s%s%s reports %sFILE OR DIRECTORY DOES NOT EXIST%s %s\n"
              ("\x1b[1m" :: String)
              "enm"
              ("\x1b[0m" :: String)
              ("\x1b[34m" :: String)
              ("\x1b[0m" :: String)
              path
