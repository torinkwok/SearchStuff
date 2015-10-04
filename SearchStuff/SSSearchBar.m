//
//  SSSearchBar.m
//  Playground
//
//  Created by Tong G. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "SSSearchBar.h"

// Private Interfaces
@interface SSSearchBar()
- ( void ) __init;
@end // Private Interfaces

// SSSearchBar class
@implementation SSSearchBar

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
    self->__backingCell = [ [ NSButtonCell alloc ] init ];
    [ self->__backingCell setBezelStyle: NSTexturedRoundedBezelStyle ];
    [ self->__backingCell setTitle: @"" ];
    }

@end // SSSearchBar class
