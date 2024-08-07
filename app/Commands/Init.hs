module Commands.Init where

import System.IO (hFlush, stdout, writeFile)

message :: IO ()
message = do
  let warningMsg =
        unlines
          [ "This utility will walk you through creating a package.json file.",
            "It only covers the most common items, and tries to guess sensible defaults.",
            "",
            "See enm help init for definitive documentation on these fields",
            "and exactly what they do.",
            "",
            "Use enm install <pkg> afterwards to install a package and",
            "save it as a dependency in the package.json file.",
            "",
            "Press ^C at any time to quit."
          ]
  putStrLn warningMsg

inits :: IO ()
inits = do
  message

  putStr "package name: "
  hFlush stdout
  packageName <- getLine

  putStr "version: (0.1.0) "
  hFlush stdout
  packageVersion <- getLine
  let mainVersion =
        if null packageVersion
          then "0.1.0"
          else packageVersion

  putStr "description: "
  hFlush stdout
  packageDescription <- getLine

  putStr "entry point: (index.js) "
  hFlush stdout
  packageEntryPoint <- getLine
  let entryPoint =
        if null packageEntryPoint
          then "index.js"
          else packageEntryPoint

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
  let license =
        if null packageLicense
          then "ISC"
          else packageLicense

  putStr "Is this OK? (yes) "
  hFlush stdout
  packageIsThisOK <- getLine

  if packageIsThisOK `elem` ["yes", ""]
    then writeJsonPackage packageName mainVersion packageDescription entryPoint packageGit packageKeywords packageAuthor license
    else putStrLn "Aborted"

writeJsonPackage :: String -> String -> String -> String -> String -> String -> String -> String -> IO ()
writeJsonPackage packageName mainVersion packageDescription entryPoint packageGit packageKeywords packageAuthor license = do
  let packageJson =
        unlines
          [ "{",
            "  \"name\": \"" ++ packageName ++ "\",",
            "  \"version\": \"" ++ mainVersion ++ "\",",
            "  \"main\": \"" ++ entryPoint ++ "\",",
            "  \"description\": \"" ++ packageDescription ++ "\",",
            "  \"scripts\": {",
            "    \"test\": \"echo \\\"Error: no test specified\\\" && exit 1\"",
            "  },",
            "  \"repository\": {",
            "    \"type\": \"git\",",
            "    \"url\": \"" ++ packageGit ++ "\"",
            "  },",
            "  \"keywords\": \"" ++ "[" ++ packageKeywords ++ "]" ++ "\",",
            "  \"author\": \"" ++ packageAuthor ++ "\",",
            "  \"license\": \"" ++ license ++ "\"",
            "}"
          ]

  writeFile "package.json" packageJson
