module Settings.Config where

getConfigValue :: IO (String, String)
getConfigValue = do
  let repo = "https://registry.npmjs.org/"
      lol = "sfdf"
  return (repo, lol)
