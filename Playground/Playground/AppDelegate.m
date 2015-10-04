//
//  AppDelegate.m
//  Playground
//
//  Created by Tong Kuo. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchStuff.h"

// Private Interfaces
@interface AppDelegate ()
@property ( weak ) IBOutlet NSWindow* window;
@end // Private Interfaces

// AppDelegate class
@implementation AppDelegate

#pragma mark Conforms to <NSToolbarDelegate>
NSString* const kSearchStuffWidget = @"kSearchStuffWidget";

- ( NSArray* ) toolbarAllowedItemIdentifiers: ( NSToolbar* )_Toolbar
    {
    return @[ NSToolbarFlexibleSpaceItemIdentifier, kSearchStuffWidget, NSToolbarFlexibleSpaceItemIdentifier ];
    }

- ( NSArray* ) toolbarDefaultItemIdentifiers: ( NSToolbar* )_Toolbar
    {
    return @[ NSToolbarFlexibleSpaceItemIdentifier, kSearchStuffWidget, NSToolbarFlexibleSpaceItemIdentifier ];
    }

- ( NSToolbarItem* )  toolbar: ( NSToolbar* )_Toolbar
        itemForItemIdentifier: ( NSString* )_ItemIdentifier
    willBeInsertedIntoToolbar: ( BOOL )_Flag
    {
    NSToolbarItem* toolbarItem = nil;

    if ( [ _ItemIdentifier isEqualToString: kSearchStuffWidget ] )
        {
        toolbarItem = [ [ NSToolbarItem alloc ] initWithItemIdentifier: @"Search Stuff" ];

        SSSearchBar* searchBar= [ [ SSSearchBar alloc ] initWithFrame: NSMakeRect( 0, 0, 0, 0 ) ];
        [ toolbarItem setView: searchBar ];
        [ toolbarItem setMinSize: NSMakeSize( 100, 24 ) ];
        [ toolbarItem setMaxSize: NSMakeSize( 1000, 24 ) ];
        }

    return toolbarItem;
    }

@end // AppDelegate class