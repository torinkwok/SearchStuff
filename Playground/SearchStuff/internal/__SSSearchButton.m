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

        [ self setBordered: NO ];
        [ self setBezelStyle: NSSmallSquareBezelStyle ];
        [ self setImagePosition: NSImageOnly ];
        [ self setButtonType: NSMomentaryPushInButton ];
        [ self setState: NSOffState ];
        [ self.cell setImageScaling: NSImageScaleProportionallyDown ];

        NSImage* image = [ NSImage imageNamed: @"search-stuff-search" ];
        NSImage* altImage = [ NSImage imageNamed: @"search-stuff-search-highlighted" ];
        [ self setImage: image ];
        [ self setAlternateImage: altImage ];
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
