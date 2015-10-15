//
//  __SSSearchStuffInputFieldCell.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffInputFieldCell.h"

// Private Interfaces
@interface __SSSearchStuffInputFieldCell ()
- ( NSRect ) __insetRectForBounds: ( NSRect )_Bounds;
@end // Private Interfaces

// __SSSearchStuffInputFieldCell class
@implementation __SSSearchStuffInputFieldCell

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

@end // __SSSearchStuffInputFieldCell class
