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


-- main function in with we will call the other data and also play the game in
-- main = do
--     putStrLn "Whats your name"
--     name <- getLine
--     putStrLn("hello " ++ name)