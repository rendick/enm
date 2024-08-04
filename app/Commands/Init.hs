module Commands.Init where

import System.IO (hFlush, stdout)

inits :: IO ()
inits = do
    putStr "package name: "
    hFlush stdout
    packageName <- getLine

    putStr "version: (0.1.0) "
    hFlush stdout
    packageVersion <- getLine
    let mainVersion = if null packageVersion then "0.1.0" else packageVersion

    putStr "description: "
    hFlush stdout
    packageDescription <- getLine

    putStr "entry point: (index.js) "
    hFlush stdout
    packageEntryPoint <- getLine
    let entryPoint = if null packageEntryPoint then "index.js" else packageEntryPoint

    putStr "test command: "
    hFlush stdout
    packageTest <- getLine

    putStr "git repository: "
    hFlush stdout
    packageGit <- getLine

    putStr "keywords: "
    hFlush stdout
    packageKeywords <- getLine

    putStr "author: "
    hFlush stdout
    packageAuthor <- getLine

    putStr "license: (ISC) "
    hFlush stdout
    packageLicense <- getLine
    let license = if null packageLicense then "ISC" else packageLicense

    putStr "Is this OK? (yes) "
    hFlush stdout
    packageIsThisOK <- getLine

    if packageIsThisOK `elem` ["yes", ""]
        then writeJsonPackage
        else putStrLn "Aborted"

writeJsonPackage :: IO ()
writeJsonPackage = do
 putStrLn "HELLO WORLD OK"
