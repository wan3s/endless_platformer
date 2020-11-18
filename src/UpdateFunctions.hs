module UpdateFunctions where

import Types
import Constants
import CommonFunctions
import System.Random

updateCubes :: Float -> Cubes -> Cubes
updateCubes n (x:xs) =
    (map (\(Cube (x, y)) -> Cube (x - cubeSize, y)) xs)
    ++ [Cube {cubePosition = ( roundCubeOffset (2 * windowWidth), n) }]

updateEnemy :: Cubes -> Enemy -> Enemy
updateEnemy cubes (Enemy (x, y)) = Enemy (x,  (nextColumnHeight cubes x))

updatePlayer :: Cubes -> Batteries -> Transformers -> Player -> Player
updatePlayer cubes bat trans player@(Player (x, y) score xp) = player {
        playerPosition = if (y < nextH) then (x - cubeSize, y) else (x,  nextH),
        playerScore = score + scoreInc,
        playerXP = xp - decXP + batXP + transXP
    }
    where
        nextH = nextColumnHeight cubes x
        batXP = batIncXP * (XP (length (filter (\ (Battery (batX, batY)) -> batX <= x) bat)))
        transXP = transIncXP * (XP (length (filter (\ (Transformer (transX, transY)) -> transX <= x) trans)))

updateBatteries :: Cubes -> Player -> Batteries -> Batteries
updateBatteries cubes (Player (x, _) _ _) bat =
    batLst
    ++ (if (last < windowWidth) then [Battery (last, nextColumnHeight cubes last)] else [])
    where
        batLst = (map (\(Battery (batX, batY)) -> (Battery (batX - cubeSize, batY))) (filter (\ (Battery (batX, batY)) -> batX > x) bat))
        revBatLst = reverse batLst
        last = (if (revBatLst == [])
            then
                roundCubeOffset (2 * windowWidth) - cubeSize
            else
                (\ (Battery (x, y)) -> x) (head revBatLst) + batSteps * cubeSize)

updateTransformers :: Cubes -> Player -> Transformers -> Transformers
updateTransformers cubes (Player (x, _) _ _) trans =
    transLst
    ++ (if (last < windowWidth) then [Transformer (last, nextColumnHeight cubes last)] else [])
    where
        transLst = (map (\(Transformer (transX, transY)) -> (Transformer (transX - cubeSize, transY))) (filter (\ (Transformer (transX, transY)) -> transX > x) trans))
        revTransLst = reverse transLst
        last = (if (revTransLst == [])
            then
                roundCubeOffset (2 * windowWidth) - cubeSize
            else
                (\ (Transformer (x, y)) -> x) (head revTransLst) + transSteps * cubeSize)

updateMap :: Float -> GameState -> GameState
updateMap _ game@(GameState
    gO
    pl@(Player (x, y) score xp)
    en@(Enemy (a, b))
    bat
    trans
    (CubesState cubesLst cubesHeight)
    seed
    anim) = if ((x <= a) || (xp == 0))
        then game {gameOver = True}
        else game {
            player = (updatePlayer cubesLst bat trans pl),
            enemy = (updateEnemy cubesLst en),
            batteries = (updateBatteries cubesLst pl bat),
            transformers = (updateTransformers cubesLst pl trans),
            cubesState = (CubesState (updateCubes newCubesHeight cubesLst) newCubesHeight),
            gameRandomGen = newGen,
            animation = (not anim) }
        where
            (n, newGen) = randomR range seed
            tmp = (fromIntegral (floor n)) - 1
            newCubesHeight = min 0 (max (cubesHeight + (tmp * cubeSize)) (-windowHeight))
