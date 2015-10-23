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
                                 type: ( __SSWidetsPalletType )_Type
    {
    if ( !_HostingBar )
        return nil;

    if ( self = [ super initWithFrame: NSZeroRect ] )
        {
        self->__hostingBar = _HostingBar;
        [ self->__hostingBar addSubview: self ];

        [ self setTranslatesAutoresizingMaskIntoConstraints: NO ];
        }

    return self;
    }

#pragma mark - Dynamic Properties

- ( NSArray <__kindof __SSWidget*>* ) sWidgets
    {
    return self.subviews;
    }

- ( void ) setSsWidgets: ( NSArray <__kindof __SSWidget*>* )_Widgets
    {
    [ self setSubviews: @[] ];

    CGFloat originX = 5.f;
    CGFloat originY = 3.6f;

    for ( __SSWidget* _Widget in _Widgets )
        {
        [ _Widget setFrameOrigin: NSMakePoint( originX, originY ) ];
        [ self addSubview: _Widget ];

        originX += ( 15.f + 3.f );
        }
    }

#pragma mark - Dynamic Properties

- ( __SSBar* ) ssHostingBar
    {
    return self->__hostingBar;
    }

//- ( NSArray

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