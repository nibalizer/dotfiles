--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
-- the top of your config
{-# LANGUAGE NoMonomorphismRestriction #-}

import XMonad
import Data.Monoid
import XMonad.Hooks.ManageDocks

import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO


import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Layout.Fullscreen
import XMonad.Layout.Circle
-- import XMonad.Layout.NoBorders
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed

-- imports from xmonad.contrib
-- http://xmonad.org/xmonad-docs/xmonad-contrib/
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.GridSelect
import XMonad.Actions.NoBorders


-- Where I Begin to blow it up
-- gridselect things
--
gsconfig1 = defaultGSConfig { gs_cellheight = 30, gs_cellwidth = 100 }
gsconfig2 colorizer = (buildDefaultGSConfig colorizer) { gs_cellheight = 60, gs_cellwidth = 200 }

-- | A green monochrome colorizer based on window class
greenColorizer = colorRangeFromClassName
                      black            -- lowest inactive bg
                      (0x70,0xFF,0x70) -- highest inactive bg
                      black            -- active bg
                      white            -- inactive fg
                      white            -- active fg
   where black = minBound
         white = maxBound


--myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what's being written to the bar.
--myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Keybinding to toggle the gap for the bar.
--toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
--myConfig = defaultConfig { modMask = mod4Mask }

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "rxvt-unicode"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask


-- Color of current window title in xmobar.
xmobarTitleColor = "#FFB6B0"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#CEFFAC"

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
--myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
-- make a double row of workspaces a la irssi
myWorkspaces    = ["0","1","2","3","4","5","6","7","8","9","`"
                      ,"q","w","f","p","g","j","l","u","y",";"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#33cccc"
myFocusedBorderColor = "#0000ff"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_v     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_d     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_k     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_n     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_e     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_n     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_e     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- run setup env script
    , ((modm .|. shiftMask, xK_x     ), spawn "/home/nibz/local/bin/setup-env.sh"    )

    -- get battery info
    , ((modm,               xK_x     ), spawn "/home/nibz/local/bin/batt.sh" )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Toggle the border of the currently focused window

    , ((modm .|. shiftMask, xK_h     ), withFocused toggleBorder ) 

    -- Toggle the xmobar of the currently focused window

    , ((modm .|. shiftMask, xK_k     ), sendMessage ToggleStruts ) 

    -- Expand the master area
    , ((modm,               xK_i     ), sendMessage Expand)

    -- Toggle the xmobar of the currently focused window
    
    , ((modm .|. shiftMask, xK_i     ), spawn "gnome-screensaver-command -l" ) 

    -- Push window back into tiling
    , ((modm,               xK_d     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    -- Go to an empty workspace
    , ((modm,                xK_m    ), viewEmptyWorkspace)
    -- Take a window to an enmpty workspace
    , ((modm .|. shiftMask,  xK_m    ), tagToEmptyWorkspace)
    -- Open grid select workspaces
    --, ((modm,                xK_z), goToSelected defaultGSConfig)
    , ((modm,               xK_z), goToSelected  $ gsconfig2 greenColorizer)
    -- Open grid select applications
    , ((modm .|. shiftMask,  xK_z), spawnSelected defaultGSConfig ["firefox-trunk","firefox","rxvt-unicode","gnome-terminal","okular","gimp","inkscape","vlc","netflix-desktop", "chromium-browser"])



    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_a     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_a     ), spawn "xmonad --recompile; xmonad --restart")
    --printscreen
    , ((0                 , xK_Print ), spawn "scrot '%Y-%m-%d-%T_$wx$h_scrot.png' -e 'mv $f ~/Images/caps/'") 
    , ((modm              , xK_o ), spawn "scrot '%Y-%m-%d-%T_$wx$h_scrot.png' -e 'mv $f ~/Images/caps/'") 
    , ((shiftMask                 , xK_Print ), spawn "setxkbmap us")

    ]
    ++

    --
    -- mod-[0..9], Switch to workspace N
    -- mod-shift-[0..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_0 .. xK_9] 
	++ [ xK_grave, xK_q, xK_w, xK_f, xK_p, xK_g, xK_j, xK_l, xK_u, xK_y, xK_semicolon] )
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_r, xK_s, xK_t] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full ||| Circle
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
    

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = 
    composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Yakuake"        --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore]


------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty <+> docksEventHook


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"
  xmonad $ defaults {
      logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
          , ppSep = " "}
      , manageHook = manageDocks <+> myManageHook
  }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
--        numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook

    }
