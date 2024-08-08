{-# LANGUAGE OverloadedStrings #-}

module Commands.Ping where 

import Network.HTTP.Simple
import Data.Time.Clock
import Text.Printf
import Control.Exception (try, SomeException)

import Settings.Config (getConfigValue)

ping :: IO()
ping = do
 (repo, lol) <- getConfigValue
 start <- getCurrentTime
 let request = repo :: String
 responseResult <- try (httpNoBody $ parseRequest_ request) :: IO (Either SomeException (Response ()))
 end <- getCurrentTime
 let responseTime = diffUTCTime end start

 case responseResult of
  Left _ -> printf "%senm%s error %sPING%s %s\n%senm%s error %sERROR%s \n" 
                       ("\x1b[1m" :: String) ("\x1b[0m" :: String) 
                       ("\x1b[34m" :: String) ("\x1b[0m" :: String) request 
                       ("\x1b[1m" :: String) ("\x1b[0m" :: String) 
                       ("\x1b[31m" :: String) ("\x1b[0m" :: String) 
  Right _ -> do
       printf "%senm%s notice %sPING%s %s\n" 
              ("\x1b[1m" :: String) ("\x1b[0m" :: String) 
              ("\x1b[34m" :: String) ("\x1b[0m" :: String) request
       printf "%senm%s notice %sPONG%s %dms\n" 
              ("\x1b[1m" :: String) ("\x1b[0m" :: String) 
              ("\x1b[34m" :: String) ("\x1b[0m" :: String) 
              (floor (responseTime * 1000) :: Integer)
