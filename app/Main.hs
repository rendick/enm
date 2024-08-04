module Main where

import Commands.Init 
import Commands.Help
import Commands.Version

import System.Environment (getArgs)
import System.Exit (exitSuccess, exitWith, ExitCode(ExitFailure))
import System.IO (hFlush, stdout)

main :: IO ()
main = getArgs >>= parse >>= putStr . tac

tac :: String -> String
tac = unlines . reverse . lines

parse :: [String] -> IO String
parse ["help"] = usage >> exit
parse ["version"] = version >> exit
parse ["init"] = inits >> exit
parse [] = usage >> exit
parse fs = concat <$> mapM readFile fs

usage :: IO ()
usage = do
    mapM_ putStrLn help

exit :: IO a
exit = exitSuccess

die :: IO a
die = exitWith (ExitFailure 1)
