module Platformer ( runGame ) where

import Types
import Graphics.Gloss.Interface.Pure.Game
import Constants
import CommonFunctions
import InitFunctions
import UpdateFunctions
import DrawFunctions
import HandleFunctions

runGame :: IO ()
runGame = do
            playerIm0 <- (loadImage "../img/player/state0.png")
            playerIm1 <- (loadImage "../img/player/state1.png")
            enemyIm0 <- (loadImage "../img/enemy/state0.png")
            enemyIm1 <- (loadImage "../img/enemy/state1.png")
            batIm <- (loadImage "../img/battery.png")
            transIm <- (loadImage "../img/transformer.png")
            cubesImB <- (loadImage "../img/cubes/base.png")
            cubesImT <- (loadImage "../img/cubes/top.png")
            play window background stepsPerSecond initMap (drawMap (GameImages (playerIm0, playerIm1) (enemyIm0, enemyIm1) batIm transIm (cubesImB, cubesImT))) handleEvent updateMap
