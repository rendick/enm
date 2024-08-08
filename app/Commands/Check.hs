module Commands.Check where

import Control.Exception (SomeException, try)
import qualified Data.ByteString.Lazy.Char8 as L8
import Data.Time.Clock
import Network.HTTP.Simple
import Settings.Config (getConfigValue)
import Text.Printf

check :: String -> IO ()
check package = do
  (repo, _) <- getConfigValue
  let request = repo ++ package :: String
  responseResult <- try (httpLBS $ parseRequest_ request) :: IO (Either SomeException (Response L8.ByteString))

  case responseResult of
    Left _ ->
      printf
        "%senm%s notice %sPING%s %s \n%senm%s notice %sERROR CHECKING%s %s"
        ("\x1b[1m" :: String)
        ("\x1b[0m" :: String)
        ("\x1b[34m" :: String)
        ("\x1b[0m" :: String)
        request
        ("\x1b[1m" :: String)
        ("\x1b[0m" :: String)
        ("\x1b[31m" :: String)
        ("\x1b[0m" :: String)
        package
    Right response -> do
      let statusCode = getResponseStatusCode response
      let body = getResponseBody response
      putStrLn $ "Status code: " ++ show statusCode
      let responseCodeResult =
            if statusCode /= 404
              then
                printf
                  "%senm%s notice %sPING%s %s \n%senm%s notice %sFOUND%s %s [%d]"
                  ("\x1b[1m" :: String)
                  ("\x1b[0m" :: String)
                  ("\x1b[34m" :: String)
                  ("\x1b[0m" :: String)
                  request
                  ("\x1b[1m" :: String)
                  ("\x1b[0m" :: String)
                  ("\x1b[32m" :: String)
                  ("\x1b[0m" :: String)
                  package
                  statusCode
              else
                printf
                  "%sENM%s notice %sPING%s %s \n%sENM%s notice %sNOT FOUND%s %s [%d]"
                  ("\x1b[1m" :: String)
                  ("\x1b[0m" :: String)
                  ("\x1b[34m" :: String)
                  ("\x1b[0m" :: String)
                  request
                  ("\x1b[1m" :: String)
                  ("\x1b[0m" :: String)
                  ("\x1b[31m" :: String)
                  ("\x1b[0m" :: String)
                  package
                  statusCode
      putStrLn responseCodeResult
