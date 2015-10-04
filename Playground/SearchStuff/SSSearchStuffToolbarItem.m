//
//  SSSearchStuffToolbarItem.m
//  Playground
//
//  Created by Tong G. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "SSSearchStuffToolbarItem.h"
#import "SSSearchStuffBar.h"

// Private Interfaces
@interface SSSearchStuffToolbarItem()
- ( void ) __init;
@end // Private Interfaces

// SSSearchStuffToolbarItem class
@implementation SSSearchStuffToolbarItem

#pragma mark - Initializations
- ( instancetype ) initWithItemIdentifier: ( NSString* )_ItemIdentifier
    {
    if ( self = [ super initWithItemIdentifier: _ItemIdentifier ] )
        [ self __init ];

    return self;
    }

#pragma mark - Private Interfaces
- ( void ) __init
    {
    self->__searchBar = [ [ SSSearchStuffBar alloc ] initWithFrame: NSMakeRect( 0, 0, 0, 0 ) ];

    [ self setView: self->__searchBar ];

    CGFloat stdHeight = 25.f;
    [ self setMinSize: NSMakeSize( 200.f, stdHeight ) ];

    NSRect screenFrame = [ NSScreen mainScreen ].frame;
    CGFloat maxWidth = floor( NSWidth( screenFrame ) / 2 );
    [ self setMaxSize: NSMakeSize( maxWidth, stdHeight ) ];
    }

@end // SSSearchStuffToolbarItem class
