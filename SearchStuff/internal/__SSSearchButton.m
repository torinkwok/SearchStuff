//
//  __SSSearchButton.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchButton.h"
#import "__SSSearchButtonCell.h"

// Private Interfaces
@interface __SSSearchButton ()
- ( void ) __redrawingWithHighlighted: ( BOOL )_IsHighlighted;
@end // Private Interfaces

// __SSSearchButton class
@implementation __SSSearchButton

+ ( NSSize ) defaultSize
    {
    return NSMakeSize( 15.f, 15.f );
    }

#pragma mark - Initializations

- ( instancetype ) initWithFrame: ( NSRect )_FrameRect
    {
    if ( self = [ super initWithFrame: _FrameRect ] )
        {
        [ self setFrameSize: [ [ self class ] defaultSize ] ];
        [ self setImage: [ NSImage imageNamed: @"search-stuff-search" ] ];
        [ self setAlternateImage: [ NSImage imageNamed: @"search-stuff-search-highlighted" ] ];

        NSTrackingArea* trackingArea =
            [ [ NSTrackingArea alloc ] initWithRect: self.bounds
                                            options: NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingCursorUpdate
                                                        | NSTrackingActiveAlways
                                                        /* This NSTrackingArea object was created with NSTrackingInVisibleRect option
                                                         * in which case the AppKit handles the re-computation of tracking area */
                                                        | NSTrackingInVisibleRect
                                              owner: self
                                           userInfo: nil ];
        [ self addTrackingArea: trackingArea ];
        }

    return self;
    }

#pragma mark - Drawing

+ ( Class ) cellClass
    {
    return [ __SSSearchButtonCell class ];
    }

#pragma mark - Events

- ( void ) mouseEntered: ( NSEvent* )_Event
    {
    [ self __redrawingWithHighlighted: YES ];
    }

- ( void ) mouseExited: ( NSEvent* )_Event
    {
    [ self __redrawingWithHighlighted: NO ];
    }

- ( void ) mouseDown: ( NSEvent* )_Event
    {
    [ self __redrawingWithHighlighted: YES ];
    }

- ( void ) cursorUpdate: ( NSEvent* )_Event
    {
    [ [ NSCursor arrowCursor ] set ];
    }

#pragma mark - Private Interfaces

- ( void ) __redrawingWithHighlighted: ( BOOL )_IsHighlighted
    {
    [ self.cell setHighlighted: _IsHighlighted ];
    [ self setNeedsDisplay ];
    }

@end // __SSSearchButton class