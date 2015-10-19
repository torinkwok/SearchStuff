//
//  __SSSearchStuffInputField.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffInputField.h"
#import "__SSSearchStuffInputFieldCell.h"
#import "__SSPreSearchButton.h"

// Private Interfaces
@interface __SSSearchStuffInputField ()
@property ( strong ) __SSPreSearchButton* __searchButton;
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
        [ self setPlaceholderString: NSLocalizedString( @"Search the fucking stuff", nil ) ];

        self.__searchButton = [ [ __SSPreSearchButton alloc ] initWithFrame: NSZeroRect ];
        [ self.__searchButton setFrameOrigin: NSMakePoint( 6.5f, 5.f ) ];

        [ self addSubview: self.__searchButton ];
        }

    return self;
    }

#pragma mark - Drawing

+ ( Class ) cellClass
    {
    return [ __SSSearchStuffInputFieldCell class ];
    }

@end // __SSSearchStuffInputField class
