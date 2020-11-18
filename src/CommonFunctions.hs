module CommonFunctions where

import Constants
import Types
import Graphics.Gloss
import Graphics.Gloss.Juicy

roundCubeOffset :: Float -> Float
roundCubeOffset off = -windowWidth + ((fromIntegral (floor ((off) / cubeSize)))) * (cubeSize)

currentColumnHeight :: Cubes -> Float -> Float
currentColumnHeight cubes x = head (map (\(Cube (_, b)) -> (b + cubeSize)) (filter (\(Cube (a, b)) -> a == x) cubes))

nextColumnHeight :: Cubes -> Float -> Float
nextColumnHeight cubes x = currentColumnHeight cubes (x + cubeSize)

loadImage :: String -> IO Picture
loadImage path = do
    pic <- (loadJuicyPNG path)
    case pic of
        Just im -> return im
        Nothing -> return (Circle (cubeSize / 2))

myFlatten :: [[Cube]] -> [Cube]
myFlatten [] = []
myFlatten (x:xs) = x ++ (myFlatten xs)

initCubesHeight :: FigureSize
initCubesHeight = -windowHeight + ((fromIntegral (floor ((windowHeight / 2) / cubeSize)))) * (cubeSize)

initPlayerPos :: Point
initPlayerPos = (roundCubeOffset (3 * windowWidth / 2), initCubesHeight + cubeSize)
