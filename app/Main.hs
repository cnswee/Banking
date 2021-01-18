module Main where

import Control.Concurrent
import System.Random

data Customer = Customer{
    name :: String,
    account :: Int,
    balance :: Int
}deriving (Show, Eq)

-- mapIntToCus :: Int->Customer
-- mapIntToCus n = case r of
--     0 -> c1
--     1 -> c2
--     2 -> c3
--     3 -> c4
--     4 -> c5
--     5 -> c6
--     6 -> c7
--     7 -> c8
--     8 -> c9
--     9 -> c10
--    where r = mod n 10

-- randomCus ::  IO Customer
-- randomCus = do
--     m <- randomIO :: IO Int
--     let cus = mapIntToCus m 
--     return cus

-- reduce :: Customer->Int->Customer
-- reduce cus a = do
--     _balance <- balance cus
--     Customer {name= name cus,account = account cus,balance = _balance}


-- process :: Customer -> MVar ()->MVar (Int,Customer) -> MVar (Int)->Int-> MVar()->IO () 
-- process cus free box valuebox 0 final= putMVar final ()
-- process cus free box valuebox n final= do
--     f <- takeMVar free
    -- m <- randomIO :: IO Int
    -- let r= mod m 40 + 10
--     let tempbalance = balance cus - r
--     let tempname = name cus
--     let tempaccount = account cus
--     let temp = Customer {name=tempname,account=tempaccount,balance=tempbalance}
--     print temp
--     putStrLn "This is process"
--     putMVar box (n,temp)
--     putMVar valuebox r
--     threadDelay (r*100)
--     addprocess box valuebox final


-- addprocess :: MVar (Int,Customer) ->MVar (Int)->MVar () ->IO()
-- addprocess box valuebox final = do
--     (n,temp) <- takeMVar box
--     r<-takeMVar valuebox
--     let tempbalance = balance temp + r
--     let tempname = name temp
--     let tempaccount = account temp
--     let temp1 = Customer {name=tempname,account=tempaccount,balance=tempbalance}
--     print temp1
--     putStrLn "This is addprocess"
--     process temp1  box valuebox (n-1) final

foreign import ccall "exit" exit :: IO ()

process :: MVar Int->MVar Int->MVar ()->Customer->IO()
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
        -- print temp
        process n presub final temp
    else if number==0 then putMVar final ()
         else do
              print temp
              process n presub final temp

main :: IO ()
main = do
    putStrLn "************************************"
    putStrLn "Initial..."
    putStrLn "************************************"
    -- free <- newMVar ()
    -- box <- newEmptyMVar
    -- final <- newEmptyMVar
    -- valuebox <- newEmptyMVar
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

    -- forkIO (process c0  free box valuebox 100 final)
    -- forkIO (process c1  free box valuebox 100 final) 
    -- forkIO (process c2  free box valuebox 100 final)
    -- forkIO (process c3  free box valuebox 100 final)
    -- forkIO (process c4  free box valuebox 100 final) 
    -- forkIO (process c5  free box valuebox 100 final)
    -- forkIO (process c6  free box valuebox 100 final)
    -- forkIO (process c7  free box valuebox 100 final)
    -- forkIO (process c8  free box valuebox 100 final)
    -- forkIO (process c9  free box valuebox 100 final)
    
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
    