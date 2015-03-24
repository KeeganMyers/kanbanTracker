{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}

module Model.Story where
import Data.Aeson
import GHC.Generics
import Prelude
import qualified Database.RethinkDB as R
import qualified Database.RethinkDB.NoClash

data Story { _name         :: Text
            , _description :: Text
            , _createdAt   :: UTCTime
            , _updatedAt   :: UTCTime
            , _assignedTo  :: Int
            , _estEnd      :: Maybe UTCTime
            , _points      :: Maybe Int
             _status       :: StoryStatus
           } deriving Show, Eq, Generic

data StoryStatus = Open | InProgress | Completed | Approved | Closed
  deriving (Show, Eq, Enum, Generic)

instance ToJSON StoryStatus
instance FromJSON StoryStatus
instance ToJSON Story
instance FromJSON Story

makeLenses ''Story
