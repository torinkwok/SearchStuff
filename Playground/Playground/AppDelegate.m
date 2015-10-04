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
NSString* const kLhsPlaceholderButton = @"kLhsPlaceholderButton";
NSString* const kRhsPlaceholderButton = @"kRhsPlaceholderButton";

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
    BOOL should = NO;

    NSString* identifier = nil;
    NSString* label = nil;
    NSString* paleteLabel = nil;
    NSString* toolTip = nil;
    id content = nil;
    id target = nil;
    SEL action = nil;
    NSMenu* repMenu = nil;

    if ( ( should = [ _ItemIdentifier isEqualToString: kSearchStuffWidget ] ) )
        {
        identifier = @"kSearchStuff";
        label = NSLocalizedString( @"Search Stuff Widget", nil );
        paleteLabel = label;
        toolTip = NSLocalizedString( @"Search whatever here", nil );
        target = self;
        content = [ [ SSSearchBar alloc ] initWithFrame: NSMakeRect( 0, 0, 0, 0 ) ];
        }

    if ( should )
        {
        toolbarItem = [ self __toolbarWithIdentifier: identifier
                                               label: label
                                         paleteLabel: paleteLabel
                                             toolTip: toolTip
                                              target: target
                                              action: action
                                         itemContent: content
                                             repMenu: repMenu ];
        }

    return toolbarItem;
    }

- ( NSToolbarItem* ) __toolbarWithIdentifier: ( NSString* )_Identifier
                                       label: ( NSString* )_Label
                                 paleteLabel: ( NSString* )_PaleteLabel
                                     toolTip: ( NSString* )_ToolTip
                                      target: ( id )_Target
                                      action: ( SEL )_ActionSEL
                                 itemContent: ( id )_ImageOrView
                                     repMenu: ( NSMenu* )_Menu
    {
    NSToolbarItem* newToolbarItem = [ [ NSToolbarItem alloc ] initWithItemIdentifier: _Identifier ];

    [ newToolbarItem setLabel: _Label ];
    [ newToolbarItem setPaletteLabel: _PaleteLabel ];
    [ newToolbarItem setToolTip: _ToolTip ];

    [ newToolbarItem setTarget: _Target ];
    [ newToolbarItem setAction: _ActionSEL ];

    if ( [ _ImageOrView isKindOfClass: [ NSImage class ] ] )
        [ newToolbarItem setImage: ( NSImage* )_ImageOrView ];

    else if ( [ _ImageOrView isKindOfClass: [ NSView class ] ] )
        {
        [ newToolbarItem setView: ( NSView* )_ImageOrView ];
        [ newToolbarItem setMinSize: NSMakeSize( 100, 24 ) ];
        [ newToolbarItem setMaxSize: NSMakeSize( 1000, 24 ) ];
        }

    if ( _Menu )
        {
        NSMenuItem* repMenuItem = [ [ NSMenuItem alloc ] init ];
        [ repMenuItem setSubmenu: _Menu ];
        [ repMenuItem setTitle: _Label ];
        [ newToolbarItem setMenuFormRepresentation: repMenuItem ];
        }

    return newToolbarItem;
    }

@end // AppDelegate class