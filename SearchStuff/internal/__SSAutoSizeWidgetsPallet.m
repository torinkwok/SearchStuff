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

#import "__SSAutoSizeWidgetsPallet.h"
#import "__SSFixedWidgetsPallet.h"

// __SSAutoSizeWidgetsPallet class
@implementation __SSAutoSizeWidgetsPallet

#pragma mark - Initializations

- ( instancetype ) initWithHost: ( NSView* )_Host
                           type: ( __SSFixedWidgetsPalletType )_Type
    {
    if ( self = [ super initWithHost: _Host type: _Type ] )
        {
        self->__subPallet = [ [ __SSFixedWidgetsPallet alloc ] initWithHost: self type: __SSPalletTypeLeftAnchored ];

        NSLayoutConstraint* centerXConstraint = [ NSLayoutConstraint
            constraintWithItem: self->__subPallet
                     attribute: NSLayoutAttributeCenterX
                     relatedBy: NSLayoutRelationEqual
                        toItem: self->__subPallet.superview
                     attribute: NSLayoutAttributeCenterX
                    multiplier: 1.f
                      constant: 0.f ];

        NSView* subPallet = self->__subPallet;
        NSDictionary* viewsDict = NSDictionaryOfVariableBindings( subPallet );
        NSArray* verConstraints = [ NSLayoutConstraint
            constraintsWithVisualFormat: @"V:|[subPallet]|" options: 0 metrics: nil views: viewsDict ];

        [ self addConstraints: @[ centerXConstraint ] ];
        [ self addConstraints: verConstraints ];
        }

    return self;
    }

#pragma mark - Default Properties

+ ( CGFloat ) ssMinimumWidth
    {
    return 50.f;
    }

#pragma mark - Dynamic Properties

- ( NSArray <__kindof __SSWidget*>* ) ssWidgets
    {
    return [ self->__subPallet ssWidgets ];
    }

- ( void ) setSsWidgets: ( NSArray <__kindof __SSWidget*>* )_Widgets
    {
    [ self->__subPallet setSsWidgets: _Widgets ];
    }

@end // __SSAutoSizeWidgetsPallet class

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