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

// __SSWidgetsPallet class
@implementation __SSWidgetsPallet

@dynamic ssHostingBar;
@dynamic ssType;
@dynamic ssWidgets;

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];

    #if 0 // DEBUG
    srand( ( unsigned int )time( NULL ) );

    CGFloat r = ( CGFloat )( ( random() % 255 ) / 255.f );
    CGFloat g = ( CGFloat )( ( random() % 255 ) / 255.f );
    CGFloat b = ( CGFloat )( ( random() % 255 ) / 255.f );

    NSColor* color = [ NSColor colorWithSRGBRed: r green: g blue: b alpha: 1.f ];
    [ color set ];
    NSRectFill( _DirtyRect );
    #endif // DEBUG
    }

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

        [ self setTranslatesAutoresizingMaskIntoConstraints: NO ];
        }

    return self;
    }

#pragma mark - Dynamic Properties

- ( NSArray <__kindof __SSWidget*>* ) ssWidgets
    {
    return self.subviews;
    }

- ( void ) setSsWidgets: ( NSArray <__kindof __SSWidget*>* )_Widgets
    {
    [ self setSubviews: _Widgets ];

    NSDictionary* metrics = @{ @"horGap" : @( 3.5f )
                             , @"verGap" : @( 3.3f )
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
        case __SSWidgetsPalletTypeLeftAnchored:
        case __SSWidgetsPalletTypeLeftFloat:
            {
            for ( NSString* _ViewName in viewsDict )
                [ horVisualFormat appendString: [ NSString stringWithFormat: @"-(==horGap)-[%@(==%@)]", _ViewName, @( NSWidth( [ viewsDict[ _ViewName ] frame ] ) ) ] ];

            [ horVisualFormat appendString: @"-(>=0)-|" ];

            [ horLayoutConstraints addObjectsFromArray:
                [ NSLayoutConstraint constraintsWithVisualFormat: horVisualFormat options: 0 metrics: metrics views: viewsDict ] ];
            } break;

        case __SSWidgetsPalletTypeRightAnchored:
        case __SSWidgetsPalletTypeRightFloat:
            {
            [ horVisualFormat appendString: @"-(>=0)" ];

            for ( NSString* _ViewName in viewsDict )
                [ horVisualFormat appendString: [ NSString stringWithFormat: @"-[%@(==%@)]-(==horGap)", _ViewName, @( NSWidth( [ viewsDict[ _ViewName ] frame ] ) ) ] ];

            [ horVisualFormat appendString: @"-|" ];

            [ horLayoutConstraints addObjectsFromArray:
                [ NSLayoutConstraint constraintsWithVisualFormat: horVisualFormat options: 0 metrics: metrics views: viewsDict ] ];
            } break;

        case __SSWidgetsPalletTypeTitle:
            {

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

    [ self addConstraints: horLayoutConstraints ];
    [ self addConstraints: verLayoutConstraints ];
    }

- ( __SSBar* ) ssHostingBar
    {
    return self->__hostingBar;
    }

- ( __SSWidgetsPalletType ) ssType
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