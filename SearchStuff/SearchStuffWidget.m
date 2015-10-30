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

#import "SearchStuffWidget.h"
#import "SearchStuffWidget+__SSPrivate.h"

// Standard Identifiers
NSString* const SearchStuffSearchWidgetIdentifier       = @"__ssStdSearchWidgetIdentifier";
NSString* const SearchStuffReloadWidgetIdentifier       = @"__ssStdReloadWidgetIdentifier";
NSString* const SearchStuffGreenLockWidgetIdentifier    = @"__ssStdGreenLockWidgetIdentifier";
NSString* const SearchStuffGrayLockWidgetIdentifier     = @"__ssStdGrayLockWidgetIdentifier";

NSArray <__kindof NSString*> static* sStandardIdentifiers;

// Private Interface
@interface SearchStuffWidget ()
@property ( strong, readwrite ) NSString* identifier;
@end // Private Interface

// SearchStuffWidget 
@implementation SearchStuffWidget
    {
@private
    BOOL __isStd;
    }

#pragma mark - Initializations

- ( instancetype ) initWithIdentifier: ( NSString* )_WidgetIdentifier
    {
    if ( self = [ super init ] )
        {
        self.textPosition = SearchStuffNoText;
        self.identifier = _WidgetIdentifier;
        self->__isStd = [ [ [ self class ] __stdIdentifiers ] containsObject: self.identifier ];
        }

    return self;
    }

#pragma mark - Copying

- ( instancetype ) copyWithZone: ( NSZone* )_Zone
    {
    SearchStuffWidget* copy = [ [ [ self class ] alloc ] initWithIdentifier: self.identifier ];

    if ( copy )
        {
        copy.action = self.action;
        copy.target = self.target;

        copy.image = [ self.image copy ];
        copy.alternativeImage = [ self.alternativeImage copy ];

        copy.text = self.text;
        copy.textPosition = self.textPosition;

        copy.toolTip = self.toolTip;
        copy.identifier = self.identifier;
        }

    return copy;
    }

@end // SearchStuffWidget class

// SearchStuffWidget + __SSPrivate
@implementation SearchStuffWidget ( __SSPrivate )

NSArray <__kindof NSString*> static* sStdIds;
+ ( NSArray <__kindof NSString*>* ) __stdIdentifiers
    {
    dispatch_once_t static onceToken;

    dispatch_once( &onceToken
                 , ( dispatch_block_t )^( void )
                    {
                    sStdIds = @[ SearchStuffSearchWidgetIdentifier
                               , SearchStuffReloadWidgetIdentifier
                               , SearchStuffGreenLockWidgetIdentifier
                               , SearchStuffGrayLockWidgetIdentifier
                               ];
                    } );

    return sStdIds;
    }

@dynamic __isStd;
- ( BOOL ) __isStd
    {
    return self->__isStd;
    }

@end // SearchStuffWidget + __SSPrivate

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