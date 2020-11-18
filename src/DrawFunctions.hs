module DrawFunctions where

import Types
import Constants
import CommonFunctions
import Graphics.Gloss

drawCubeElement :: Point -> FigureSize -> Color -> Picture
drawCubeElement (x, y) size elemColor = color elemColor (Polygon [(x, y), (x + size, y), (x + size, y + size), (x, y + size)])

drawCube :: Point -> Picture -> Picture
drawCube (x, y) im = Translate (x + (cubeSize/2)) (y + (cubeSize/2)) im

drawPlayer :: Point -> Picture -> Picture
drawPlayer (x, y) im = Translate (x + 20) (y + 22) im

drawEnemy :: Enemy -> Picture -> Picture
drawEnemy (Enemy (x, y)) im = Translate (x + 20) (y + 22) im

drawBattery :: Point -> Picture -> Picture
drawBattery (x, y) im = Translate (x + 20) (y + 15) im

drawTransformer :: Point -> Picture -> Picture
drawTransformer (x, y) im = Translate (x + 20) (y + 20) im

drawScore :: Score -> Picture
drawScore score = color (makeColorI 0 0 255 255) (Translate (-windowWidth) (windowHeight - 25) (Scale textScale textScale (Text (show score))))

drawXP :: XP -> Picture
drawXP xp = color (makeColorI 255 0 0 255) (Translate (-windowWidth) (windowHeight - 50) (Scale textScale textScale (Text (show xp))))

drawGameOver :: Picture
drawGameOver = color (makeColorI 0 0 255 255) (Translate (-400) 0 (Text "GAME OVER!"))

drawHint :: Picture
drawHint = color (makeColorI 255 0 0 255) (Translate (-120) (-100) (Scale textScale textScale (Text "Press 'r' to restart")))

drawMap :: GameImages -> GameState -> Picture
drawMap _ (GameState True _ _ _ _ _ _ _ ) = Pictures ([drawGameOver] ++ [drawHint])
drawMap (GameImages
    (playerIm0, playerIm1)
    (enemyIm0, enemyIm1)
    batIm
    transIm
    (cubesImB, cubesImT))
    (GameState
    False
    (Player pos score xp)
    enemy
    batteries
    transformers
    (CubesState cubes h)
    gen
    anim) =
        Pictures
            ((map (\ (Cube pos) -> drawCube pos cubesImB)) (myFlatten (map (\ (Cube (a, b)) -> [Cube {cubePosition = (a, y)} | y <- [-windowHeight, (-windowHeight + cubeSize) .. ((currentColumnHeight cubes a) - cubeSize)]]) cubes))
                ++ (map (\ (Cube pos) -> drawCube pos cubesImT) cubes)
                ++ (map (\ (Transformer pos) -> drawTransformer pos transIm) transformers)
                ++ (map (\ (Battery pos) -> drawBattery pos batIm) batteries)
                ++ [drawPlayer pos (if anim then playerIm0 else playerIm1)]
                ++ [drawEnemy enemy (if anim then enemyIm0 else enemyIm1)]
                ++ [drawScore score]
                ++ [drawXP xp])
