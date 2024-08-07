{-# LANGUAGE OverloadedStrings #-}

module Commands.Ping where 

import Network.HTTP.Simple
import Data.Time.Clock
import Text.Printf

ping :: IO()
ping = do
 start <- getCurrentTime
 let request = "https://registry.npmjs.org/" :: String
 response <- httpNoBody $ parseRequest_ request
 end <- getCurrentTime
 let responseTime = diffUTCTime end start

 printf "%senm%s notice %sPING%s %s\n" ("\x1b[1m" :: String) ("\x1b[0m" :: String) ("\x1b[34m" :: String) ("\x1b[0m" :: String) request
 printf "%senm%s notice %sPONG%s %dms\n" ("\x1b[1m" :: String) ("\x1b[0m" :: String) ("\x1b[34m" :: String) ("\x1b[0m" :: String) (floor (responseTime * 1000) :: Integer)
