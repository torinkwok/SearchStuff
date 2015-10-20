//
//  AppDelegate.m
//  Playground
//
//  Created by Tong Kuo. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchStuff.h"
#import "SSSearchStuffToolbarItem.h"

// Private Interfaces
@interface AppDelegate ()

@property ( weak ) IBOutlet NSWindow* window;
@property ( strong ) SSSearchStuffToolbarItem* ssToolbarItem;

- ( NSToolbarItem* ) __toolbarWithIdentifier: ( NSString* )_Identifier
                                       label: ( NSString* )_Label
                                 paleteLabel: ( NSString* )_PaleteLabel
                                     toolTip: ( NSString* )_ToolTip
                                      target: ( id )_Target
                                      action: ( SEL )_ActionSEL
                                 itemContent: ( id )_ImageOrView
                                     repMenu: ( NSMenu* )_Menu;

@end // Private Interfaces

// AppDelegate class
@implementation AppDelegate

#pragma mark - Initializations

- ( instancetype ) init
    {
    if ( self = [ super init ] )
        {
        self.ssToolbarItem = [ [ SSSearchStuffToolbarItem alloc ] initWithItemIdentifier: kSearchStuffWidget ];
        [ self.ssToolbarItem setLabel: NSLocalizedString( @"Search Stuff Bar", nil ) ];
        [ self.ssToolbarItem setPaletteLabel: self.ssToolbarItem.label ];
        [ self.ssToolbarItem setDelegate: self ];
        }

    return self;
    }

#pragma mark - Conforms to <NSToolbarDelegate>

NSString* const kSearchStuffWidget = @"kSearchStuffWidget";
NSString* const kLhsPlaceholderButton = @"kLhsPlaceholderButton";
NSString* const kRhsPlaceholderButton = @"kRhsPlaceholderButton";

- ( NSArray* ) toolbarAllowedItemIdentifiers: ( NSToolbar* )_Toolbar
    {
    return @[ NSToolbarFlexibleSpaceItemIdentifier
            , NSToolbarSpaceItemIdentifier
            , kSearchStuffWidget
            , kLhsPlaceholderButton
            , kRhsPlaceholderButton
             ];
    }

- ( NSArray* ) toolbarDefaultItemIdentifiers: ( NSToolbar* )_Toolbar
    {
    return @[ kLhsPlaceholderButton
            , NSToolbarSpaceItemIdentifier
            , kSearchStuffWidget
            , NSToolbarFlexibleSpaceItemIdentifier
            , kRhsPlaceholderButton
            ];
    }

- ( NSToolbarItem* )  toolbar: ( NSToolbar* )_Toolbar
        itemForItemIdentifier: ( NSString* )_ItemIdentifier
    willBeInsertedIntoToolbar: ( BOOL )_Flag
    {
    NSToolbarItem* toolbarItem = nil;
    BOOL should = NO;

    NSString* identifier = _ItemIdentifier;
    NSString* label = nil;
    NSString* paleteLabel = nil;
    NSString* toolTip = nil;
    id content = nil;
    id target = self;
    SEL action = nil;
    NSMenu* repMenu = nil;

    if ( ( should = [ _ItemIdentifier isEqualToString: kSearchStuffWidget ] ) )
        {
        should = NO;
        toolbarItem = self.ssToolbarItem;
        [ self.ssToolbarItem reload ];
        }

    else if ( ( should = ( [ _ItemIdentifier isEqualToString: kLhsPlaceholderButton ]
                            || [ _ItemIdentifier isEqualToString: kRhsPlaceholderButton ] ) ) )
        {
        NSString* dynamicLabel = [ _ItemIdentifier isEqualToString: kLhsPlaceholderButton ] ? @"Left" : @"Right";
        label = dynamicLabel;
        paleteLabel = label;

        NSButton* button = [ [ NSButton alloc ] initWithFrame: NSMakeRect( 0, 0, 80, 25 ) ];
        [ button setTitle: dynamicLabel ];
        [ button setBezelStyle: NSTexturedRoundedBezelStyle ];

        content = button;
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

#pragma mark - Conforms to <SearchStuffDelegate>

- ( NSArray <__kindof NSString*>* ) ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers
    {
    return @[ SearchStuffReloadWidgetIdentifier ];
    }

//- ( SSSearchStuffWidget* ) ssToolbarItem: ( SSSearchStuffToolbarItem* )_ssToolbarItem
//               widgetForWidgetIdentifier: ( NSString* )_Identifier
//    {
//    SSSearchStuffWidget* ssWidget = nil;
//
//    if ( [ _Identifier isEqualToString: SearchStuffReloadWidgetIdentifier ] )
//
//    }

#pragma mark - Private Interfaces

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
        [ newToolbarItem setView: ( NSView* )_ImageOrView ];

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