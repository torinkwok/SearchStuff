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

#import "__SSFixedWidgetsPallet.h"
#import "__SSBar.h"
#import "__SSWidget.h"
#import "__SSConstants.h"

// Private Interfaces
@interface __SSFixedWidgetsPallet ()

@property ( assign, readwrite ) BOOL isFloat;
- ( void ) __cleanUpSSWidgetsConstraints;

@end // Private Interfaces

// __SSFixedWidgetsPallet class
@implementation __SSFixedWidgetsPallet

CGFloat kHorGap = 3.5f;
CGFloat kVerGap = 3.6f;

CGFloat kLeadingGap = 3.5;
CGFloat kTrailingGap = 3.5;

CGFloat kSpliterWidth = 1.f;

#pragma mark - Initializations

- ( instancetype ) initWithHost: ( NSView* )_Host
                           type: ( __SSFixedWidgetsPalletType )_Type
    {
    if ( self = [ super initWithHost: _Host type: _Type ] )
        {
        self.isFloat = ( self->__ssType == __SSPalletTypeLeftFloat || self->__ssType == __SSPalletTypeRightFloat );
        self.hidden = self.isFloat;

        self->__ssWidgetsConstraints = [ NSMutableArray array ];
        }

    return self;
    }

#pragma mark - Drawing

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];

    if ( self.isFloat && self.hasSeparator )
        {
        NSBezierPath* spliterPath = [ NSBezierPath bezierPath ];

        CGFloat x = ( self->__ssType == __SSPalletTypeLeftFloat ) ? kHorGap : ( NSWidth( self.bounds ) - kHorGap );

        [ spliterPath moveToPoint: NSMakePoint( x, 1.9f ) ];
        [ spliterPath lineToPoint: NSMakePoint( x, NSHeight( self.bounds ) - 3.6f ) ];

        [ spliterPath setLineWidth: kSpliterWidth ];

        [ [ [ NSColor grayColor ] colorWithAlphaComponent: .3f ] set ];
        [ spliterPath stroke ];
        }
    }

#pragma mark - Dynamic Properties

@dynamic hasSeparator;
@dynamic constraintWidth;

- ( NSArray <__kindof __SSWidget*>* ) ssWidgets
    {
    return self->__ssWidgets;
    }

- ( void ) setSsWidgets: ( NSArray <__kindof __SSWidget*>* )_Widgets
    {
    self->__ssWidgets = _Widgets;

    [ self __cleanUpSSWidgetsConstraints ];
    [ self setSubviews: _Widgets ];

    NSDictionary* metrics = @{ @"horGap" : @( kHorGap )
                             , @"verGap" : @( kVerGap )
                             };

    NSMutableDictionary* viewsDict = [ NSMutableDictionary dictionary ];
    for ( int _Index = 0; _Index < _Widgets.count; _Index++ )
        {
        NSString* viewName = [ @"widget" stringByAppendingString: @( _Index ).stringValue ];
        [ viewsDict addEntriesFromDictionary: @{ viewName : _Widgets[ _Index ] } ];
        }

    NSMutableString* horVisualFormat = [ NSMutableString stringWithString: @"H:|" ];

    NSMutableArray* horLayoutConstraints = [ NSMutableArray array ];
    NSMutableArray* verLayoutConstraints = [ NSMutableArray array ];

    NSString* headComponent = @"";
    NSString* bodyComponent = @"";
    NSString* tailComponent = @"";

    if ( self->__direction == __SSPalletDirectionLeft )
        {
        bodyComponent = @"-(==%@)-[%@]";
        tailComponent = @"-(>=0)-|";
        }
    else if ( self->__direction == __SSPalletDirectionRight )
        {
        headComponent = @"-(>=0)";
        bodyComponent = @"-[%@]-(==%@)";
        tailComponent = @"-|";
        }

    // Assembling the head component
    [ horVisualFormat appendString: headComponent ];

    NSArray* allViewNames = [ viewsDict allKeys ];

    // Assembling the body components
    for ( NSString* _ViewName in allViewNames )
        {
        NSUInteger index = [ allViewNames indexOfObject: _ViewName ];

        NSString* visualFormatBody = nil;
        switch ( self->__direction )
            {
            case __SSPalletDirectionLeft:
                {
                visualFormatBody = [ NSString stringWithFormat:
                      bodyComponent
                    , ( self.hasSeparator && ( index == 0 ) ) ? @( kHorGap * 3 ) : @"horGap"
                    , _ViewName
                    ];
                } break;

            case __SSPalletDirectionRight:
                {
                visualFormatBody = [ NSString stringWithFormat:
                      bodyComponent
                    , _ViewName
                    , ( self.hasSeparator && ( index == allViewNames.count - 1 ) ) ? @( kHorGap * 3 ) : @"horGap"
                    ];
                } break;

            default:;
            }

        [ horVisualFormat appendString: visualFormatBody ];
        }

    // Assembling the tail component
    [ horVisualFormat appendString: tailComponent ];

    [ horLayoutConstraints addObjectsFromArray:
        [ NSLayoutConstraint constraintsWithVisualFormat: horVisualFormat options: 0 metrics: metrics views: viewsDict ] ];

    for ( NSString* _ViewName in viewsDict )
        {
        NSView* view = viewsDict[ _ViewName ];
        NSLayoutConstraint* centerYConstraint = [ NSLayoutConstraint
            constraintWithItem: view
                     attribute: NSLayoutAttributeCenterY
                     relatedBy: NSLayoutRelationEqual
                        toItem: view.superview
                     attribute: NSLayoutAttributeCenterY
                    multiplier: 1.f
                      constant: .6f ];

        [ verLayoutConstraints addObject: centerYConstraint ];
        }

    [ self->__ssWidgetsConstraints addObjectsFromArray: horLayoutConstraints ];
    [ self->__ssWidgetsConstraints addObjectsFromArray: verLayoutConstraints ];
    [ self addConstraints: self->__ssWidgetsConstraints ];

    self->__widthConstraint.constant = [ self constraintWidth ];
    }

- ( BOOL ) hasSeparator
    {
    BOOL yesOrNo = NO;

    NSView* hostView = self.superview;
    if ( self.ssType == __SSPalletTypeLeftFloat )
        {
        if ( [ hostView isKindOfClass: [ __SSBar class ] ] )
            yesOrNo = ( ( __SSBar* )hostView ).hasLeftAnchoredWidgets;
        }
    else if ( self.ssType == __SSPalletTypeRightFloat )
        {
        if ( [ hostView isKindOfClass: [ __SSBar class ] ] )
            yesOrNo = ( ( __SSBar* )hostView ).hasRightAnchoredWidgets;
        }

    return self.isFloat && yesOrNo;
    }

- ( CGFloat ) constraintWidth
    {
    CGFloat finalWidth = kHorGap;

    for ( __SSWidget* _ssWidget in __ssWidgets )
        finalWidth += ( _ssWidget.constraintSize.width + kHorGap );

    if ( self.hasSeparator )
        finalWidth += kHorGap * 2 + kSpliterWidth;

    return finalWidth;
    }

#pragma mark - Private Interfaces

- ( void ) __cleanUpSSWidgetsConstraints
    {
    [ self removeConstraints: self->__ssWidgetsConstraints ];
    [ self->__ssWidgetsConstraints removeAllObjects ];
    }

@end // __SSFixedWidgetsPallet class

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