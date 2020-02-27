module Render.Renderer (DisplaySettings(..), startRenderer, getScreenSize) where

import CPU.CPU
import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Graphics.Gloss.Interface.IO.Game
import Graphics.Gloss.Interface.Environment (getScreenSize)
import Data.Word
import Data.ByteString (ByteString, pack) -- Same as a bitmap


{-  Represents a holder for all display variables
    Stores variables used for the creaton of a display

    INVARIANT: used for functions asociated with startRenderer
-}
data DisplaySettings = Settings
    {
        size       :: (Int, Int),
        fps        :: Int
    } deriving (Show)

{-  createFrame settings pixels
    converts the given pixels into a renderer readable picture

    PRE: The number of pixels is equal to the number of pixels required for the given screen size
    RETURNS: A renderer readable picture created from the given pixels
    Examples: createFrame (Settings (2,2) 60) (replicate 64*32 0) == (A black picture at 2x pixel scale)
-}
createFrame :: DisplaySettings -> [Int] -> Picture
createFrame s pixels = bitmapOfByteString 64 32 (BitmapFormat (TopToBottom) (PxRGBA)) bitmapData False
    where
        bitmapData = createBitmapData pixels

        createBitmapData :: [Int] -> ByteString
        createBitmapData a = pack $ foldl f [] a
            where
                onCollor  = [255,255,255,255] :: [Word8]
                offCollor = [0,0,0,255]       :: [Word8]
                
                f :: [Word8] -> Int -> [Word8]
                f a 1 = a ++ onCollor
                f a _ = a ++ offCollor

{-  renderer settings func cpu
    Applies createFrame to the pixels created from applying func to cpu

    PRE: cpu is in a functional state,
         The number of pixels is equal to the number of pixels required for the given screen size
    RETURNS: A renderer readable picture created from the given pixels
    INVARIANT: Called in the internal loop from gloss.play
-}
renderer :: DisplaySettings -> (CPU -> [Int]) -> CPU -> Picture
renderer s f state = scale (x/64) (y/32) $ createFrame s $ f state
    where
        (a,b) = (size s)
        (x,y) = (realToFrac a, realToFrac b)

{-  handleKeys func event cpu
    Applies func to cpu whenever a key pressed event is called
    PRE: cpu is in a functional state
    INVARIANT: Called in the internal loop from gloss.play
-}
handleKeys :: (Char -> Bool -> CPU -> CPU) -> Event -> CPU -> CPU
handleKeys f (EventKey (Char key) Down _ _) game = f key True game
handleKeys f (EventKey (Char key) Up   _ _) game = f key False game
handleKeys _ _ game                              = game

{-  startRenderer settings cpu rFunc hFunc uFunc
    Starts a game
    PRE: cpu is in a functional state,
         The number of pixels is equal to the number of pixels required for the given screen size from settings
    SIDE EFFECTS: Creates a window where the screen is drawn
                  Updates the screen every frame
                  Calls rFunc every frame
                  Calls uFunc every frame
                  Calls hFunc everytime a key is pressed
-}
startRenderer :: DisplaySettings -> CPU -> (CPU -> [Int]) -> (Char -> Bool -> CPU -> CPU) -> (Float -> CPU -> CPU) -> IO()
startRenderer s gS rF hF uF = play FullScreen black (fps s) gS (renderer s rF) (handleKeys hF) uF 