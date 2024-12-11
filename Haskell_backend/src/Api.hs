{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}


module Api where
import Bdd
import Web.Scotty
import Data.Aeson (object, (.=), FromJSON, ToJSON)
import Database.Selda.SQLite
import GHC.Generics (Generic)
import Control.Applicative (liftA)



-- Définition des routes API
apiRoutes :: ScottyM ()
apiRoutes = do
    -- Route pour obtenir un message JSON
    get "/api/getUsers" $ do
        users <- liftIO $ withSQLite "twitter.db" dbSelectUsers
        let jsonUsers = object ["users" .= users]
        json jsonUsers
    post "/api/submitNewUser" $ do
        userData <-  jsonData :: ActionM NewUser
        liftIO $ print userData
        returned_value <- liftIO $ withSQLite "twitter.db" (dbCheckUserExist userData)
        if returned_value /= []
            then do
                json $ object ["username" .= user_name (head returned_value), "pseudo" .= user_pseudo  (head returned_value), "valid" .= True]
            else
                json $ object ["username" .= ("null" :: String), "pseudo" .= ("null" :: String) , "valid" .= False]

