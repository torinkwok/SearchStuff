//
//  __SSSearchStuffInputField.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffInputField.h"
#import "__SSSearchStuffInputFieldCell.h"
#import "__SSSearchButton.h"

// Private Interfaces
@interface __SSSearchStuffInputField ()

@property ( strong ) __SSSearchButton* __searchButton;
@property ( strong ) NSTrackingArea* __inactiveTrackingArea;

@end // Private Interfaces

// __SSSearchStuffInputField class
@implementation __SSSearchStuffInputField

#pragma mark - Initializations

- ( instancetype ) initWithFrame: ( NSRect )_Frame
                        delegate: ( id <NSTextFieldDelegate> )_Delegate
    {
    if ( self = [ self /* Ja, that's indeed myself, not my parent */ initWithFrame: _Frame ] )
        [ self setDelegate: _Delegate ];

    return self;
    }

- ( instancetype ) initWithFrame: ( NSRect )_Frame
    {
    if ( self = [ super initWithFrame: _Frame ] )
        {
        [ self setDrawsBackground: NO ];
        [ self setBordered: NO ];
        [ self setPlaceholderString: NSLocalizedString( @"Search", nil ) ];

        self.__searchButton = [ [ __SSSearchButton alloc ] initWithFrame: NSZeroRect ];
        [ self.__searchButton setFrameOrigin: NSMakePoint( 6.f, 5.f ) ];

        [ self addSubview: self.__searchButton ];

        self.__inactiveTrackingArea = [ [ NSTrackingArea alloc ]
            initWithRect: NSMakeRect( 0, 0, 23.f, NSHeight( self.bounds ) ) options: NSTrackingMouseMoved | NSTrackingActiveAlways owner: self userInfo: nil ];

        [ self addTrackingArea: self.__inactiveTrackingArea ];
        }

    return self;
    }

#pragma mark - Drawing

+ ( Class ) cellClass
    {
    return [ __SSSearchStuffInputFieldCell class ];
    }

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];
    
    [ [ NSColor orangeColor ] set ];
    NSRectFill( NSMakeRect( 0, 0, 23.f, NSHeight( self.bounds ) ) );
    }

#pragma mark - Events

- ( void ) mouseDown: ( NSEvent* )_Event
    {
    [ super mouseDown: _Event ];
    }

- ( void ) mouseMoved: ( NSEvent* )_Event
    {
    NSLog( @"🌰" );

    NSPoint locationInWindow = [ _Event locationInWindow ];
    NSPoint eventLoc = [ self convertPoint: locationInWindow fromView: nil ];

    if ( NSPointInRect( eventLoc, self.__inactiveTrackingArea.rect ) )
        NSLog( @"🍓" );
    }

- ( void ) cursorUpdate: ( NSEvent * )_Event
    {
    [ [ NSCursor arrowCursor ] set ];
    }

@end // __SSSearchStuffInputField class
