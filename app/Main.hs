module Main where

import Control.Concurrent
import System.Random

data Customer = Customer{
    -- | This is the define of data type Customer, which include their name, account number, and account balance.
    name :: String,
    account :: Int,
    balance :: Int
}deriving (Show, Eq)

foreign import ccall "exit" exit :: IO ()

process :: MVar Int->MVar Int->MVar ()->Customer->IO()
-- ^ This is the statement for process, which to achieve multi-threaded operation
process n presub final c = do
    pre <- takeMVar presub
    number <- takeMVar n

    m <- randomIO :: IO Int
    let r= mod m 40 + 10
        s= (if r>(balance c) then (balance c) else r)

    threadDelay $ r*10

    putMVar presub s
    putMVar n (number-1)

    let tempbalance = balance c + pre - s
        tempname = name c
        tempaccount = account c
        temp = Customer {name=tempname,account=tempaccount,balance=tempbalance}
    
    if number>10 then do
        process n presub final temp
    else if number==0 then putMVar final ()
         else do
              print temp
              process n presub final temp

main :: IO ()
-- ^ This is the statement for main 
main = do
    putStrLn "************************************"
    putStrLn "Initial..."
    putStrLn "************************************"
    n <- newMVar 100
    presub <- newMVar 0
    final <- newEmptyMVar

    let c0 = Customer {name="a",account=1,balance=1000}
    let c1 = Customer {name="b",account=2,balance=1000}
    let c2 = Customer {name="c",account=3,balance=1000}
    let c3 = Customer {name="d",account=4,balance=1000}
    let c4 = Customer {name="e",account=5,balance=1000}
    let c5 = Customer {name="f",account=6,balance=1000}
    let c6 = Customer {name="g",account=7,balance=1000}
    let c7 = Customer {name="h",account=8,balance=1000}
    let c8 = Customer {name="i",account=9,balance=1000}
    let c9 = Customer {name="j",account=10,balance=1000}
    
    forkIO (process n presub final c0)
    forkIO (process n presub final c1)
    forkIO (process n presub final c2)
    forkIO (process n presub final c3)
    forkIO (process n presub final c4)
    forkIO (process n presub final c5)
    forkIO (process n presub final c6)
    forkIO (process n presub final c7)
    forkIO (process n presub final c8)
    forkIO (process n presub final c9)

    w<-takeMVar final
    putStrLn "************************************"
    print "Finish..."
    putStrLn "************************************"
    