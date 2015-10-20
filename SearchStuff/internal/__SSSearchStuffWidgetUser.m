//
//  __SSSearchStuffWidgetUser.m
//  Playground
//
//  Created by Tong G. on 10/20/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffWidgetUser.h"
#import "__SSSearchStuffWidget.h"

// __SSSearchStuffWidgetUser class
@implementation __SSSearchStuffWidgetUser

#pragma mark - Initializations

- ( instancetype ) __initWithIdentifier: ( NSString* )_Identifier
    {
    if ( self = [ super initWithIdentifier: _Identifier ] )
        self->__isStandardWidget = NO;

    return self;
    }

@end // __SSSearchStuffWidgetUser class
