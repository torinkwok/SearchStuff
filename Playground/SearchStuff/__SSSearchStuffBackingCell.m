//
//  __SSSearchStuffBackingCell.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffBackingCell.h"

// __SSSearchStuffBackingCell class
@implementation __SSSearchStuffBackingCell

- ( instancetype ) init
    {
    if ( self = [ super init ] )
        {
        [ self setBezelStyle: NSTexturedRoundedBezelStyle ];
        [ self  setTitle: @"" ];
        }

    return self;
    }

@end // __SSSearchStuffBackingCell class
