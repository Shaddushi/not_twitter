{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}

module Bdd where

import Data.Aeson (ToJSON,toJSON,FromJSON)
import Database.Selda
import Database.Selda.SQLite
import Data.Text (pack)
import Web.Scotty (rescue)

instance ToJSON (ID a) where
  toJSON = toJSON . pack . show . fromId



-- #################################################################################################################################

-- Table d'Utilisateur

data User = User
  { user_id :: ID User
  , user_name :: Text
  ,user_pseudo :: Text
  , user_mdp :: Text
  , user_description :: Text
  } deriving (Generic, Show,Eq)

instance SqlRow User
instance ToJSON User

user_table :: Table User
user_table = table "User" [#user_id :- autoPrimary, #user_name :- unique]


-- Table de tweet

data Tweet = Tweet
    { tweet_id :: ID Tweet
    , tweet_content :: Text
    , creator_id :: ID User
} deriving (Generic, Show)

instance SqlRow Tweet
instance ToJSON Tweet

tweet_table :: Table Tweet
tweet_table = table "Tweet" [ #tweet_id :- autoPrimary
                            , #creator_id :- foreignKey user_table #user_id]


-- Data type pour récupérer le username et mdp du recu de connexion

data NewUser = NewUser
    {
        newusername :: Text,
        newuser_mdp :: Text
    }deriving (Show, Generic)

instance FromJSON NewUser
instance ToJSON NewUser


-- #################################################################################################################################

-- Selectionne tout les utilisateurs 

dbSelectUsers :: SeldaT SQLite IO[User]
dbSelectUsers = query $ do
    select user_table

-- Check si l'utilisateur donné existe dans la BDD

dbCheckUserExist :: NewUser -> SeldaT SQLite IO[User]
dbCheckUserExist (NewUser user user_pswd) = query $ do
    u <- select user_table
    restrict (u ! #user_name .== literal user)
    restrict (u ! #user_mdp .== literal user_pswd)
    return u



-- juste pour tester la bdd

dbInit :: SeldaT SQLite IO ()
dbInit = do
    createTable user_table
    tryInsert user_table
       [
        User def  "Orson Welles" "a" "mdp" "Hello it's me !",
        User def  "Charlie Chaplin" "a" "mdp" "howwa",
        User def  "Claude Perron" "a" "mdp" "aaaaaaaaaaa",
        User def   "Albert Dupontel" "a" "mdp" "i'm cscared of claude",
        User def   "a" "a" "mdp" "i'm cscared of claude",           
        User def   "Fritz Lang" "a" "mdp" "Haskell movie next"] >>= liftIO . print

    createTable tweet_table
    tryInsert tweet_table
        [
        Tweet def "today i'm sleepy" (toId 1),
        Tweet def "Haskell >>>" (toId 3 ),
        Tweet def "...." (toId 2 )  ] >>= liftIO . print

