module InitFunctions where

import Types
import Constants
import CommonFunctions
import System.Random

initPlayer :: Player
initPlayer = Player { playerPosition = initPlayerPos, playerScore = Score 0, playerXP = XP 100 }

initEnemy :: Enemy
initEnemy = Enemy { enemyPosition = (roundCubeOffset (windowWidth/2), initCubesHeight + cubeSize) }

initBatteries :: Batteries
initBatteries = [Battery { batteryPosiotion = (start, initCubesHeight + cubeSize) }]
    where start = (fst (initPlayerPos)) + batSteps * cubeSize

initTransformers :: Transformers
initTransformers = [ Transformer { transformerPostion = (start, initCubesHeight + cubeSize) } ]
    where start = (fst (initPlayerPos)) + transSteps * cubeSize

initCubes :: CubesState
initCubes = CubesState [Cube {cubePosition = (x, initCubesHeight) } | x <- [-windowWidth, (-windowWidth + cubeSize) .. windowWidth]] initCubesHeight

initMap :: GameState
initMap = GameState False initPlayer initEnemy initBatteries initTransformers initCubes (mkStdGen 0) False
