module Utils.Dir
  ( xMonad, statusBar, systemTray
  ) where

xMonad, statusBar, systemTray :: String
xMonad     = "~/.xmonad/"
statusBar  = xMonad <> "status-bar/"
systemTray = xMonad <> "system-tray/"
