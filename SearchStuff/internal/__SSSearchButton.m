//
//  __SSSearchButton.m
//  Playground
//
//  Created by Tong G. on 10/19/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchButton.h"

@implementation __SSSearchButton

#pragma mark - Overrides Pure Virtual Methods

- ( instancetype ) initWithFrame: ( NSRect )_Frame
    {
    if ( self = [ super initWithFrame: _Frame ] )
        {
        self.ssImage = [ NSImage imageNamed: @"search-stuff-search" ];
        self.ssDefaultAlternativeImage = [ NSImage imageNamed: @"search-stuff-search-highlighted" ];
        }

    return self;
    }

+ ( NSImage* ) ssDefaultImage
    {
    return [ NSImage imageNamed: @"search-stuff-search" ];
    }

//+ ( NSImage* ) ssDefaultAlternativeImage
//    {
//    return [ NSImage imageNamed: @"search-stuff-search-highlighted" ];
//    }

@end
