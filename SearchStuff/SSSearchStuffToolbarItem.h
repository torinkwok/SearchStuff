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

// SSSearchStuffToolbarItem class
@interface SSSearchStuffToolbarItem : NSToolbarItem

@property ( weak ) IBOutlet id <SearchStuffDelegate> delegate;

@end // SSSearchStuffToolbarItem class

// SSSearchStuffDelegate protocol
@protocol SearchStuffDelegate <NSObject>

- ( SSSearchStuffWidget* ) ssToolbarItemWithTitleWidget: ( SSSearchStuffToolbarItem* )_ssToolbarItem;

- ( NSArray <__kindof SSSearchStuffWidget*>* ) ssToolbarItemWithLeftHandSideAnchoredWidgets: ( SSSearchStuffToolbarItem* )_ssToolbarItem;
- ( NSArray <__kindof SSSearchStuffWidget*>* ) ssToolbarItemWithRightHandSideAnchoredWidgets: ( SSSearchStuffToolbarItem* )_ssToolbarItem;

- ( NSArray <__kindof SSSearchStuffWidget*>* ) ssToolbarItemWithLeftHandSideFloatWidgets: ( SSSearchStuffToolbarItem* )_ssToolbarItem;
- ( NSArray <__kindof SSSearchStuffWidget*>* ) ssToolbarItemWithRightHandSideFloatWidgets: ( SSSearchStuffToolbarItem* )_ssToolbarItem;

@end // SSSearchStuffDelegate protocol