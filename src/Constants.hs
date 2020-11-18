module Constants where

import Types
import Graphics.Gloss

window :: Display
window = FullScreen

background :: Color
background = makeColorI 168 216 255 255

cubeSize :: FigureSize
cubeSize = 40

cubeIntColor :: Color
cubeIntColor = makeColorI 150 75 0 255

cubeBorderColor :: Color
cubeBorderColor = makeColorI 28 84 45 255

cubeBorderWidth :: FigureSize
cubeBorderWidth = 7

windowWidth :: Float -- a half of Width
windowWidth = 720

windowHeight :: Float -- a half of Height
windowHeight = 450

stepsPerSecond :: Int
stepsPerSecond = 5

range :: (Float, Float)
range = (0.0, 2.9)

textScale :: Float
textScale = 0.20

batSteps :: Float
batSteps = 3

batIncXP :: XP
batIncXP = 2

transSteps :: Float
transSteps = 7

transIncXP :: XP
transIncXP = 8

decXP :: XP
decXP = 1

scoreInc :: Score
scoreInc = 1
