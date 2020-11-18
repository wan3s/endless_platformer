{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Types where

import System.IO
import Graphics.Gloss
import System.Random

newtype XP = XP Int deriving (Eq, Ord, Num, Show)
newtype Score = Score Int deriving (Eq, Ord, Num, Show)

data Player = Player { playerPosition :: Point, playerScore :: Score, playerXP :: XP } deriving (Show)
data Enemy = Enemy { enemyPosition :: Point } deriving (Show)

data Battery = Battery { batteryPosiotion :: Point } deriving (Eq, Show)
data Transformer = Transformer { transformerPostion :: Point } deriving (Eq, Show)
data Cube = Cube { cubePosition :: Point } deriving (Show)

type Batteries = [Battery]
type Transformers = [Transformer]
type Cubes = [Cube]

data CubesState = CubesState { cubes :: Cubes, lastCubesHeight :: Float } deriving (Show)

data GameImages = GameImages { playerIm :: (Picture, Picture), enemyIm :: (Picture, Picture), transformerIm :: Picture, batteryIm :: Picture, cubeIm :: (Picture, Picture) }

data GameState = GameState { gameOver :: GameOver, player :: Player, enemy :: Enemy, batteries :: Batteries, transformers :: Transformers, cubesState :: CubesState, gameRandomGen :: StdGen, animation :: Animation } deriving (Show)

type FigureSize = Float
type GameOver = Bool
type Animation = Bool
