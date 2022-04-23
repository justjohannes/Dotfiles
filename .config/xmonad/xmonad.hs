----------------------------------------------------------------------------------
				--Import--
----------------------------------------------------------------------------------


import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing

import XMonad.Hooks.EwmhDesktops


----------------------------------------------------------------------------------
				--Variable--
----------------------------------------------------------------------------------


myTerminal :: String
myTerminal = "alacritty"

myBorderWidth :: Dimension
myBorderWidth = 3

myFocusColor :: String
myFocusColor = "#ffb454"


----------------------------------------------------------------------------------
				--Main--
----------------------------------------------------------------------------------

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask            = mod4Mask      -- Rebind Mod to the Super key
    , terminal           = myTerminal    -- Default terminal s
    , layoutHook         = gaps [(L,5), (R,5), (U,10), (D,15)] $ spacingRaw True (Border 0 5 5 5) True (Border 7 7 7 7) True $ myLayout
    , manageHook         = myManageHook  -- Match on certain windows
    , borderWidth        = myBorderWidth
    , focusedBorderColor = myFocusColor
    }
  `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-S-=", unGrab *> spawn "scrot -s")
    , ("M-S-b"  , spawn "firefox-bin")
    , ("M-S-t", spawn "alacritty")
    , ("M-e", spawn "emacs")
    , ("M-o" , spawn "~/.config/rofi/bin/launcher_colorful")
    ]


----------------------------------------------------------------------------------
				--Hooks--
----------------------------------------------------------------------------------


myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog            --> doFloat
    ]


----------------------------------------------------------------------------------
				--Layout--
----------------------------------------------------------------------------------


myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes


----------------------------------------------------------------------------------
				--Xmobar--
----------------------------------------------------------------------------------

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
