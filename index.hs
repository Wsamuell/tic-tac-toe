import Data.List (transpose, intercalate, intersperse)
import System.IO ()

-- Steps to creating the game

-- create the pieces
data Piece = X | O 
    deriving (Show, Eq)

data Spot = Used Piece | Unused
instance Show Spot where
    show (Used X) = "X"
    show (Used O) = "O"
    show Unused = " "

instance Eq Spot where
    Used X == Used X = True 
    Used O == Used O = True
    Unused == Unused = True
    _ == _ = False


-- create the Board 

-- i believe the best implementation of this from my end would be to use the take 3 method in haskell and use it to make an array pf an array fo that way we can have 9 number  in 3 different arrays like 
-- [1,2..9]
-- and then take 3 (something like this)

data GamePlay = Game {
    gameBoard :: [Spot],
    playerTurn :: Piece
} deriving Show

data Player = Player {
    name :: String,
    character :: String,
    wins :: Int
    -- deriving is used to generate instance(show, eq)
} deriving Show

-- in between each line, add a separating |
boardBlock ::  [Spot] -> String
boardBlock block = intercalate "  | " $ map show block

divider :: String 
divider = "---+----+---"

-- render each block row and then add the divider we created in between the rows
renderBoard :: [Spot] -> IO()
renderBoard spots = do
    putStrLn $ boardBlock block1
    putStrLn divider
    putStrLn $ boardBlock block2
    putStrLn divider
    putStrLn $ boardBlock block3
    where block1 = take 3 spots
          block2 = drop 3 . take 6 $ spots  
          block3 = drop 6 spots

-- image of board 
--     renderBoard [Used O, Unused, Unused, Unused, Used X, Unused, Unused, Unused, Unused]

{-
 O |   |  
---+---+---
   | X |   
---+---+---
   |   |  
-}


-- add player piece to the board


-- player switch implementation
-- player turns, switch player on input submit.
-- make combo of winning situations
-- before submitting the input we should check if last player turn wins, if not  check if there are open spots to play
-- if there is a winning combo, assign winner
-- Display winner and total wins for the duration of possible
-- ask if users would like to restart the game

-- main function in with we will call the other data and also play the game in
-- main = do
--     putStrLn "Whats your name"
--     name <- getLine
--     putStrLn("hello " ++ name)

-- IO action is a piece or pieces of code that waits to be executed like a function basically in JS
-- main :: IO () 


-- type declaration to start the game
