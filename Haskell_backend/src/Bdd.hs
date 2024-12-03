{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TypeOperators #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}

module Bdd where

import Data.Aeson (ToJSON,toJSON)
import Database.Selda
import Database.Selda.SQLite
import Data.Text (pack)

instance ToJSON (ID a) where
  toJSON = toJSON . pack . show . fromId


data User = User
  { user_id :: ID User
  , user_name :: Text
  , user_description :: Text
  } deriving (Generic, Show)

instance SqlRow User
instance ToJSON User

user_table :: Table User
user_table = table "User" [#user_id :- autoPrimary]


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


dbSelectUsers :: SeldaT SQLite IO[User]
dbSelectUsers = query $ do
    select user_table




dbInit :: SeldaT SQLite IO ()
dbInit = do
    createTable user_table
    tryInsert user_table
       [
        User def  "Orson Welles" "Hello it's me !",
        User def  "Charlie Chaplin" "howwa",
        User def  "Claude Perron" "aaaaaaaaaaa",
        User def   "Albert Dupontel" "i'm cscared of claude",
        User def   "Fritz Lang" "Haskell movie next"] >>= liftIO . print

    createTable tweet_table
    tryInsert tweet_table
        [
        Tweet def "today i'm sleepy" (toId 1),
        Tweet def "Haskell >>>" (toId 3 ),
        Tweet def "...." (toId 2 )  ] >>= liftIO . print

