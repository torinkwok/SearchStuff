//
//  __SSSearchStuffWidgetStd.m
//  Playground
//
//  Created by Tong G. on 10/20/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffWidgetStd.h"
#import "__SSSearchStuffWidget.h"

// __SSSearchStuffWidgetStd class
@implementation __SSSearchStuffWidgetStd

#pragma mark - Initializations

+ ( instancetype ) ssSearchWidget
    {
    return [ [ self alloc ] initWithIdentifier: SearchStuffSearchWidgetIdentifier ];
    }

+ ( instancetype ) ssReloadWidget
    {
    return [ [ self alloc ] initWithIdentifier: SearchStuffReloadWidgetIdentifier ];
    }

@end // __SSSearchStuffWidgetStd class
