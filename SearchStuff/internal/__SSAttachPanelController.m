/*=============================================================================┐
|  _______           _     _              ______               ___    ___      |  
| (_______)         | |   (_)            / _____) _           / __)  / __)     |██
|  _____ _   _  ____| |  _ _ ____   ____( (____ _| |_ _   _ _| |__ _| |__ ___  |██
| |  ___) | | |/ ___) |_/ ) |  _ \ / _  |\____ (_   _) | | (_   __|_   __)___) |██
| | |   | |_| ( (___|  _ (| | | | ( (_| |_____) )| |_| |_| | | |    | | |___ | |██
| |_|   |____/ \____)_| \_)_|_| |_|\___ (______/  \__)____/  |_|    |_| (___/  |██
|                                 (_____|                                      |██
|                                                                              |██
|      _ ______                        _      ______               ___    ___  |██
|     | / _____)                      | |    / _____) _           / __)  / __) |██
|    / ( (____  _____ _____  ____ ____| |__ ( (____ _| |_ _   _ _| |__ _| |__  |██
|   / / \____ \| ___ (____ |/ ___) ___)  _ \ \____ (_   _) | | (_   __|_   __) |██
|  / /  _____) ) ____/ ___ | |  ( (___| | | |_____) )| |_| |_| | | |    | |    |██
| |_|  (______/|_____)_____|_|   \____)_| |_(______/  \__)____/  |_|    |_|    |██
|                                                                              |██
|                                                                              |██
|                         Copyright (c) 2015 Tong Kuo                          |██
|                                                                              |██
|                             ALL RIGHTS RESERVED.                             |██
|                                                                              |██
└==============================================================================┘██
  ████████████████████████████████████████████████████████████████████████████████
  ██████████████████████████████████████████████████████████████████████████████*/

#import "__SSAttachPanelController.h"
#import "__SSAttachPanel.h"

// Private Interfaces
@interface __SSAttachPanelController ()
@end // Private Interfaces

// __SSAttachPanelController class
@implementation __SSAttachPanelController

@dynamic searchResultsAttachPanel;

@dynamic relativeView;

#pragma mark - Initializations

- ( instancetype ) initWithRelativeView: ( NSView* )_RelativeView
    {
    if ( self = [ super initWithWindowNibName: @"__SSAttachPanel" owner: self ] )
        self.relativeView = _RelativeView;

    return self;
    }

- ( void ) windowDidLoad
    {
    [ [ NSNotificationCenter defaultCenter ] addObserver: self
                                                selector: @selector( _applicationDidResignActive: )
                                                    name: NSApplicationDidResignActiveNotification
                                                  object: nil ];

    [ [ NSNotificationCenter defaultCenter ] addObserver: self
                                                selector: @selector( _applicationDidBecomeActive: )
                                                    name: NSApplicationDidBecomeActiveNotification
                                                  object: nil ];
    }

- ( void ) dealloc
    {
    [ [ NSNotificationCenter defaultCenter ] removeObserver: self name: NSApplicationDidResignActiveNotification object: nil ];
    [ [ NSNotificationCenter defaultCenter ] removeObserver: self name: NSApplicationDidBecomeActiveNotification object: nil ];
    }

#pragma mark - Controlling The Attach Panel

- ( void ) popUpAttachPanel
    {
    if ( self.relativeView )
        {
        __SSAttachPanel* attachPanel = self.searchResultsAttachPanel;

        // Resizing attach panel
        NSSize relativeViewSize = self.relativeView.visibleRect.size;
        NSSize attachPanelConstraintSize = attachPanel.constraintSize;

        NSRect attachPanelNewframe = attachPanel.frame;

        attachPanelNewframe.size.width =
            ( relativeViewSize.width > attachPanelConstraintSize.width ) ? relativeViewSize.width
                                                                         : attachPanelConstraintSize.width;

        [ attachPanel setFrame: attachPanelNewframe display: YES animate: YES ];

        // Repositioning attach panel
        NSRect windowFrameOfRelativeView = [ self.relativeView convertRect: self.relativeView.visibleRect toView: nil ];
        NSRect screenFrameOfRelativeView = [ self.relativeView.window convertRectToScreen: windowFrameOfRelativeView ];

        NSPoint attachPanelOrigin = screenFrameOfRelativeView.origin;

        if ( NSWidth( self.relativeView.frame ) < NSWidth( attachPanelNewframe ) )
            attachPanelOrigin.x -= ( attachPanelConstraintSize.width - NSWidth( self.relativeView.visibleRect ) ) / 2;

        attachPanelOrigin.y -= NSHeight( attachPanel.frame ) + 1.2f;

        // Pop up
        [ self popUpAttachPanelOnWindow: self.relativeView.window at: attachPanelOrigin ];
        }

    // TODO: Error Handling
    }

- ( void ) popUpAttachPanelOnWindow: ( NSWindow* )_ParentWindow
                                 at: ( NSPoint )_PointInScreen
    {
    if ( _ParentWindow )
        {
        NSParameterAssert( _ParentWindow != self.searchResultsAttachPanel );
        [ self.searchResultsAttachPanel setFrameOrigin: _PointInScreen ];
        [ _ParentWindow addChildWindow: self.searchResultsAttachPanel ordered: NSWindowAbove ];
        [ self.searchResultsAttachPanel makeKeyAndOrderFront: nil ];
        }
    }

- ( void ) closeAttachPanel
    {
    [ self.searchResultsAttachPanel.parentWindow removeChildWindow: self.searchResultsAttachPanel ];
    [ self.searchResultsAttachPanel orderOut: self ];
    }

- ( void ) closeAttachPanelAndClearResults
    {
    [ self closeAttachPanel ];
    }

#pragma mark - Dynamic Properties

- ( __SSAttachPanel* ) searchResultsAttachPanel
    {
    return ( __SSAttachPanel* )( self.window );
    }

- ( void ) setRelativeView: ( NSView* __nullable )_RelativeView
    {
    NSWindow* relativeWindow = self->_relativeView.window;
    if ( self->_relativeView )
        {
        [ [ NSNotificationCenter defaultCenter ] removeObserver: self
                                                           name: NSWindowWillStartLiveResizeNotification
                                                         object: relativeWindow ];

        [ [ NSNotificationCenter defaultCenter ] removeObserver: self
                                                           name: NSWindowDidEndLiveResizeNotification
                                                         object: relativeWindow ];
        }

    self->_relativeView = _RelativeView;
    [ [ NSNotificationCenter defaultCenter ] addObserver: self
                                                selector: @selector( _relativeWindowStartLiveResize: )
                                                    name: NSWindowWillStartLiveResizeNotification
                                                  object: relativeWindow ];

    [ [ NSNotificationCenter defaultCenter ] addObserver: self
                                                selector: @selector( _relativeWindowDidEndResize: )
                                                    name: NSWindowDidEndLiveResizeNotification
                                                  object: relativeWindow ];
    }

- ( NSView* ) relativeView
    {
    return self->_relativeView;
    }

#pragma mark - Private Interfaces

- ( void ) _didEmptySearchContent: ( NSNotification* )_Notif
    {
    [ self closeAttachPanelAndClearResults ];
    }

- ( void ) _applicationDidResignActive: ( NSNotification* )_Notif
    {
    [ self closeAttachPanel ];
    }

- ( void ) _applicationDidBecomeActive: ( NSNotification* )_Notif
    {
    if ( self.isInUse )
        [ self popUpAttachPanel ];
    }

- ( void ) _relativeWindowStartLiveResize: ( NSNotification* )_Notif
    {
    [ self closeAttachPanel ];
    }

- ( void ) _relativeWindowDidEndResize: ( NSNotification* )_Notif
    {
    if ( self.isInUse )
        [ self popUpAttachPanel ];
    }

@end // __SSAttachPanelController class

/*===============================================================================┐
|                                                                                |
|                           The MIT License (MIT)                                |
|                                                                                |
|                        Copyright (c) 2015 Tong Kuo                             |
|                                                                                |
| Permission is hereby granted, free of charge, to any person obtaining a copy   |
| of this software and associated documentation files (the "Software"), to deal  |
| in the Software without restriction, including without limitation the rights   |
| to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      |
|   copies of the Software, and to permit persons to whom the Software is        |
|         furnished to do so, subject to the following conditions:               |
|                                                                                |
| The above copyright notice and this permission notice shall be included in all |
|              copies or substantial portions of the Software.                   |
|                                                                                |
| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     |
| IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       |
| FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    |
|  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        |
| LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  |
| OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  |
|                                 SOFTWARE.                                      |
|                                                                                |
└===============================================================================*/