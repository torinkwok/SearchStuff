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

#import "SearchStuffWidget.h"

// __SSWidget class
@implementation __SSWidget
    {
@protected
    __SSWidgetBackingButton* __ssBackingButton;
    __SSWidgetBackingTitleField* __ssBackingTitleField;

    NSLayoutConstraint __weak* __widthConstraint;
    NSLayoutConstraint __weak* __heightConstraint;
    NSArray __strong* __sizeConstraints;

    NSArray __strong* __backingButtonConstraints;
    }

#pragma mrak - Initilizations

- ( instancetype ) initWithRepWidget: ( SearchStuffWidget* )_RepWidget;
    {
    if ( !_RepWidget )
        return nil;

    if ( self = [ super initWithFrame: NSZeroRect ] )
        {
        self.repWidget = _RepWidget;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        }

    return self;
    }

#pragma mark - Dynamic Properties

- ( SearchStuffWidget* ) repWidget
    {
    return self->__repWidget;
    }

- ( void ) setRepWidget: ( SearchStuffWidget* )_RepWidget
    {
    self->__repWidget = _RepWidget;

    [ self->__ssBackingButton removeFromSuperview ];
    self->__ssBackingButton = nil;
    self->__ssBackingButton = [ __SSWidgetBackingButton ssWidgetBackingButtonWithRepWidget: self->__repWidget ];

    [ self addSubview: self->__ssBackingButton ];

    if ( self->__repWidget.title.length > 0 )
        {
        [ self->__ssBackingTitleField removeFromSuperview ];
        self->__ssBackingTitleField = nil;
        self->__ssBackingTitleField = [ [ __SSWidgetBackingTitleField alloc ] initWithRepWidget: self->__repWidget ];
        [ self addSubview: self->__ssBackingTitleField ];
        }

    self->__widthConstraint = [ NSLayoutConstraint
        constraintWithItem: self
                 attribute: NSLayoutAttributeWidth
                 relatedBy: NSLayoutRelationEqual
                    toItem: nil
                 attribute: NSLayoutAttributeNotAnAttribute
                multiplier: 1.f
                  constant: self->__ssBackingTitleField ? self->__ssBackingButton.ssSize.width + 3.f + self->__ssBackingTitleField.constraintWidth
                                                        : self->__ssBackingButton.ssSize.width ];

    self->__heightConstraint = [ NSLayoutConstraint
        constraintWithItem: self
                 attribute: NSLayoutAttributeHeight
                 relatedBy: NSLayoutRelationEqual
                    toItem: nil
                 attribute: NSLayoutAttributeNotAnAttribute
                multiplier: 1.f
                  constant: MAX( self->__ssBackingButton.ssSize.height, self->__ssBackingTitleField.constraintHeight ) ];

    if ( self->__sizeConstraints.count > 0 )
        [ self removeConstraints: self->__sizeConstraints ];

    self->__sizeConstraints = @[ self->__widthConstraint, self->__heightConstraint ];
    [ self addConstraints: self->__sizeConstraints ];

    NSView* backingButton = self->__ssBackingButton;
    NSView* backingTitleField = self->__ssBackingTitleField;
    NSMutableDictionary* viewsDict = [ NSDictionaryOfVariableBindings( backingButton ) mutableCopy ];

    if ( backingTitleField )
        {
        [ viewsDict addEntriesFromDictionary: NSDictionaryOfVariableBindings( backingTitleField ) ];

        NSArray <__kindof NSLayoutConstraint*>* verBackingTitleFieldConstraints =
            [ NSLayoutConstraint constraintsWithVisualFormat: @"V:|[backingTitleField]|"
                                                     options: 0
                                                     metrics: nil
                                                       views: viewsDict ];

        if ( verBackingTitleFieldConstraints.count > 0 )
            [ self addConstraints: verBackingTitleFieldConstraints ];
        }

    NSArray <__kindof NSLayoutConstraint*>* horBackingButtonConstraints =
        [ NSLayoutConstraint constraintsWithVisualFormat: self->__ssBackingTitleField ? @"H:|[backingButton]-(==3)-[backingTitleField]|"
                                                                                      : @"H:|[backingButton]|"
                                                 options: 0
                                                 metrics: nil
                                                   views: viewsDict ];

    NSArray <__kindof NSLayoutConstraint*>* verBackingButtonConstraints =
        [ NSLayoutConstraint constraintsWithVisualFormat: @"V:|[backingButton]-(>=0)-|"
                                                 options: 0
                                                 metrics: nil
                                                   views: viewsDict ];
    if ( self->__backingButtonConstraints.count > 0 )
        [ self removeConstraints: self->__backingButtonConstraints ];

    self->__backingButtonConstraints = [ horBackingButtonConstraints arrayByAddingObjectsFromArray: verBackingButtonConstraints ];
    [ self addConstraints: self->__backingButtonConstraints ];
    }

- ( CGFloat ) constraintWidth
    {
    return self->__widthConstraint.constant;
    }

- ( CGFloat ) constraintHeight
    {
    return self->__heightConstraint.constant;
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