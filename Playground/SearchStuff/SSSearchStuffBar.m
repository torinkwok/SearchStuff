//
//  SSSearchStuffBar.m
//  Playground
//
//  Created by Tong G. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "SSSearchStuffBar.h"

// Private Interfaces
@interface SSSearchStuffBar()

@property ( strong ) NSButtonCell* __backingCell;

- ( void ) __init;

@end // Private Interfaces

// SSSearchStuffBar class
@implementation SSSearchStuffBar

@synthesize __backingCell;

#pragma mark Initializations
- ( instancetype ) initWithCoder: ( NSCoder* )_Coder
    {
    if ( self = [ super initWithCoder: _Coder ] )
        [ self __init ];

    return self;
    }

- ( instancetype ) initWithFrame: ( NSRect )_FrameRect
    {
    if ( self = [ super initWithFrame: _FrameRect ] )
        [ self __init ];

    return self;
    }

#pragma Drawing
- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];
    [ self->__backingCell drawWithFrame: self.bounds inView: self ];
    }

#pragma mark Private Interfaces
- ( void ) __init
    {
    [ self setWantsLayer: YES ];

    self->__backingCell = [ [ NSButtonCell alloc ] init ];
    [ self->__backingCell setBezelStyle: NSTexturedRoundedBezelStyle ];
    [ self->__backingCell setTitle: @"" ];
    }

@end // SSSearchStuffBar class
