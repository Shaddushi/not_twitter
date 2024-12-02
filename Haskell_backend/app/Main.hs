{-# LANGUAGE OverloadedStrings #-}

import Api
import Bdd
import Web.Scotty
import Data.Aeson (object, (.=))
import Network.Wai.Middleware.Cors (cors, CorsResourcePolicy(..), simpleCors)
import Control.Monad (when)
import Database.Selda (toId)
import Database.Selda.Backend (runSeldaT)
import Database.Selda.SQLite (sqliteOpen, seldaClose)
import System.Directory (doesFileExist)

main :: IO ()
main = do
    dbExists <- doesFileExist "twitter.db"
    conn <- sqliteOpen "twitter.db"
    when (not dbExists) $ runSeldaT dbInit conn
    scotty 8080 $ do
        middleware simpleCors
        apiRoutes
    
