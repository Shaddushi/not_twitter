{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}


module Api where
import Bdd
import Web.Scotty
import Data.Aeson (object, (.=), FromJSON, ToJSON)
import Database.Selda.SQLite
import Web.Scotty.Internal.Types (ActionT(ActionT))
import GHC.TypeError (ErrorMessage(Text))
import Database.Selda (with)
import Data.Text (Text)

-- Définition des routes API
apiRoutes :: ScottyM ()
apiRoutes = do
    -- Route pour obtenir un message JSON
    get "/api/getUsers" $ do
        users <- liftIO $ withSQLite "twitter.db" dbSelectUsers
        let jsonUsers = object ["users" .= users]
        json jsonUsers
    -- Route de connexion
    post "/api/submitNewUser" $ do
        userData <-  jsonData :: ActionM NewUser
        returned_value <- liftIO $ withSQLite "twitter.db" (dbCheckUserExist userData)
        if returned_value /= []
            then
                json $ object ["username" .= user_name (head returned_value), "pseudo" .= user_pseudo  (head returned_value), "valid" .= True]
            else
                json $ object ["username" .= ("null" :: String), "pseudo" .= ("null" :: String) , "valid" .= False]
    post "/api/GetUser" $ do
        userData <- jsonData :: ActionM Text
        returned_value <- liftIO $ withSQLite "twitter.db" (dbGetUserInfo userData)
        if returned_value /= []
            then
                json $ object ["username" .= user_name (head returned_value),
                               "pseudo" .= user_pseudo  (head returned_value),
                               "description" .= user_description (head returned_value) ,
                               "valid" .= True]
            else
                json $ object ["username" .= ("null" :: String),
                               "pseudo" .= ("null" :: String),
                               "description" .= ("null" :: String),
                               "valid" .= False]

