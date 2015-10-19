//
//  __SSButton.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSButton.h"
#import "__SSButtonCell.h"

#import "__SSMacro.h"

// Private Interfaces
@interface __SSButton ()
- ( void ) __redrawWithHighlighted: ( BOOL )_IsHighlighted;
@end // Private Interfaces

// __SSButton class
@implementation __SSButton
    {
@protected
    NSImage* __strong __ssDefaultAlternativeImage;
    }

@dynamic ssDefaultAlternativeImage;

#pragma mark - Pure Virtual Methods

+ ( NSImage* ) ssDefaultImage
    {
    __Throw_exception_because_of_invocation_of_pure_virtual_method;
    return nil;
    }

- ( NSImage* ) ssDefaultAlternativeImage
    {
    return self->__ssDefaultAlternativeImage;
    }

- ( void ) setSsDefaultAlternativeImage: ( NSImage* )_Image
    {
    self->__ssDefaultAlternativeImage = _Image;
    [ self setAlternateImage: self->__ssDefaultAlternativeImage ];
    }

#pragma mark - Default Properties

- ( NSSize ) ssDefaultSize
    {
    NSImage* ssDefaultImage = [ [ self class ] ssDefaultImage ];
    NSSize theSize = NSMakeSize( 15.f * ssDefaultImage.size.width / ssDefaultImage.size.height, 15.f );

    return theSize;
    }

#pragma mark - Initializations

- ( instancetype ) initWithFrame: ( NSRect )_FrameRect
    {
    if ( self = [ super initWithFrame: _FrameRect ] )
        {
        [ self setFrameSize: [ self ssDefaultSize ] ];
//        [ self setImage: [ [ self class ] ssDefaultImage ] ];
//        [ self setAlternateImage: [ self ssDefaultAlternativeImage ] ];

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
