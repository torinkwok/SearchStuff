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

#import "__SSButtonStdReload.h"
#import "__SSButton+__SSPrivate.h"

// __SSButtonStdReload class
@implementation __SSButtonStdReload
@end // __SSButtonStdReload class

// __SSButtonStdReload + __SSPrivate
@implementation __SSButtonStdReload ( __SSPrivate )

- ( instancetype ) __initWithFrame: ( NSRect )_FrameRect
                           ssWiget: ( SearchStuffWidget* )_Widget
    {
    if ( self = [ super __initWithFrame: _FrameRect ssWiget: _Widget ] )
        {
        self.ssImage = [ NSImage imageNamed: @"search-stuff-reload" ];
        self.ssAlternativeImage = [ NSImage imageNamed: @"search-stuff-reload-highlighted" ];
        }

    return self;
    }

@end // __SSButtonStdReload + __SSPrivate

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