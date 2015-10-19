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

- ( NSArray <__kindof SSSearchStuffWidget*>* ) leftHandSideAnchoredWidgets;
- ( NSArray <__kindof SSSearchStuffWidget*>* ) rightHandSideAnchoredWidgets;

- ( NSArray <__kindof SSSearchStuffWidget*>* ) leftHandSideFloatWidgets;
- ( NSArray <__kindof SSSearchStuffWidget*>* ) rightHandSideFloatWidgets;

@end // SSSearchStuffDelegate protocol