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

#import "__SSWidgetsPallet.h"
#import "__SSBar.h"
#import "__SSWidgetsPallet.h"
#import "__SSConstants.h"

// __SSWidgetsPallet class
@implementation __SSWidgetsPallet

@dynamic ssHostingBar;
@dynamic ssType;

#pragma mark - Initializations

- ( instancetype ) initWithHostingBar: ( __SSBar* )_HostingBar
                                 type: ( __SSFixedWidgetsPalletType )_Type
    {
    if ( !_HostingBar )
        return nil;

    if ( self = [ super initWithFrame: NSZeroRect ] )
        {
        [ self setWantsLayer: YES ];
        [ self.layer setDelegate: _HostingBar ];

        self->__hostingBar = _HostingBar;
        self->__ssType = _Type;
        [ self->__hostingBar addSubview: self ];

        if ( self->__ssType == __SSFixedWidgetsPalletTypeLeftAnchored
                || self->__ssType == __SSFixedWidgetsPalletTypeLeftFloat )
            self->__direction = __SSPalletDirectionLeft;
        else if ( self->__ssType == __SSFixedWidgetsPalletTypeRightAnchored
                    || self->__ssType == __SSFixedWidgetsPalletTypeRightFloat )
            self->__direction = __SSPalletDirectionRight;
        else
            self->__direction = __SSPalletDirectionCentral;

        self->__widthConstraint = [ NSLayoutConstraint
            constraintWithItem: self
                     attribute: NSLayoutAttributeWidth
                     relatedBy: ( _Type == __SSFixedWidgetsPalletTypeTitle ) ? NSLayoutRelationGreaterThanOrEqual
                                                                             : NSLayoutRelationEqual
                        toItem: nil
                     attribute: NSLayoutAttributeNotAnAttribute
                    multiplier: 0
                      constant: NSWidth( self.bounds ) ];
        [ self addConstraints: @[ self->__widthConstraint ] ];
        }

    return self;
    }

#pragma mark - Dynamic Properties

- ( __SSBar* ) ssHostingBar
    {
    return self->__hostingBar;
    }

- ( __SSFixedWidgetsPalletType ) ssType
    {
    return self->__ssType;
    }

@end // __SSWidgetsPallet class

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