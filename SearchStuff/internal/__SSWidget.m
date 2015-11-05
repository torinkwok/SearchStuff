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

#import "__SSWidget.h"
#import "__SSWidgetBackingButton.h"
#import "__SSWidgetBackingTitleField.h"
#import "__SSConstants.h"

#import "SearchStuffWidget.h"

// Private Interfaces
@interface __SSWidget ()

- ( void ) __updateBackingWidgetConstriants;
- ( void ) __updateSizeConstraints;

@end // Private Interfaces

// __SSWidget class
@implementation __SSWidget
    {
@protected
    __SSWidgetBackingButton* __ssBackingButton;
    __SSWidgetBackingTitleField* __ssBackingTitleField;

    NSLayoutConstraint __weak* __widthConstraint;
    NSLayoutConstraint __weak* __heightConstraint;
    NSMutableArray __strong* __sizeConstraints;

    NSMutableArray __strong* __backingWidgetsConstraints;

    NSView __weak* __host;
    }

#pragma mrak - Initilizations

- ( instancetype ) initWithRepWidget: ( SearchStuffWidget* )_RepWidget
                                host: ( NSView* )_HostView
    {
    if ( !_RepWidget || !_HostView )
        return nil;

    if ( self = [ super initWithFrame: NSZeroRect ] )
        {
        self.repWidget = _RepWidget;
        self.translatesAutoresizingMaskIntoConstraints = NO;

        self->__host = _HostView;
        }

    return self;
    }

#if 0 // DEBUG
- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ [ NSColor orangeColor ] set ];
    NSRectFill( _DirtyRect );

    [ super drawRect: _DirtyRect ];
    }
#endif

- ( void ) setToolTip: ( NSString* )_ToolTip
    {
    // Banned the tool tip
    }

- ( NSString* ) toolTip
    {
    return nil;
    }

#pragma mark - Dynamic Properties

@dynamic repWidget;
@dynamic constraintSize;

@dynamic host;

- ( SearchStuffWidget* ) repWidget
    {
    return self->__repWidget;
    }

- ( void ) setRepWidget: ( SearchStuffWidget* )_RepWidget
    {
    self->__repWidget = _RepWidget;

    [ self __updateBackingWidgetConstriants ];
    [ self __updateSizeConstraints ];
    }

- ( NSSize ) constraintSize
    {
    return NSMakeSize( self->__widthConstraint.constant
                     , self->__heightConstraint.constant
                     );
    }

- ( NSView* ) host
    {
    return self->__host;
    }

- ( void ) __updateBackingWidgetConstriants
    {
    if ( !self->__backingWidgetsConstraints )
        self->__backingWidgetsConstraints = [ NSMutableArray array ];
    else
        {
        [ self removeConstraints: self->__backingWidgetsConstraints ];
        [ self->__backingWidgetsConstraints removeAllObjects ];
        }

    // Clean up
    [ self->__ssBackingButton removeFromSuperview ];
    [ self->__ssBackingTitleField removeFromSuperview ];

    self->__ssBackingButton = nil;
    self->__ssBackingTitleField = nil;

    NSMutableDictionary* viewsDict = [ NSMutableDictionary dictionary ];
    NSMutableDictionary* metricsDict = [ NSMutableDictionary dictionary ];

    if ( self->__repWidget.textPosition != SearchStuffTextOnly )
        {
        self->__ssBackingButton = [ __SSWidgetBackingButton ssWidgetBackingButtonWithRepWidget: self->__repWidget host: self ];

        if ( self->__ssBackingButton )
            {
            NSView* backingButton = self->__ssBackingButton;
            [ self addSubview: backingButton ];

            [ viewsDict addEntriesFromDictionary: NSDictionaryOfVariableBindings( backingButton ) ];

            NSLayoutConstraint* centerYConstraint = [ NSLayoutConstraint
                constraintWithItem: backingButton
                         attribute: NSLayoutAttributeCenterY
                         relatedBy: NSLayoutRelationEqual
                            toItem: backingButton.superview
                         attribute: NSLayoutAttributeCenterY
                        multiplier: 1.f
                          constant: ( __repWidget.widgetSize != SearchStuffRegularWidgetSize ) ? .4f : 0.f ];

            [ self->__backingWidgetsConstraints addObject: centerYConstraint ];
            }
        }

    if ( self->__repWidget.textPosition != SearchStuffNoText )
        {
        self->__ssBackingTitleField = [ [ __SSWidgetBackingTitleField alloc ] initWithRepWidget: self->__repWidget ];

        if ( self->__ssBackingTitleField )
            {
            NSView* backingTitleField = self->__ssBackingTitleField;
            [ self addSubview: self->__ssBackingTitleField ];

            [ viewsDict addEntriesFromDictionary: NSDictionaryOfVariableBindings( backingTitleField ) ];

            NSLayoutConstraint* centerYConstraint = [ NSLayoutConstraint
                constraintWithItem: backingTitleField
                         attribute: NSLayoutAttributeCenterY
                         relatedBy: NSLayoutRelationEqual
                            toItem: backingTitleField.superview
                         attribute: NSLayoutAttributeCenterY
                        multiplier: 1.f
                          constant: 0.f ];

            [ self->__backingWidgetsConstraints addObject: centerYConstraint ];
            }
        }

    NSString* horVFL = nil;
    [ metricsDict addEntriesFromDictionary: @{ @"fixedGap" : @( SS_WIDGETS_FIXED_GAP ) } ];
    if ( self->__repWidget.textPosition == SearchStuffNoText )
        horVFL = @"H:|[backingButton]|";
    else if ( self->__repWidget.textPosition == SearchStuffTextDefault )
        horVFL = @"H:|[backingButton]-(==fixedGap)-[backingTitleField]|";
    else if ( self->__repWidget.textPosition == SearchStuffTextOppositeToDefault )
        horVFL = @"H:|[backingTitleField]-(==fixedGap)-[backingButton]|";
    else if ( self->__repWidget.textPosition == SearchStuffTextOnly )
        horVFL = @"H:|[backingTitleField]|";

    NSArray <__kindof NSLayoutConstraint*>* horBackingWidgetsConstraints =
        [ NSLayoutConstraint constraintsWithVisualFormat: horVFL options: 0 metrics: metricsDict views: viewsDict ];
    [ self->__backingWidgetsConstraints addObjectsFromArray: horBackingWidgetsConstraints ];

    [ self addConstraints: self->__backingWidgetsConstraints ];
    }

- ( void ) __updateSizeConstraints
    {
    if ( !self->__sizeConstraints )
        self->__sizeConstraints = [ NSMutableArray array ];
    else
        {
        [ self removeConstraints: self->__sizeConstraints ];
        [ self->__sizeConstraints removeAllObjects ];
        }

    CGFloat widthConstant = 0.f;

    if ( self->__repWidget.textPosition == SearchStuffNoText )
        widthConstant = self->__ssBackingButton.constraintSize.width;

    else if ( self->__repWidget.textPosition == SearchStuffTextDefault
                || self->__repWidget.textPosition == SearchStuffTextOppositeToDefault )
        widthConstant = self->__ssBackingButton.constraintSize.width + SS_WIDGETS_FIXED_GAP + self->__ssBackingTitleField.constraintSize.width;

    else if ( self->__repWidget.textPosition == SearchStuffTextOnly )
        widthConstant = self->__ssBackingTitleField.constraintSize.width;

    self->__widthConstraint = [ NSLayoutConstraint
        constraintWithItem: self
                 attribute: NSLayoutAttributeWidth
                 relatedBy: NSLayoutRelationEqual
                    toItem: nil
                 attribute: NSLayoutAttributeNotAnAttribute
                multiplier: 1.f
                  constant: widthConstant ];

    self->__heightConstraint = [ NSLayoutConstraint
        constraintWithItem: self
                 attribute: NSLayoutAttributeHeight
                 relatedBy: NSLayoutRelationEqual
                    toItem: nil
                 attribute: NSLayoutAttributeNotAnAttribute
                multiplier: 1.f
                  constant: MAX( self->__ssBackingButton.constraintSize.height
                               , self->__ssBackingTitleField.constraintSize.height
                               ) ];

    [ self->__sizeConstraints addObjectsFromArray: @[ self->__widthConstraint, self->__heightConstraint ] ];
    [ self addConstraints: self->__sizeConstraints ];
    }

@end // __SSWidget class

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