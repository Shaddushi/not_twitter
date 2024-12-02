{-# LANGUAGE OverloadedStrings #-}

module Api where
import Bdd
import Web.Scotty
import Data.Aeson (object, (.=),encode)
import Database.Selda.SQLite

-- Définition des routes API
apiRoutes :: ScottyM ()
apiRoutes = do
    -- Route pour obtenir un message JSON
    get "/api/getUsers" $ do
        users <- liftIO $ withSQLite "twitter.db" dbSelectUsers
        let jsonUsers = object ["users" .= users] 
        json jsonUsers 
    post "/submit" $ do
        userData <- jsonData
        liftIO $ print userData