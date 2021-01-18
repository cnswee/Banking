{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_concurrency (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/homes/sq001/Desktop/Banking/.stack-work/install/x86_64-linux/c3bab5bedcf12691c37c578cee04d1c397b61e204a4f63a52f517b835a246ef4/8.8.4/bin"
libdir     = "/homes/sq001/Desktop/Banking/.stack-work/install/x86_64-linux/c3bab5bedcf12691c37c578cee04d1c397b61e204a4f63a52f517b835a246ef4/8.8.4/lib/x86_64-linux-ghc-8.8.4/concurrency-0.1.0.0-9d4Jlxw4JdU3XVGKIlrPgm"
dynlibdir  = "/homes/sq001/Desktop/Banking/.stack-work/install/x86_64-linux/c3bab5bedcf12691c37c578cee04d1c397b61e204a4f63a52f517b835a246ef4/8.8.4/lib/x86_64-linux-ghc-8.8.4"
datadir    = "/homes/sq001/Desktop/Banking/.stack-work/install/x86_64-linux/c3bab5bedcf12691c37c578cee04d1c397b61e204a4f63a52f517b835a246ef4/8.8.4/share/x86_64-linux-ghc-8.8.4/concurrency-0.1.0.0"
libexecdir = "/homes/sq001/Desktop/Banking/.stack-work/install/x86_64-linux/c3bab5bedcf12691c37c578cee04d1c397b61e204a4f63a52f517b835a246ef4/8.8.4/libexec/x86_64-linux-ghc-8.8.4/concurrency-0.1.0.0"
sysconfdir = "/homes/sq001/Desktop/Banking/.stack-work/install/x86_64-linux/c3bab5bedcf12691c37c578cee04d1c397b61e204a4f63a52f517b835a246ef4/8.8.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "concurrency_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "concurrency_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "concurrency_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "concurrency_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "concurrency_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "concurrency_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
