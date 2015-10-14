//
//  __SSSearchButton.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchButton.h"
#import "__SSSearchButtonCell.h"

// __SSSearchButton class
@implementation __SSSearchButton

+ ( NSSize ) defaultSize
    {
    return NSMakeSize( 15.f, 15.f );
    }

#pragma mark - Initializations
- ( instancetype ) initWithFrame: ( NSRect )_FrameRect
    {
    if ( self = [ super initWithFrame: _FrameRect ] )
        {
        [ self setFrameSize: [ [ self class ] defaultSize ] ];
        [ self setImage: [ NSImage imageNamed: @"search-stuff-search" ] ];
        [ self setAlternateImage: [ NSImage imageNamed: @"search-stuff-search-highlighted" ] ];
        }

    return self;
    }

#pragma mark - Drawing
+ ( Class ) cellClass
    {
    return [ __SSSearchButtonCell class ];
    }

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];
    
    // Drawing code here.
    }

@end // __SSSearchButton class
