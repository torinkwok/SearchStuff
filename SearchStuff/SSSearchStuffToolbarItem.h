//
//  SSSearchStuffToolbarItem.h
//  Playground
//
//  Created by Tong G. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

@import Cocoa;

@class SSSearchStuffWidget;

@protocol SearchStuffDelegate;

// Standard Identifiers
NSString extern* const SearchStuffSearchWidgetIdentifier;
NSString extern* const SearchStuffReloadWidgetIdentifier;

// SSSearchStuffToolbarItem class
@interface SSSearchStuffToolbarItem : NSToolbarItem

#pragma mark Delegate

@property ( weak ) IBOutlet id <SearchStuffDelegate> delegate;

#pragma mark - Manipulating Widgets

- ( void ) reload;

@end // SSSearchStuffToolbarItem class

// SSSearchStuffDelegate protocol
@protocol SearchStuffDelegate <NSObject>

- ( SSSearchStuffWidget* ) ssToolbarItemWithTitleWidget: ( SSSearchStuffToolbarItem* )_ssToolbarItem;

- ( NSArray <__kindof NSString*>* ) ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers;
- ( NSArray <__kindof NSString*>* ) ssToolbarItemRightHandSideAnchoredWidgetIdentifiers;

- ( NSArray <__kindof NSString*>* ) ssToolbarItemLeftHandSideFloatWidgetIdentifiers;
- ( NSArray <__kindof NSString*>* ) ssToolbarItemRightHandSideFloatWidgetIdentifiers;

- ( SSSearchStuffWidget* ) ssToolbarItem: ( SSSearchStuffToolbarItem* )_ssToolbarItem
               widgetForWidgetIdentifier: ( NSString* )_Identifier;

@end // SSSearchStuffDelegate protocol