//
//  __SSPreSearchButton.m
//  Playground
//
//  Created by Tong G. on 10/19/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSPreSearchButton.h"

// __SSPreSearchButton class
@implementation __SSPreSearchButton

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

@end // __SSPreSearchButton class
