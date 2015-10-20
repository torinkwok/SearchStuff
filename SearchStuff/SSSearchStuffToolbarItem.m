//
//  SSSearchStuffToolbarItem.m
//  Playground
//
//  Created by Tong G. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "SSSearchStuffToolbarItem.h"

#import "__SSSearchStuffBar.h"
#import "__SSSearchStuffToolbarItem.h"

// Standard Identifiers
NSString* const SearchStuffSearchWidgetIdentifier = @"__ssSearchWidgetIdentifier";
NSString* const SearchStuffReloadWidgetIdentifier = @"__ssReloadWidgetIdentifier";

// Private Interfaces
@interface SSSearchStuffToolbarItem()
- ( void ) __init;
@end // Private Interfaces

// SSSearchStuffToolbarItem class
@implementation SSSearchStuffToolbarItem
    {
@private
    __SSSearchStuffBar* __searchBar;

    NSArray <__kindof NSString*>* __standardIdentifiers;
    }

#pragma mark - Initializations

- ( instancetype ) initWithItemIdentifier: ( NSString* )_ItemIdentifier
    {
    if ( self = [ super initWithItemIdentifier: _ItemIdentifier ] )
        [ self __init ];

    return self;
    }

#pragma mark - Manipulating Widgets

- ( void ) reload
    {
    [ self->__searchBar reload ];
    }

#pragma mark - Private Interfaces

- ( void ) __init
    {
    self->__searchBar = [ [ __SSSearchStuffBar alloc ] initWithFrame: NSMakeRect( 0, 0, 0, 0 ) ];
    [ self->__searchBar setHostingSSToolbarItem: self ];

    [ self setView: self->__searchBar ];

    CGFloat stdHeight = 25.f;
    [ self setMinSize: NSMakeSize( 200.f, stdHeight ) ];

    NSRect screenFrame = [ NSScreen mainScreen ].frame;
    CGFloat maxWidth = floor( NSWidth( screenFrame ) / 2 );
    [ self setMaxSize: NSMakeSize( maxWidth, stdHeight ) ];

    self->__standardIdentifiers = @[ SearchStuffSearchWidgetIdentifier
                                   , SearchStuffReloadWidgetIdentifier
                                   ];
    }

@end // SSSearchStuffToolbarItem class

// SSSearchStuffToolbarItem + SearchStuffPrivate
@implementation SSSearchStuffToolbarItem ( SearchStuffPrivate )

@dynamic __standardIdentifiers;

- ( NSArray* ) __standardIdentifiers
    {
    return self->__standardIdentifiers;
    }

@end // SSSearchStuffToolbarItem + SearchStuffPrivate