module HandleFunctions where

import Types
import Constants
import CommonFunctions
import InitFunctions
import Graphics.Gloss.Interface.Pure.Game

handleEvent :: Event -> GameState -> GameState
handleEvent (EventKey (SpecialKey KeySpace) Down _ _) game@(GameState _ (Player (x, y) score xp) _ _ _ _ _ _) =
    game { player = (Player (x, y + cubeSize) score xp) }
handleEvent (EventKey (SpecialKey KeySpace) Up _ _) game@(GameState _ (Player (x, y) score xp) _ _ _ (CubesState cubes cubesHeight) _ _) =
    game {
        player = (Player (x, (currentColumnHeight cubes x)) score xp),
        cubesState = (CubesState cubes cubesHeight) }
handleEvent (EventKey (Char 'r') Down _ _) _ = initMap
handleEvent _ gameState = gameState
