module Utils.KeyMask
  ( altMask, noMask
  ) where

import XMonad


-- | Convenience definition for Mod1 (== Alt) key mask
altMask :: KeyMask
altMask = mod1Mask

-- | Convenience definition for the "no" key mask (i.e. no key pressed)
noMask :: KeyMask
noMask = 0
