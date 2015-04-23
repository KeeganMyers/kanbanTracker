{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}

module Model.Story where

import Database.RethinkDB
import Data.Text (Text)
import Data.Time (UTCTime)
import Data.Aeson (FromJSON, ToJSON)
import Control.Lens
import GHC.Generics
import Database.RethinkDB

data Story = Story { _name         :: Text
            , _description :: Text
            , _createdAt   :: UTCTime
            , _updatedAt   :: UTCTime
            , _assignedTo  :: Int
            , _estEnd      :: Maybe UTCTime
            , _points      :: Maybe Int
            , _status       :: StoryStatus
           } deriving(Show, Eq, Generic)

data StoryStatus = Open | InProgress | Completed | Approved | Closed
  deriving (Show, Eq, Enum, Generic)

instance ToJSON StoryStatus
instance FromJSON StoryStatus
instance ToJSON Story
instance FromJSON Story
instance ToDatum Story
instance FromDatum Story

makeLenses ''Story
