//
//  __SSSearchStuffBar.h
//  Playground
//
//  Created by Tong G. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

@import Cocoa;

@class SSSearchStuffToolbarItem;

// __SSSearchStuffBar class
@interface __SSSearchStuffBar : NSView <NSTextFieldDelegate>
    {
@private
    BOOL __isInputting;

    NSView* __lhsAnchoredField;
    NSView* __rhsAnchoredField;

    NSView* __lhsFloatField;
    NSView* __rhsFloatField;
    }

#pragma mark - Manipulating Widgets

@property ( weak, readwrite ) SSSearchStuffToolbarItem* hostingSSToolbarItem;

- ( void ) reload;

@end // __SSSearchStuffBar class
