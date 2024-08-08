module Main where

import Commands.Check
import Commands.Explore
import Commands.Help
import Commands.Init
import Commands.Ls
import Commands.Ping
import Commands.Version
import Control.Applicative (WrappedArrow (unwrapArrow))
import System.Environment (getArgs)
import System.Exit (ExitCode (ExitFailure), exitSuccess, exitWith)
import System.Info (arch, os)

main :: IO ()
main = do
  let supportedOS = ["linux", "linux-android", "mingw32", "darwin", "openbsd", "netbsd"]
  let supportedArch = ["x86_64", "riscv64", "riscv32", "aarch64", "arm"]
  if os `elem` supportedOS
    then do
      if arch `elem` supportedArch
        then do
          args <- getArgs
          result <- parse args
          putStrLn $ tac result
        else do
          putStrLn $ "You are using " ++ os ++ " instead of " ++ unwords supportedArch
          return ()
    else do
      putStrLn $ "You are using " ++ os ++ " instead of " ++ unwords supportedOS
      return ()

tac :: String -> String
tac = unlines . reverse . lines

parse :: [String] -> IO String
parse ["help"] = usage >> exit
parse ["version"] = version >> exit
parse ["init"] = inits >> exit
parse ["ls"] = ls >> exit
parse ["ping"] = ping >> exit
parse ["explore"] = explore >> exit
parse ("check" : pkg : []) = check pkg >> exit
parse [] = usage >> exit
parse fs = concat <$> mapM readFile fs

usage :: IO ()
usage = mapM_ putStrLn help

exit :: IO a
exit = exitSuccess

die :: IO a
die = exitWith (ExitFailure 1)
