import Data.List ()
import System.IO ()


-- to run ghci compiler you can do ghci and that compiles all changes then do :l {filename} index.hs. this gets you back to main. :r for reload
-- :t gets the type declaration for what ever you typed in
-- to run entire file compiler with main = do, run ghc -- make {filename} index.hs

-- :q to quit compiler




-- Steps to creating the game


-- create the pieces
data Piece = X | O 
instance Show Piece where
    show X = "X"
    show O = "O"


-- create the Board
data Spot = Used Piece | Unused
instance Show Spot where
    show (Used X) = "X"
    show (Used O) = "O"
    show Unused = ""




data Player = Player {
    name :: String,
    character :: String,
    wins :: Int
    -- deriving is used to generate instance(show, eq)
} deriving(Show)



-- align piece and board together so we can tell which spot is used and unused
-- player switch implementation
-- player turns, switch player on input submit.
-- make combo of winning situations
-- before submitting the input we should check if last player turn wins, if not  check if there are open spots to play
-- if there is a winning combo, assign winner
-- Display winner and total wins for the duration of possible (probably not without local storage)
-- ask if users would like to restart the game

-- main function in with we will call the other data and also play the game in
-- main = do
--     putStrLn "Whats your name"
--     name <- getLine
--     putStrLn("hello " ++ name)

-- IO action is a piece or pieces of code that waits to be executed like a function basically in JS
-- main :: IO () 


-- type declaration to start the game
startGame :: [Spot] -> Player -> IO ()
startGame = undefined 