import Data.List (intercalate)
-- import System.IO ()
import Data.Maybe ()
-- Steps to creating the game

-- Welcome message to users
welcomeInfo :: IO ()
welcomeInfo = do
    putStrLn $ replicate 8 '\n'
    putStrLn "Welcome to my TIC-TAC-TOE game"
    putStrLn "This is a two person local multiplayer game"
    putStrLn "To enter your move please type in a number between 1-9"
    putStrLn $ replicate 1 '\n'
    putStrLn " T1 | T2 | T3"
    putStrLn "----+----+---"
    putStrLn " M1 | M2 | M3"
    putStrLn "----+----+---"
    putStrLn " B1 | B2 | B3"
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

-- User data implementation can be added as needed

data PlayerMove = Valid [Spot] | Invalid String [Spot]
-- data Player = Player {
--     name :: String,
--     character :: String,
--     wins :: Int
    -- deriving is used to generate instance(show, eq)
-- } deriving Show

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

-- this is just an image you want the Users to get an idea of what n empty game board with free spaces look like 
emptyBoard :: IO ()
emptyBoard = do
    putStrLn $ replicate 1 '\n'
    renderBoard [Unused, Unused, Unused, Unused, Unused, Unused, Unused, Unused, Unused]
    putStrLn $ replicate 1 '\n'

-- add player piece to the board

-- so this one is a bit more tricky, the way i was thinking i would be able to do this is use the !! (findIndex) method to find unused spots on the board and then have user input the number. 
-- if i am able to use the index, i can try to replace value in index with Used X or Used O based on input
-- PROBLEM - I wont be able to verify if the spot is used or unused so the game logic would be compromised


-- check if the current spot a player takes is valid or invalid

spotIsValid :: [Spot] -> Int -> Maybe Int
spotIsValid  spots ix  = if spots !! ix == Unused then Just ix else Nothing

-- options for checking position on created board
-- T - top
-- M - middle
-- B- bottom
spotIndex :: String -> Maybe Int 
spotIndex "T1" = Just 0
spotIndex "T2" = Just 1
spotIndex "T3" = Just 2
spotIndex "M1" = Just 3
spotIndex "M2" = Just 4
spotIndex "M3" = Just 5
spotIndex "B1" = Just 6
spotIndex "B2" = Just 7
spotIndex "B3" = Just 8
spotIndex _ = Nothing 


-- if its valid then assign the spot to the current player
assignValidSpot :: String -> Piece -> [Spot] -> PlayerMove
assignValidSpot userInput piece spot = 
    case spotIndex userInput >>= spotIsValid spot of
        Nothing -> Invalid "Player Move Invalid... Try Again" spot
        Just i -> Valid (take i spot ++ [Used piece] ++ drop (i + 1) spot)


-- player switch implementation
switchPlayer :: Piece -> Piece
switchPlayer O = X
switchPlayer X = O

-- Now we need to ask for user input and then assign Spot as requested
newGame :: Piece -> [Spot] -> IO()
newGame  piece spot = do 
    putStrLn ("Player " ++ show piece ++ "'s turn")
    renderBoard spot
    putStr( "\nPlayer " ++ show piece ++ "'s turn: ")
    myMove <- getLine
    case assignValidSpot myMove piece spot of
        Invalid err spot -> do
            putStrLn err
            newGame piece spot
-- before submitting the input we should check if last player turn wins, if not  check if there are open spots to play
        Valid updateBoard -> do
            if checkWinner piece updateBoard then do
-- if there is a winning combo, assign winner
                putStrLn ("Player" ++ show piece ++ "Wins the Game!" )
                renderBoard spot
                restart
            else newGame (switchPlayer piece) spot


-- make combo of winning situations

checkWinner :: Piece -> [Spot] -> Bool 
checkWinner piece spot =  
    -- or checks if any of the conditions in the array is true for the boolean defined
    or [
        -- winning situation for top row
        head spot == Used piece && spot !! 1 == Used piece && spot !! 2 == Used piece,
        -- winning situation for middle row
        spot !! 3 == Used piece && spot !! 4 == Used piece && spot !! 5 == Used piece,
        -- winning situation for bottom row
        spot !! 6 == Used piece && spot !! 7 == Used piece && spot !! 8 == Used piece,
        -- winning situation for left column
        head spot == Used piece && spot !! 3 == Used piece && spot !! 6 == Used piece,
        -- winning situation for middle column
        spot !! 1 == Used piece && spot !! 4 == Used piece && spot !! 7 == Used piece,
        -- winning situation for right column
        spot !! 2 == Used piece && spot !! 3 == Used piece && spot !! 8 == Used piece,
        -- winning situation for \
        head spot == Used piece && spot !! 4 == Used piece && spot !! 8 == Used piece,
        -- winning situation for /
        spot !! 2 == Used piece && spot !! 4 == Used piece && spot !! 6 == Used piece
    ]

-- ask if users would like to restart the game
restart :: IO ()
restart = do
    putStrLn "Would you like to play again? (y/n)"
    newGame <- getLine 
    if newGame ==  "y" then do 
        main
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
main :: IO()
main = do 
    welcomeInfo
    let newBoard = replicate 9 Unused 
    newGame X newBoard
