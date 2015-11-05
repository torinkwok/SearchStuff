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

#import "__SSTitleWidgetsPallet.h"
#import "__SSFixedWidgetsPallet.h"

// __SSTitleWidgetsPallet class
@implementation __SSTitleWidgetsPallet
    {
@protected
    NSTextField* __toolTipField;
    }

#pragma mark - Initializations

- ( instancetype ) initWithHost: ( NSView* )_Host
                           type: ( __SSFixedWidgetsPalletType )_Type
    {
    if ( self = [ super initWithHost: _Host type: _Type ] )
        {
        self->__toolTipField = [ [ NSTextField alloc ] initWithFrame: NSZeroRect ];
        self->__toolTipField.translatesAutoresizingMaskIntoConstraints = NO;

        self->__toolTipField.textColor = [ [ NSColor blackColor ] colorWithAlphaComponent: .8f ];
        self->__toolTipField.selectable = NO;
        self->__toolTipField.editable = NO;
        self->__toolTipField.drawsBackground = NO;
        self->__toolTipField.bordered = NO;

        self->__toolTipField.cell.usesSingleLineMode = YES;
        self->__toolTipField.cell.alignment = NSCenterTextAlignment;
        self->__toolTipField.cell.lineBreakMode = NSLineBreakByTruncatingTail;
        }

    return self;
    }

#pragma mark - Tool Tip

- ( void ) showToolTip: ( NSString* )_ToolTip
    {
    [ self->__toolTipField setStringValue: _ToolTip ?: @"" ];

    if ( self->__toolTipField.superview != self )
        {
        [ self addSubview: self->__toolTipField ];

        NSMutableArray* toolTipFieldConstraints = [ NSMutableArray array ];

        NSView* toolTipField = self->__toolTipField;
        NSDictionary* viewsDict = NSDictionaryOfVariableBindings( toolTipField );

        NSLayoutConstraint* centerYConstraint = [ NSLayoutConstraint
            constraintWithItem: self->__toolTipField
                     attribute: NSLayoutAttributeCenterY
                     relatedBy: NSLayoutRelationEqual
                        toItem: self
                     attribute: NSLayoutAttributeCenterY
                    multiplier: 1.f
                      constant: -.5f ];

        NSArray* widthConstraints = [ NSLayoutConstraint
            constraintsWithVisualFormat: @"H:|[toolTipField]|"
                                options: 0
                                metrics: nil
                                  views: viewsDict ];

        [ toolTipFieldConstraints addObject: centerYConstraint ];
        [ toolTipFieldConstraints addObjectsFromArray: widthConstraints ];

        [ self addConstraints: toolTipFieldConstraints ];
        }

    [ self->__toolTipField setHidden: NO ];
    [ self->__subPallet setHidden: YES ];
    }
    
- ( void ) hideToolTip
    {
    [ self->__toolTipField setStringValue: @"" ];

    [ self->__toolTipField setHidden: YES ];
    [ self->__subPallet setHidden: NO ];
    }

@end // __SSTitleWidgetsPallet class

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