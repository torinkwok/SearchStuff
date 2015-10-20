//
//  __SSButton.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSButton.h"
#import "__SSButtonCell.h"

// Private Interfaces
@interface __SSButton ()
- ( void ) __redrawWithHighlighted: ( BOOL )_IsHighlighted;
@end // Private Interfaces

// __SSButton class
@implementation __SSButton
    {
@protected
    NSImage* __strong __ssImage;
    NSImage* __strong __ssAlternativeImage;

    NSSize __ssSize;
    }

@dynamic ssImage;
@dynamic ssAlternativeImage;

#pragma mark - Dynamic Properties

- ( void ) setSsImage: ( NSImage* )_Image
    {
    if ( self->__ssImage != _Image )
        {
        self->__ssImage = _Image;
        [ self setImage: self->__ssImage ];

        self->__ssSize = NSMakeSize( 15.f * self->__ssImage.size.width / self->__ssImage.size.height, 15.f );

        if ( ( self->__ssSize.width ) > 0 && ( self->__ssSize.height > 0 ) )
        [ self setFrameSize: [ self ssSize ] ];
        }
    }

- ( NSImage* ) ssImage
    {
    return self->__ssImage;
    }

- ( void ) setSsAlternativeImage: ( NSImage* )_Image
    {
    if ( self->__ssAlternativeImage != _Image )
        {
        self->__ssAlternativeImage = _Image;
        [ self setAlternateImage: self->__ssAlternativeImage ];
        }
    }

- ( NSImage* ) ssAlternativeImage
    {
    return self->__ssAlternativeImage;
    }


- ( NSSize ) ssSize
    {
    return self->__ssSize;
    }

#pragma mark - Initializations

- ( instancetype ) initWithFrame: ( NSRect )_FrameRect
    {
    if ( self = [ super initWithFrame: _FrameRect ] )
        {
        self->__ssSize = NSZeroSize;

        NSTrackingArea* trackingArea =
            [ [ NSTrackingArea alloc ] initWithRect: self.bounds
                                            options: NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingCursorUpdate
                                                        | NSTrackingActiveAlways
                                                        /* This NSTrackingArea object was created with NSTrackingInVisibleRect option,
                                                         * in which case the AppKit handles the re-computation of tracking area */
                                                        | NSTrackingInVisibleRect
                                              owner: self
                                           userInfo: nil ];
        [ self addTrackingArea: trackingArea ];
        }

    return self;
    }

#pragma mark - Drawing

+ ( Class ) cellClass
    {
    return [ __SSButtonCell class ];
    }

#pragma mark - Events

- ( void ) mouseEntered: ( NSEvent* )_Event
    {
    [ self __redrawWithHighlighted: YES ];
    }

- ( void ) mouseExited: ( NSEvent* )_Event
    {
    [ self __redrawWithHighlighted: NO ];
    }

- ( void ) mouseDown: ( NSEvent* )_Event
    {
    [ self __redrawWithHighlighted: YES ];
    }

- ( void ) cursorUpdate: ( NSEvent* )_Event
    {
    [ [ NSCursor arrowCursor ] set ];
    }

#pragma mark - Private Interfaces

- ( void ) __redrawWithHighlighted: ( BOOL )_IsHighlighted
    {
    [ self.cell setHighlighted: _IsHighlighted ];
    [ self setNeedsDisplay ];
    }

@end // __SSButton class
