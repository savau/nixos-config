{-# LANGUAGE RecordWildCards #-}

module Applications
  ( Application(..)
  , spawnApplication
  , myStartupApplications, myFUAs
  ) where

import Data.List (intercalate)
import qualified Data.Map as Map
import Data.Map (Map)
import qualified Data.Set as Set
import Data.Set (Set)
import Data.Tuple.Curry

import XMonad

import XMonad.Actions.SpawnOn (spawnOn)


data Application = Application
                   { appName        :: String
                   , appEnvironment :: Map String String
                   , appOptions     :: [String]
                   , appWorkspace   :: Maybe WorkspaceId
                   }
                   deriving (Eq, Ord, Show, Read)

-- | Spawns a given application with the given environment and options, if given on a specific workspace
spawnApplication :: Application -> X ()
spawnApplication Application{..} = maybe spawn spawnOn appWorkspace $ intercalate " " $ (fmap (\(k,v) -> k<>"="<>v<>" ") $ Map.toList appEnvironment) <> (appName : appOptions)


-- | Applications that will be automatically launched after starting XMonad
myStartupApplications :: Set Application
myStartupApplications = (Set.fromList . fmap (uncurryN Application))
  [
--  ( "xfce4-power-manager"
--  , mempty, mempty, mempty
--  )
--, ( "volumeicon"
--  , mempty, mempty, mempty
--  )
    ( "nm-applet"
    , mempty, mempty, mempty
    )
  , ( "blueman-applet"
    , mempty, mempty, mempty
    )
--, ( "pamac-tray"  -- TODO: launch this iff on Arch Linux
--  , mempty, mempty, mempty
--  )
--, ( "keepassxc"
--  , mempty, mempty, mempty
--  )
--, ( "megasync"
--  , Map.fromList [ ("QT_SCALE_FACTOR","1") ], mempty, mempty  -- setting QT_SCALE_FACTOR=1 as a workaround to avoid immediate segfault, see https://github.com/meganz/MEGAsync/issues/443
--  )
--, ( "birdtray"
--  , Map.fromList [ ("LC_TIME","root.UTF-8") ], mempty, mempty
--  )
--, ( "zulip"
--  , mempty, mempty, mempty
--  )
--, ( "signal-desktop-beta"
--  , mempty, mempty, Just "8"
--  )
  ]

-- | Frequently used applications that can be launched via Mod+Shift+<key>
myFUAs :: Map KeySym Application
myFUAs = Map.fromList
  [ ( xK_f  -- [F]ile manager
    , Application "thunar"
      mempty mempty mempty
    )
  , ( xK_k  -- [K]eepassxc password manager
    , Application "keepassxc"
      mempty mempty mempty
    )

-- web applications
  , ( xK_w  -- [W]eb browser
    , Application "firefox"
      mempty mempty mempty
    )
  , ( xK_c  -- [C]hromium
    , Application "chromium"
      mempty mempty mempty
    )
  , ( xK_m  -- -[M]ail client
    , Application "thunderbird"
      (Map.singleton "LC_TIME" "root.UTF-8") mempty mempty
    )

-- development and system administration applications
--, ( xK_g  -- [G]rafana
--  , Application "firefox"
--    mempty ["-P grafana", "-kiosk"] mempty
--  )

-- chat applications
--, ( xK_e  -- [E]lement (matrix)
--  , Application "firefox"
--    mempty ["-P matrix", "-kiosk"] mempty
--  )
--, ( xK_z  -- [Z]ulip chat client
--  , Application "zulip"
--    mempty mempty mempty
--  )
--, ( xK_s  -- [S]ignal messenger client
--  , Application "signal-desktop"
--    mempty ["--use-tray-icon"] mempty
--  )
--, ( xK_p  -- [P]idgin XMPP client
--  , Application "pidgin"
--    mempty mempty mempty
--  )

-- IDEs
  , ( xK_t  -- [T]eX IDE
    , Application "texstudio"
      mempty mempty mempty
    )
--, ( xK_i  -- IntelliJ [I]DEA
--  , Application "idea"
--    mempty mempty mempty
--  )
--, ( xK_o  -- GNU [O]ctave
--  , Application "octave"
--    mempty ["--gui"] mempty
--  )
  ]
