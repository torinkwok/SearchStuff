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
#import "__SSWidget.h"
#import "__SSConstants.h"

typedef NS_ENUM( NSUInteger, __SSPalletDirection )
    { __SSPalletDirectionLeft       = 0
    , __SSPalletDirectionRight      = 1
    , __SSPalletDirectionCentral    = 2
    };

// Private Interfaces
@interface __SSWidgetsPallet ()

@property ( assign, readwrite ) BOOL isFloat;

@property ( assign, readonly ) __SSPalletDirection __direction;
- ( void ) __cleanUpSSWidgetsConstraints;

@end // Private Interfaces

// __SSWidgetsPallet class
@implementation __SSWidgetsPallet
    {
@protected
    __SSPalletDirection __direction;
    }

@dynamic ssHostingBar;
@dynamic ssType;
@dynamic ssWidgets;

@dynamic ssConstraintWidth;

CGFloat kHorGap = 3.5f;
CGFloat kVerGap = 3.6f;

CGFloat kLeadingGap = 3.5;
CGFloat kTrailingGap = 3.5;

CGFloat kSpliterWidth = 1.f;

#pragma mark - Initializations

- ( instancetype ) initWithHostingBar: ( __SSBar* )_HostingBar
                                 type: ( __SSWidgetsPalletType )_Type
    {
    if ( !_HostingBar )
        return nil;

    if ( self = [ super initWithFrame: NSZeroRect ] )
        {
        self->__hostingBar = _HostingBar;
        self->__ssType = _Type;
        [ self->__hostingBar addSubview: self ];

        self.isFloat = ( self->__ssType == __SSWidgetsPalletTypeLeftFloat
                            || self->__ssType == __SSWidgetsPalletTypeRightFloat );

        switch ( self->__ssType )
            {
            case __SSWidgetsPalletTypeLeftAnchored:
            case __SSWidgetsPalletTypeLeftFloat:
                {
                self->__direction = __SSPalletDirectionLeft;
                } break;

            case __SSWidgetsPalletTypeRightAnchored:
            case __SSWidgetsPalletTypeRightFloat:
                {
                self->__direction = __SSPalletDirectionRight;
                } break;

            default:
                {
                self->__direction = __SSPalletDirectionCentral;
                } break;
            }

        self->__widthConstraint = [ NSLayoutConstraint
            constraintWithItem: self
                     attribute: NSLayoutAttributeWidth
                     relatedBy: ( _Type == __SSWidgetsPalletTypeTitle ) ? NSLayoutRelationGreaterThanOrEqual
                                                                        : NSLayoutRelationEqual
                        toItem: nil
                     attribute: NSLayoutAttributeNotAnAttribute
                    multiplier: 0
                      constant: ( _Type == __SSWidgetsPalletTypeTitle ) ? 50.f
                                                                        : NSWidth( self.bounds ) ];

        [ self addConstraints: @[ self->__widthConstraint ] ];

        self->__ssWidgetsConstraints = [ NSMutableArray array ];

        [ self setTranslatesAutoresizingMaskIntoConstraints: NO ];
        }

    return self;
    }

#pragma mark - Drawing

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];

    #if 1 // DEBUG
    srand( ( unsigned int )time( NULL ) );

    CGFloat r = ( CGFloat )( ( random() % 255 ) / 255.f );
    CGFloat g = ( CGFloat )( ( random() % 255 ) / 255.f );
    CGFloat b = ( CGFloat )( ( random() % 255 ) / 255.f );

    NSColor* color = [ NSColor colorWithSRGBRed: r green: g blue: b alpha: 1.f ];
    [ color set ];
    NSRectFill( _DirtyRect );
    #endif // DEBUG

    if ( self.isFloat )
        {
        NSBezierPath* spliterPath = [ NSBezierPath bezierPath ];

        CGFloat x = ( self->__ssType == __SSWidgetsPalletTypeLeftFloat ) ? kHorGap : ( NSWidth( self.bounds ) - kHorGap );

        [ spliterPath moveToPoint: NSMakePoint( x, 4.5f ) ];
        [ spliterPath lineToPoint: NSMakePoint( x, NSHeight( self.bounds ) - 4.5f ) ];

        [ spliterPath setLineWidth: kSpliterWidth ];

        [ [ [ NSColor grayColor ] colorWithAlphaComponent: .3f ] set ];
        [ spliterPath stroke ];
        }
    }

#pragma mark - Dynamic Properties

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
        [ _Widgets[ _Index ] setTranslatesAutoresizingMaskIntoConstraints: NO ];

        NSString* viewName = [ @"widget" stringByAppendingString: @( _Index ).stringValue ];
        [ viewsDict addEntriesFromDictionary: @{ viewName : _Widgets[ _Index ] } ];
        }

    NSMutableString* horVisualFormat = [ NSMutableString stringWithString: @"H:|" ];

    NSMutableArray* horLayoutConstraints = [ NSMutableArray array ];
    NSMutableArray* verLayoutConstraints = [ NSMutableArray array ];
    switch ( self->__ssType )
        {
        case __SSWidgetsPalletTypeTitle:
            {
            // TODO:
            } break;

        default:
            {
            NSString* headComponent = @"";
            NSString* bodyComponent = @"";
            NSString* tailComponent = @"";

            if ( self.__direction == __SSPalletDirectionLeft )
                {
                bodyComponent = @"-(==%@)-[%@(==%@)]";
                tailComponent = @"-(>=0)-|";
                }
            else if ( self.__direction == __SSPalletDirectionRight )
                {
                headComponent = @"-(>=0)";
                bodyComponent = @"-[%@(==%@)]-(==%@)";
                tailComponent = @"-|";
                }

            // Assembling the head component
            [ horVisualFormat appendString: headComponent ];

            NSArray* allViewNames = [ viewsDict allKeys ];

            // Assembling the body components
            for ( NSString* _ViewName in allViewNames )
                {
                NSUInteger index = [ allViewNames indexOfObject: _ViewName ];
                if ( self.__direction == __SSPalletDirectionLeft )
                    [ horVisualFormat appendString: [ NSString stringWithFormat: bodyComponent
                                                                               , ( self.isFloat && ( index == 0 ) ) ? @( kHorGap * 3 ) : @"horGap"
                                                                               , _ViewName
                                                                               , @( NSWidth( [ viewsDict[ _ViewName ] frame ] ) )
                                                                               ] ];
                else if ( self.__direction == __SSPalletDirectionRight )
                    [ horVisualFormat appendString: [ NSString stringWithFormat: bodyComponent
                                                                               , _ViewName
                                                                               , @( NSWidth( [ viewsDict[ _ViewName ] frame ] ) )
                                                                               , ( self.isFloat && ( index == allViewNames.count - 1 ) ) ? @( kHorGap * 3 ) : @"horGap"
                                                                               ] ];
                }

            // Assembling the tail component
            [ horVisualFormat appendString: tailComponent ];

            [ horLayoutConstraints addObjectsFromArray:
                [ NSLayoutConstraint constraintsWithVisualFormat: horVisualFormat options: 0 metrics: metrics views: viewsDict ] ];
            } break;
        }

    for ( NSString* _ViewName in viewsDict )
        {
        NSArray* constraints = [ NSLayoutConstraint
            constraintsWithVisualFormat: [ NSString stringWithFormat: @"V:|-(==verGap)-[%@(==%@)]-(>=0)-|", _ViewName, @( NSHeight( [ viewsDict[ _ViewName ] frame ] ) ) ]
                                options: 0
                                metrics: metrics
                                  views: @{ _ViewName : viewsDict[ _ViewName ] } ];

        [ verLayoutConstraints addObjectsFromArray: constraints ];
        }

    [ self->__ssWidgetsConstraints addObjectsFromArray: horLayoutConstraints ];
    [ self->__ssWidgetsConstraints addObjectsFromArray: verLayoutConstraints ];
    [ self addConstraints: self->__ssWidgetsConstraints ];

    self->__widthConstraint.constant = [ self ssConstraintWidth ];
    }

- ( __SSBar* ) ssHostingBar
    {
    return self->__hostingBar;
    }

- ( __SSWidgetsPalletType ) ssType
    {
    return self->__ssType;
    }

- ( CGFloat ) ssConstraintWidth
    {
    CGFloat finalWidth = 0.f;

    if ( self.__direction == __SSPalletDirectionCentral )
        finalWidth = NSWidth( self.bounds );
    else
        {
        finalWidth = self->__ssWidgets.count * ( SS_WIDGETS_FIX_WIDTH + kHorGap ) + kHorGap;

        if ( self.isFloat )
            finalWidth += kHorGap * 2 + kSpliterWidth;
        }

    return finalWidth;
    }

#pragma mark Private Interfaces

@dynamic __direction;
- ( __SSPalletDirection ) __direction
    {
    return self->__direction;
    }

- ( void ) __cleanUpSSWidgetsConstraints
    {
    [ self removeConstraints: self->__ssWidgetsConstraints ];
    [ self->__ssWidgetsConstraints removeAllObjects ];
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