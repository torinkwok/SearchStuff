//
//  __SSSearchStuffInputField.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffInputField.h"

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
        }

    return self;
    }

#pragma mark - Drawing

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];
    
    // Drawing code here.
    }

@end // __SSSearchStuffInputField class
