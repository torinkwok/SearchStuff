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

#import "__SSInputFieldCell.h"
#import "__SSConstants.h"
#import "__SSBar.h"
#import "__SSAttachPanelController.h"

// Private Interfaces
@interface __SSInputFieldCell ()

- ( NSRect ) __insetRectForBounds: ( NSRect )_Bounds;

// Notification Methods
- ( void ) __shouldDismissAttachPanel: ( NSNotification* )_Notif;

@end // Private Interfaces

// __SSInputFieldCell class
@implementation __SSInputFieldCell

- ( instancetype ) init
    {
    if ( self = [ super init ] )
        {
        [ [ NSNotificationCenter defaultCenter ] addObserver: self
                                                    selector: @selector( __shouldDismissAttachPanel: )
                                                        name: SearchStuffShouldDismissAttachPanel
                                                      object: nil ];
        }

    return self;
    }

- ( void ) dealloc
    {
    [ [ NSNotificationCenter defaultCenter ] removeObserver: self name: SearchStuffShouldDismissAttachPanel object: nil ];
    }

#pragma mark - Drawing

- ( void ) drawWithFrame: ( NSRect )_CellFrame
                  inView: ( NSView* )_ControlView
    {
    [ super drawWithFrame: _CellFrame inView: _ControlView ];
    }

- ( void ) selectWithFrame: ( NSRect )_CellFrame
                    inView: ( NSView* )_ControlView
                    editor: ( NSText* )_FieldEditor
                  delegate: ( id )_DelegateObject
                     start: ( NSInteger )_SelStart
                    length: ( NSInteger )_SelLength
    {
    [ super selectWithFrame: [ self __insetRectForBounds: _ControlView.bounds ]
                     inView: _ControlView
                     editor: _FieldEditor
                   delegate: _DelegateObject
                      start: _SelStart
                     length: _SelLength ];

    __SSBar* hostBar = ( __SSBar* )( _ControlView.superview );
    [ hostBar.attachPanelController popUpAttachPanel ];
    }

- ( void ) editWithFrame: ( NSRect )_CellFrame
                  inView: ( NSView* )_ControlView
                  editor: ( NSText* )_FieldEditor
                delegate: ( id )_DelegateObject
                   event: ( NSEvent* )_Event
    {
    [ super editWithFrame: [ self __insetRectForBounds: _ControlView.bounds ]
                   inView: _ControlView
                   editor: _FieldEditor
                 delegate: _DelegateObject
                    event: _Event ];
    }

#pragma mark - Private Interfaces

- ( NSRect ) __insetRectForBounds: ( NSRect )_Bounds
    {
    NSRect offsetBounds = _Bounds;
    offsetBounds.origin.x += 23.f;
    offsetBounds.size.width -= 30.f;
    offsetBounds.origin.y += 4.f;

    return offsetBounds;
    }

- ( void ) __shouldDismissAttachPanel: ( NSNotification* )_Notif
    {
    __SSBar* hostBar = _Notif.object;
    [ hostBar.attachPanelController dismissAttachPanel ];
    }

@end // __SSInputFieldCell class

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