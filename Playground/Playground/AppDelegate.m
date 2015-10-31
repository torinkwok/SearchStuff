/*=============================================================================┐
|      ______                        _      ______               ___    ___    |  
|     / _____)                      | |    / _____) _           / __)  / __)   |██
|    ( (____  _____ _____  ____ ____| |__ ( (____ _| |_ _   _ _| |__ _| |__    |██
|     \____ \| ___ (____ |/ ___) ___)  _ \ \____ (_   _) | | (_   __|_   __)   |██
|     _____) ) ____/ ___ | |  ( (___| | | |_____) )| |_| |_| | | |    | |      |██
|    (______/|_____)_____|_|   \____)_| |_(______/  \__)____/  |_|    |_|      |██
|                                                                              |██
|           ______  _                                               _          |██
|          (_____ \| |                                             | |         |██
|           _____) ) | _____ _   _  ____  ____ ___  _   _ ____   __| |         |██
|          |  ____/| |(____ | | | |/ _  |/ ___) _ \| | | |  _ \ / _  |         |██
|          | |     | |/ ___ | |_| ( (_| | |  | |_| | |_| | | | ( (_| |         |██
|          |_|      \_)_____|\__  |\___ |_|   \___/|____/|_| |_|\____|         |██
|                           (____/(_____|                                      |██
|                                                                              |██
|                                                                              |██
|                         Copyright (c) 2015 Tong Kuo                          |██
|                                                                              |██
|                             ALL RIGHTS RESERVED.                             |██
|                                                                              |██
└==============================================================================┘██
  ████████████████████████████████████████████████████████████████████████████████
  ██████████████████████████████████████████████████████████████████████████████*/

#import "AppDelegate.h"
#import "SearchStuff.h"
#import "SearchStuffToolbarItem.h"

// Private Interfaces
@interface AppDelegate ()

@property ( weak ) IBOutlet NSWindow* window;
@property ( strong ) SearchStuffToolbarItem* ssToolbarItem;

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
        self.ssToolbarItem = [ [ SearchStuffToolbarItem alloc ] initWithItemIdentifier: kSearchStuffWidget ];
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
//            , NSToolbarSpaceItemIdentifier
            , kSearchStuffWidget
//            , NSToolbarFlexibleSpaceItemIdentifier
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

NSString* const kSearchStuffAddWidgetIdentifier = @"kSearchStuffAddWidgetIdentifier";
NSString* const kSearchStuffRemoveWidgetIdentifier = @"kSearchStuffRemoveWidgetIdentifier";

- ( NSArray <__kindof NSString*>* ) ssToolbarItemTitleWidgetsIdentifiers
    {
    return @[ SearchStuffGreenLockWidgetIdentifier
//            , SearchStuffGrayLockWidgetIdentifier
            ];
    }

- ( NSArray <__kindof NSString*>* ) ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers
    {
    return @[ kSearchStuffAddWidgetIdentifier
            , kSearchStuffRemoveWidgetIdentifier
            ];
    }

- ( NSArray <__kindof NSString*>* ) ssToolbarItemRightHandSideAnchoredWidgetIdentifiers
    {
    return @[
            SearchStuffReloadWidgetIdentifier
            ];
    }

- ( NSArray <__kindof NSString*>* ) ssToolbarItemRightHandSideFloatWidgetIdentifiers
    {
    return @[ SearchStuffSearchWidgetIdentifier
            , SearchStuffReloadWidgetIdentifier
            , kSearchStuffAddWidgetIdentifier
            , kSearchStuffRemoveWidgetIdentifier
            ];
    }

- ( NSArray <__kindof NSString*>* ) ssToolbarItemLeftHandSideFloatWidgetIdentifiers
    {
    return @[ SearchStuffSearchWidgetIdentifier
            , SearchStuffReloadWidgetIdentifier
            , kSearchStuffAddWidgetIdentifier
            , kSearchStuffRemoveWidgetIdentifier
            ];
    }

- ( SearchStuffWidget* ) ssToolbarItem: ( SearchStuffToolbarItem* )_ssToolbarItem
             widgetForWidgetIdentifier: ( NSString* )_Identifier
    {
    SearchStuffWidget* ssWidget = [ [ SearchStuffWidget alloc ] initWithIdentifier: _Identifier ];

    if ( [ _Identifier isEqualToString: kSearchStuffAddWidgetIdentifier ] )
        {
        ssWidget.image = [ NSImage imageNamed: @"search-stuff-add" ];
        ssWidget.alternativeImage = [ NSImage imageNamed: @"search-stuff-add-highlighted" ];
//        ssWidget.text = @"RUNNING Playground: Playground";
//        ssWidget.textPosition = SearchStuffTextDefault;
        }
    else if ( [ _Identifier isEqualToString: kSearchStuffRemoveWidgetIdentifier ] )
        {
        ssWidget.image = [ NSImage imageNamed: @"search-stuff-remove" ];
        ssWidget.alternativeImage = [ NSImage imageNamed: @"search-stuff-remove-highlighted" ];
        }

    return ssWidget;
    }

- ( void ) ssToolbarWillAddWidget: ( SearchStuffWidget* )_Widget
    {
    if ( [ _Widget.identifier isEqualToString: SearchStuffGreenLockWidgetIdentifier ] )
        {
        _Widget.text = @"GitHub, Inc.";
        _Widget.textPosition = SearchStuffTextDefault;
        _Widget.textColor = [ NSColor colorWithSRGBRed: 19.f / 255 green: 197.f / 255 blue: 119.f / 255 alpha: 1.f ];
        _Widget.widgetSize = SearchStuffSmallWidgetSize;
        }
    }

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

/*===============================================================================┐
|                                                                                |
|                           The MIT License (MIT)                                |
|                                                                                |
|                        Copyright (c) 2015 Tong Kuo                             |
|                                                                                |
| Permission is hereby granted, free of charge, to any person obtaining a copy   |
| of this software and associated documentation files (the "Software"), to deal  |
| in the Software without restriction, including without limitation the rights   |
| to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      |
|   copies of the Software, and to permit persons to whom the Software is        |
|         furnished to do so, subject to the following conditions:               |
|                                                                                |
| The above copyright notice and this permission notice shall be included in all |
|              copies or substantial portions of the Software.                   |
|                                                                                |
| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     |
| IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       |
| FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    |
|  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        |
| LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  |
| OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  |
|                                 SOFTWARE.                                      |
|                                                                                |
└===============================================================================*/