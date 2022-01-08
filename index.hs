import Data.List (transpose, intercalate, intersperse)
import System.IO ()
import Data.Maybe
-- Steps to creating the game

-- Welcome message to users
welcomeInfo :: IO ()
welcomeInfo = do
    putStrLn $ replicate 8 '\n'
    putStrLn "Welcome to my TIC-TAC-TOE game"
    putStrLn "This is a two person local multiplayer game"
    putStrLn "To enter your move please type in a number between 1-9"
    putStrLn $ replicate 1 '\n'
    putStrLn " 1 | 2 | 3"
    putStrLn "---+---+---"
    putStrLn " 4 | 5 | 6 "
    putStrLn "---+---+---"
    putStrLn " 7 | 8 | 9"
    putStrLn $ replicate 1 '\n'
    putStrLn "Player 1 is X"
    putStrLn "Please input your move ..."
    putStrLn $ replicate 1 '\n'


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
    putStrLn $ boardBlock top
    putStrLn divider
    putStrLn $ boardBlock middle
    putStrLn divider
    putStrLn $ boardBlock bottom
    where top = take 3 spots
          middle = drop 3 . take 6 $ spots  
          bottom = drop 6 spots

-- image of board 
-- renderBoard [Used O, Unused, Unused, Unused, Used X, Unused, Unused, Unused, Unused]

{-
 O |   |  
---+---+---
   | X |   
---+---+---
   |   |  
-}

emptyBoard :: IO ()
emptyBoard = do
    putStrLn $ replicate 1 '\n'
    renderBoard [Unused, Unused, Unused, Unused, Unused, Unused, Unused, Unused, Unused]
    putStrLn $ replicate 1 '\n'

-- add player piece to the board

-- so this one is a bit more tricky, the way i was thinking i would be able to do this is use the !! (findIndex) method to find unused spots on the board and then have user input the number. 
-- if i am able to use the index, i can try to replace value in index with Used X or Used O based on input
-- PROBLEM - I wont be able to verify if the spot is used or unused so the game logic would be compromised

addMove :: Spot -> String 
addMove = show 

-- player switch implementation
-- make combo of winning situations
-- before submitting the input we should check if last player turn wins, if not  check if there are open spots to play
-- if there is a winning combo, assign winner

-- ask if users would like to restart the game
restart :: IO ()
restart = do
    putStrLn "Would you like to play again? (y/n)"
    newGame <- getLine 
    if newGame ==  "y" then do 
        welcomeInfo
    else if newGame == "n" then do
        putStrLn $ replicate 8 '\n'
        putStrLn "❤️ Thank You for Playing ❤️"
        putStrLn $ replicate 8 '\n'

        return ()
    else do 
        putStrLn "Input not Valid! Please try again (y/n)"
        restart


-- main function in with we will call the other data and also play the game in




-- IO action is a piece or pieces of code that waits to be executed like a function basically in JS
-- main :: IO () 


-- type declaration to start the game
