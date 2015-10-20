//
//  __SSSearchStuffWidgetStd.m
//  Playground
//
//  Created by Tong G. on 10/20/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffWidgetStd.h"

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

- ( instancetype ) __initWithIdentifier: ( NSString* )_Identifier
    {
    if ( self = [ super initWithIdentifier: _Identifier ] )
        self->__isStandardWidget = YES;

    return self;
    }

@end // __SSSearchStuffWidgetStd class
