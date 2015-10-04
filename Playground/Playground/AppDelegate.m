//
//  AppDelegate.m
//  Playground
//
//  Created by Tong Kuo. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "AppDelegate.h"

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
    return @[ NSToolbarFlexibleSpaceItemIdentifier, NSToolbarShowColorsItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier ];
    }

- ( NSArray* ) toolbarDefaultItemIdentifiers: ( NSToolbar* )_Toolbar
    {
    return @[ NSToolbarFlexibleSpaceItemIdentifier, NSToolbarShowColorsItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier ];
    }

@end // AppDelegate class