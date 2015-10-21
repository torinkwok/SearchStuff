/*=============================================================================┐
|             _  _  _       _                                                  |  
|            (_)(_)(_)     | |                            _                    |██
|             _  _  _ _____| | ____ ___  ____  _____    _| |_ ___              |██
|            | || || | ___ | |/ ___) _ \|    \| ___ |  (_   _) _ \             |██
|            | || || | ____| ( (__| |_| | | | | ____|    | || |_| |            |██
|             \_____/|_____)\_)____)___/|_|_|_|_____)     \__)___/             |██
|                                                                              |██
|      ______                        _      ______               ___    ___    |██
|     / _____)                      | |    / _____) _           / __)  / __)   |██
|    ( (____  _____ _____  ____ ____| |__ ( (____ _| |_ _   _ _| |__ _| |__    |██
|     \____ \| ___ (____ |/ ___) ___)  _ \ \____ (_   _) | | (_   __|_   __)   |██
|     _____) ) ____/ ___ | |  ( (___| | | |_____) )| |_| |_| | | |    | |      |██
|    (______/|_____)_____|_|   \____)_| |_(______/  \__)____/  |_|    |_|      |██
|                                                                              |██
|                                                                              |██
|                         Copyright (c) 2015 Tong Kuo                          |██
|                                                                              |██
|                             ALL RIGHTS RESERVED.                             |██
|                                                                              |██
└==============================================================================┘██
  ████████████████████████████████████████████████████████████████████████████████
  ██████████████████████████████████████████████████████████████████████████████*/

#import "SearchStuffToolbarItem.h"
#import "SearchStuffWidget.h"

#import "__SSSearchStuffBar.h"

// Private Interfaces
@interface SearchStuffToolbarItem()
- ( void ) __init;
@end // Private Interfaces

// SearchStuffToolbarItem class
@implementation SearchStuffToolbarItem
    {
@private
    __SSSearchStuffBar* __searchBar;
    }

#pragma mark - Initializations

- ( instancetype ) initWithItemIdentifier: ( NSString* )_ItemIdentifier
    {
    if ( self = [ super initWithItemIdentifier: _ItemIdentifier ] )
        [ self __init ];

    return self;
    }

#pragma mark - Manipulating Widgets

- ( void ) reload
    {
    [ self->__searchBar reload ];
    }

#pragma mark - Private Interfaces

- ( void ) __init
    {
    self->__searchBar = [ [ __SSSearchStuffBar alloc ] initWithFrame: NSMakeRect( 0, 0, 0, 0 ) ];
    [ self->__searchBar setHostingSSToolbarItem: self ];

    [ self setView: self->__searchBar ];

    CGFloat stdHeight = 25.f;
    [ self setMinSize: NSMakeSize( 200.f, stdHeight ) ];

    NSRect screenFrame = [ NSScreen mainScreen ].frame;
    CGFloat maxWidth = floor( NSWidth( screenFrame ) / 2 );
    [ self setMaxSize: NSMakeSize( maxWidth, stdHeight ) ];
    }

@end // SearchStuffToolbarItem class

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