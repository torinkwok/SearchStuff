//
//  __SSSearchStuffBackingCell.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffBackingCell.h"

// __SSSearchStuffBackingCell class
@implementation __SSSearchStuffBackingCell

- ( instancetype ) init
    {
    if ( self = [ super init ] )
        {
        [ self setBezelStyle: NSTexturedRoundedBezelStyle ];
        [ self  setTitle: @"" ];

        [ self setFocusRingType: NSFocusRingTypeExterior ];
        }

    return self;
    }

- ( void ) drawWithFrame: ( NSRect )_CellFrame
                  inView: ( NSView* )_ControlView
    {
    [ super drawWithFrame: _CellFrame inView: _ControlView ];

    [ self drawFocusRingMaskWithFrame: _CellFrame inView: _ControlView ];
    }

- ( void ) drawFocusRingMaskWithFrame: ( NSRect )_CellFrame
                               inView: ( NSView* )_CtrlView
    {
    [ NSGraphicsContext saveGraphicsState ];
    NSSetFocusRingStyle( NSFocusRingOnly );
    [ [ NSBezierPath bezierPathWithRect: NSInsetRect( _CellFrame, 4, 4 ) ] fill ];
    [ NSGraphicsContext restoreGraphicsState ];
    }

- ( NSRect ) focusRingMaskBoundsForFrame: ( NSRect )_CellFrame
                                  inView: ( NSView* )_ControlView
    {
    return _ControlView.bounds;
    }

@end // __SSSearchStuffBackingCell class
