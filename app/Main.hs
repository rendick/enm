module Main where

import System.Environment
import System.Exit
import System.IO (hFlush, stdout)
import GHC.Float (stgWord64ToDouble)
import GHC.Exception (SrcLoc(srcLocStartLine))

main :: IO ()
main = getArgs >>= parse >>= putStr . tac

tac :: String -> String
tac = unlines . reverse . lines

parse :: [String] -> IO String
parse ["help"] = usage >> exit
parse ["version"] = version >> exit
parse ["init"] = inits >> exit
parse []     = usage >> exit
parse fs     = concat <$> mapM readFile fs

usage :: IO ()
usage = do
 putStrLn ""
 mapM_ putStrLn help


version :: IO ()
version = putStrLn "enm v0.1.0"

inits :: IO ()
inits = do
 putStr "package name: "
 hFlush stdout
 packageName <- getLine
 putStrLn packageName

 putStr "version: (1.0.0) "
 hFlush stdout
 packageVersion <- getLine
 putStrLn packageVersion

 putStr "description: "
 hFlush stdout
 packageDescription <- getLine
 putStrLn packageDescription

 putStr "entry point: (index.js) "
 hFlush stdout
 packageEntryPoint <- getLine
 putStrLn packageEntryPoint

 putStr "test command: "
 hFlush stdout
 packageTest <- getLine
 putStrLn packageTest

 putStr "git repository: "
 hFlush stdout
 packageGit <- getLine
 putStrLn packageGit

 putStr "keywords: "
 hFlush stdout
 packageKeywords <- getLine
 putStrLn packageKeywords

 putStr "author: "
 hFlush stdout
 packageAuthor <- getLine
 putStrLn packageAuthor

 putStr "license: (ISC) "
 hFlush stdout
 packageLicense <- getLine
 putStrLn packageLicense

 putStr "Is this OK? (yes) "
 hFlush stdout
 packageIsThisOK <- getLine
 if packageIsThisOK `elem` ["yes", ""]
  then putStrLn "OK"
  else putStrLn "NOT OK"

help :: [String]
help = ["Usage: enm [ARGUMENT]"
	, ""
    , "npm init                          initialize the project"
    , "npm help npm                      more involved overview"
    , ""
    , "All commands:"
    , ""
    , "    access, adduser, audit, bugs, cache, ci, completion,"
    , "    config, dedupe, deprecate, diff, dist-tag, docs, doctor,"
    , "    edit, exec, explain, explore, find-dupes, fund, get, help,"
    , "    help-search, hook, init, install, install-ci-test,"
    , "    install-test, link, ll, login, logout, ls, org, outdated,"
    , "    owner, pack, ping, pkg, prefix, profile, prune, publish,"
    , "    query, rebuild, repo, restart, root, run-script, sbom,"
    , "    search, set, shrinkwrap, star, stars, start, stop, team,"
    , "    test, token, uninstall, unpublish, unstar, update, version,"
    , "    view, whoami"
      ]

exit :: IO a
exit = exitSuccess

die :: IO a
die = exitWith (ExitFailure 1)
