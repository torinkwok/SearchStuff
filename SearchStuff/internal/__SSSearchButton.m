//
//  __SSSearchButton.m
//  Playground
//
//  Created by Tong G. on 10/19/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchButton.h"

// __SSSearchButton class
@implementation __SSSearchButton

#pragma mark - Initializations

- ( instancetype ) initWithFrame: ( NSRect )_Frame
    {
    if ( self = [ super initWithFrame: _Frame ] )
        {
        self.ssImage = [ NSImage imageNamed: @"search-stuff-search" ];
        self.ssAlternativeImage = [ NSImage imageNamed: @"search-stuff-search-highlighted" ];
        }

    return self;
    }

@end // __SSSearchButton class
