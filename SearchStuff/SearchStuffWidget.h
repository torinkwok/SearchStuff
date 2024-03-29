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

@import Cocoa;

// Standard Identifiers
NSString extern* const SearchStuffSearchWidgetIdentifier;
NSString extern* const SearchStuffReloadWidgetIdentifier;
NSString extern* const SearchStuffGreenLockWidgetIdentifier;
NSString extern* const SearchStuffGrayLockWidgetIdentifier;

// Text Position
typedef NS_ENUM( NSUInteger, SearchStuffWidgetTextPosition )
    { SearchStuffNoText                 = 0
    , SearchStuffTextDefault            = 1
    , SearchStuffTextOppositeToDefault  = 2
    , SearchStuffTextOnly               = 3
    };

// Widget Size
typedef NS_ENUM( NSUInteger, SearchStuffWidgetSize )
    { SearchStuffRegularWidgetSize  = 0
    , SearchStuffSmallWidgetSize    = 1
    , SearchStuffMiniWidgetSize     = 2
    };

// SearchStuffWidget class
@interface SearchStuffWidget : NSObject <NSCopying>

@property ( assign, readwrite ) SEL action;
@property ( weak, readwrite ) id target;

@property ( assign, readwrite ) SearchStuffWidgetSize widgetSize;

@property ( strong, readwrite ) NSImage* image;
@property ( strong, readwrite ) NSImage* alternativeImage;

@property ( strong, readwrite ) NSString* text;
@property ( assign, readwrite ) NSColor* textColor;
@property ( assign, readwrite ) SearchStuffWidgetTextPosition textPosition;

@property ( strong, readwrite ) NSString* toolTip;
@property ( strong, readonly ) NSString* identifier;

#pragma mark - Initializations

- ( instancetype ) initWithIdentifier: ( NSString* )_WidgetIdentifier;

@end // SearchStuffWidget class

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