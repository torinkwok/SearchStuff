//
//  __SSSearchStuffInputField.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffInputField.h"
#import "__SSSearchStuffInputFieldCell.h"

// Private Interfaces
@interface __SSSearchStuffInputField ()

@property ( strong ) NSButton* __searchButton;

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

        self.__searchButton = [ [ NSButton alloc ] initWithFrame: NSMakeRect( 0, 0, 20.f, 20.f ) ];
        [ self.__searchButton setBordered: NO ];
        [ self.__searchButton setTitle: @"S" ];

        [ self addSubview: self.__searchButton ];
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
    
    // Drawing code here.
    }

@end // __SSSearchStuffInputField class
