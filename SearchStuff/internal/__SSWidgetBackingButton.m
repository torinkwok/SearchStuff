/*=============================================================================┐
|  _______           _     _              ______               ___    ___      |  
| (_______)         | |   (_)            / _____) _           / __)  / __)     |██
|  _____ _   _  ____| |  _ _ ____   ____( (____ _| |_ _   _ _| |__ _| |__ ___  |██
| |  ___) | | |/ ___) |_/ ) |  _ \ / _  |\____ (_   _) | | (_   __|_   __)___) |██
| | |   | |_| ( (___|  _ (| | | | ( (_| |_____) )| |_| |_| | | |    | | |___ | |██
| |_|   |____/ \____)_| \_)_|_| |_|\___ (______/  \__)____/  |_|    |_| (___/  |██
|                                 (_____|                                      |██
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

#import "__SSWidgetBackingButton.h"
#import "__SSWidgetBackingButtonCell.h"

#import "__SSWidgetBackingStdButton.h"
#import "__SSWidgetBackingUserCusButton.h"

#import "__SSWidgetBackingButton+__SSPrivate.h"
#import "__SSConstants.h"

#import "__SSWidget.h"
#import "__SSWidgetsPallet.h"
#import "__SSBar.h"
#import "__SSMouseEnteredTimer.h"
#import "__SSMouseTrackingArea.h"

#import "SearchStuffWidget+__SSPrivate.h"

// Private Interfaces
@interface __SSWidgetBackingButton ()
- ( void ) __redrawWithHighlighted: ( BOOL )_IsHighlighted;
@end // Private Interfaces

// __SSWidgetBackingButton class
@implementation __SSWidgetBackingButton
    {
@protected
    SearchStuffWidget __strong*  __repWidget;

    NSImage __strong* __ssImage;
    NSImage __strong* __ssAlternativeImage;
    NSString __strong* __ssToolTip;

    NSSize __ssConstraintSize;

    NSLayoutConstraint __weak* __widthConstraint;
    NSLayoutConstraint __weak* __heightConstraint;
    NSArray __strong* __sizeConstraints;

    NSView __weak* __host;

    __SSMouseEnteredTimer* __mouseEnteredTimer;
    }

@dynamic repWidget;

@dynamic ssImage;
@dynamic ssAlternativeImage;
@dynamic ssToolTip;

@dynamic constraintSize;

@dynamic host;
@dynamic usesSearchStuffStyleToolTip;

#pragma mark - Initializations

+ ( instancetype ) ssWidgetBackingButtonWithRepWidget: ( SearchStuffWidget* )_RepWidget
                                                 host: ( NSView* )_HostView
    {
    if ( !_RepWidget )
        return nil;

    __SSWidgetBackingButton* clusterMember = nil;
    if ( _RepWidget.__isStd )
        {
        __SSWidgetBackingStdButtonType stdType = __SSWidgetBackingStdButtonTypeUnspecified;

        if ( [ _RepWidget.identifier isEqualToString: SearchStuffSearchWidgetIdentifier ] )
            stdType = __SSWidgetBackingStdButtonTypeSearch;

        else if ( [ _RepWidget.identifier isEqualToString: SearchStuffReloadWidgetIdentifier ] )
            stdType = __SSWidgetBackingStdButtonTypeReload;

        else if ( [ _RepWidget.identifier isEqualToString: SearchStuffGreenLockWidgetIdentifier ] )
            stdType = __SSWidgetBackingStdButtonTypeGreenLock;

        else if ( [ _RepWidget.identifier isEqualToString: SearchStuffGrayLockWidgetIdentifier ] )
            stdType = __SSWidgetBackingStdButtonTypeGrayLock;

        clusterMember = [ [ __SSWidgetBackingStdButton alloc ] initWithRepWidget: _RepWidget stdType: stdType host: _HostView ];
        }
    else
        clusterMember = [ [ __SSWidgetBackingUserCusButton alloc ] __initWithRepWidget: _RepWidget host: _HostView ];

    return clusterMember;
    }

- ( void ) setToolTip: ( NSString* )_ToolTip
    {
    if ( !self.usesSearchStuffStyleToolTip )
        [ super setToolTip: _ToolTip ];
    }

#pragma mark - Dynamic Properties

- ( SearchStuffWidget* ) repWidget
    {
    return [ __SSWidgetBackingButton copy ];
    }

- ( void ) setSsImage: ( NSImage* )_Image
    {
    if ( self->__ssImage != _Image )
        {
        self->__sizeConstraints = nil;

        self->__ssImage = _Image;
        [ self setImage: self->__ssImage ];

        CGFloat fixedWidth = 0.f;
        if ( self->__repWidget.widgetSize == SearchStuffMiniWidgetSize )
            fixedWidth = SS_WIDGETS_FIXED_MINI_WIDTH;
        else if ( self->__repWidget.widgetSize == SearchStuffSmallWidgetSize )
            fixedWidth = SS_WIDGETS_FIXED_SMALL_WIDTH;
        else
            fixedWidth = SS_WIDGETS_FIXED_REGULAR_WIDTH;

        self->__ssConstraintSize = NSMakeSize( fixedWidth * self->__ssImage.size.width / self->__ssImage.size.height
                                             , fixedWidth
                                             );

        if ( ( self->__ssConstraintSize.width ) > 0 && ( self->__ssConstraintSize.height > 0 ) )
            {
            self->__widthConstraint = [ NSLayoutConstraint
                constraintWithItem: self
                         attribute: NSLayoutAttributeWidth
                         relatedBy: NSLayoutRelationEqual
                            toItem: nil
                         attribute: NSLayoutAttributeNotAnAttribute
                        multiplier: 1.f
                          constant: [ self constraintSize ].width ];

            self->__heightConstraint = [ NSLayoutConstraint
                constraintWithItem: self
                         attribute: NSLayoutAttributeHeight
                         relatedBy: NSLayoutRelationEqual
                            toItem: nil
                         attribute: NSLayoutAttributeNotAnAttribute
                        multiplier: 1.f
                          constant: [ self constraintSize ].height ];

            self->__sizeConstraints = @[ self->__widthConstraint, self->__heightConstraint ];
            [ self addConstraints: self->__sizeConstraints ];
            }
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

- ( void ) setSsToolTip: ( NSString* )_ToolTip
    {
    if ( self->__ssToolTip != _ToolTip )
        {
        self->__ssToolTip = _ToolTip;
        self.toolTip = self->__ssToolTip;
        }
    }

- ( NSString* ) ssToolTip
    {
    return self->__ssToolTip;
    }

- ( NSSize ) constraintSize
    {
    return self->__ssConstraintSize;
    }

- ( NSView* ) host
    {
    return self->__host;
    }

- ( BOOL ) usesSearchStuffStyleToolTip
    {
    BOOL yesOrNo = NO;

    NSView* palletHost = ( ( ( __SSWidget* )self.host ).host );
    if ( [ palletHost isKindOfClass: [ __SSWidgetsPallet class ] ] )
        yesOrNo = [ ( __SSWidgetsPallet* )palletHost ssType ] != __SSPalletTypeTitle;

    return yesOrNo;
    }

#pragma mark - Drawing

+ ( Class ) cellClass
    {
    return [ __SSWidgetBackingButtonCell class ];
    }

#pragma mark - Events

- ( void ) mouseEntered: ( NSEvent* )_Event
    {
    [ self __redrawWithHighlighted: YES ];

    if ( self.usesSearchStuffStyleToolTip )
        {
        if ( !self->__mouseEnteredTimer )
            {
            self->__mouseEnteredTimer = [ [ __SSMouseEnteredTimer alloc ] initWithTimeInterval: .5f
                                                                                 excutionBlock:
                ( __SSMouseEnteredTimerExcutionBlockType )^( void )
                    {
                    if ( self.ssToolTip.length > 0 )
                        [ [ NSNotificationCenter defaultCenter ] postNotificationName: SearchStuffShouldDisplayToolTip
                                                                               object: self
                                                                             userInfo: @{ kToolTip : self.ssToolTip } ];
                    } ];
            }

        [ self->__mouseEnteredTimer start ];
        }
    }

- ( void ) mouseExited: ( NSEvent* )_Event
    {
    [ self->__mouseEnteredTimer stop ];
    [ self __redrawWithHighlighted: NO ];

    if ( self.usesSearchStuffStyleToolTip )
        [ [ NSNotificationCenter defaultCenter ] postNotificationName: SearchStuffShouldHideToolTip object: self ];
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

@end // __SSWidgetBackingButton class

// __SSWidgetBackingButton + __SSPrivate
@implementation __SSWidgetBackingButton ( __SSPrivate )

#pragma mark Private Initializations ( only used by friend classes )

- ( instancetype ) __initWithRepWidget: ( SearchStuffWidget* )_RepWidget
                                  host: ( NSView* )_HostView
    {
    if ( !_RepWidget )
        return nil;

    if ( self = [ super initWithFrame: NSZeroRect /* Frame doesn't matter */ ] )
        {
        self->__host = _HostView;

        self->__repWidget = _RepWidget;
        self->__ssConstraintSize = NSZeroSize;

        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.ssToolTip = _RepWidget.toolTip;

        [ self addTrackingArea: [ [ __SSMouseTrackingArea alloc ] initWithHost: self ] ];
        }

    return self;
    }

@end // __SSWidgetBackingButton + __SSPrivate

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