/*=============================================================================┐
|    _______           _     _              ______               ___    ___    |  
|   (_______)         | |   (_)            / _____) _           / __)  / __)   |██
|    _____ _   _  ____| |  _ _ ____   ____( (____ _| |_ _   _ _| |__ _| |__    |██
|   |  ___) | | |/ ___) |_/ ) |  _ \ / _  |\____ (_   _) | | (_   __|_   __)   |██
|   | |   | |_| ( (___|  _ (| | | | ( (_| |_____) )| |_| |_| | | |    | |      |██
|   |_|   |____/ \____)_| \_)_|_| |_|\___ (______/  \__)____/  |_|    |_|      |██
|                                   (_____|                                    |██
|                                                                              |██
|      _ ______                        _      ______               ___    ___  |██
|     | / _____)                      | |    / _____) _           / __)  / __) |██
|    / ( (____  _____ _____  ____ ____| |__ ( (____ _| |_ _   _ _| |__ _| |__  |██
|   / / \____ \| ___ (____ |/ ___) ___)  _ \ \____ (_   _) | | (_   __|_   __) |██
|  / /  _____) ) ____/ ___ | |  ( (___| | | |_____) )| |_| |_| | | |    | |    |██
| |_|  (______/|_____)_____|_|   \____)_| |_(______/  \__)____/  |_|    |_|    |██
|                                                                              |██
|                                                                              |██
|                         Copyright (c) 2015 Tong Kuo                          |██
|                                                                              |██
|                             ALL RIGHTS RESERVED.                             |██
|                                                                              |██
└==============================================================================┘██
  ████████████████████████████████████████████████████████████████████████████████
  ██████████████████████████████████████████████████████████████████████████████*/

#import "__SSWidget.h"
#import "__SSWidgetCell.h"
#import "__SSWidgetStdSearch.h"
#import "__SSWidgetStdReload.h"
#import "__SSWidgetUser.h"
#import "__SSWidget+__SSPrivate.h"

#import "SearchStuffWidget+__SSPrivate.h"

// Private Interfaces
@interface __SSWidget ()
- ( void ) __redrawWithHighlighted: ( BOOL )_IsHighlighted;
@end // Private Interfaces

// __SSWidget class
@implementation __SSWidget
    {
@protected
    SearchStuffWidget __strong*  __ssWidget;

    NSImage __strong* __ssImage;
    NSImage __strong* __ssAlternativeImage;

    NSSize __ssSize;
    }

@dynamic ssWidget;

@dynamic ssImage;
@dynamic ssAlternativeImage;

@dynamic ssSize;

#pragma mark - Initializations

+ ( instancetype ) ssButtonWithSSWidget: ( SearchStuffWidget* )_Widget
    {
    if ( !_Widget )
        return nil;

    __SSWidget* clusterMember = nil;
    if ( _Widget.__isStd )
        {
        if ( [ _Widget.identifier isEqualToString: SearchStuffSearchWidgetIdentifier ] )
            clusterMember = [ [ __SSWidgetStdSearch alloc ] __initWithSSWiget: _Widget ];

        else if ( [ _Widget.identifier isEqualToString: SearchStuffReloadWidgetIdentifier ] )
            clusterMember = [ [ __SSWidgetStdReload alloc ] __initWithSSWiget: _Widget ];
        }
    else
        clusterMember = [ [ __SSWidgetUser alloc ] __initWithSSWiget: _Widget ];

    return clusterMember;
    }

#pragma mark - Dynamic Properties

- ( SearchStuffWidget* ) ssWidget
    {
    return [ __ssWidget copy ];
    }

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

#pragma mark - Drawing

+ ( Class ) cellClass
    {
    return [ __SSWidgetCell class ];
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

@end // __SSWidget class

// __SSWidget + __SSPrivate
@implementation __SSWidget ( __SSPrivate )

#pragma mark Private Initializations ( only used by friend classes )

- ( instancetype ) __initWithSSWiget: ( SearchStuffWidget* )_Widget
    {
    if ( !_Widget )
        return nil;

    if ( self = [ super initWithFrame: NSZeroRect /* Frame doesn't matter */ ] )
        {
        self->__ssWidget = _Widget;
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

@end // __SSWidget + __SSPrivate

/*===============================================================================┐
|                                                                                |
|                           The MIT License (MIT)                                |
|                                                                                |
|                        Copyright (c) 2015 Tong Kuo                             |
|                                                                                |
| Permission is hereby granted, free of charge, to any person obtaining a copy   |
| of this software and associated documentation files (the "Software"), to deal  |
| in the Software without restriction, including without limitation the rights   |
| to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      |
|   copies of the Software, and to permit persons to whom the Software is        |
|         furnished to do so, subject to the following conditions:               |
|                                                                                |
| The above copyright notice and this permission notice shall be included in all |
|              copies or substantial portions of the Software.                   |
|                                                                                |
| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     |
| IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       |
| FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    |
|  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        |
| LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  |
| OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  |
|                                 SOFTWARE.                                      |
|                                                                                |
└===============================================================================*/