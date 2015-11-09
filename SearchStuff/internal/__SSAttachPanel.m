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

#import "__SSAttachPanel.h"
#import "__SSAttachPanelBlurBgView.h"

// Private Interfaces
@interface __SSAttachPanel ()

@property ( weak ) IBOutlet NSLayoutConstraint* __widthConstraint;
@property ( weak ) IBOutlet NSLayoutConstraint* __heightConstraint;

- ( NSImage* ) _maskImageWithCornerRadius: ( CGFloat )_CornerRadius;

@end // Private Interfaces

// __SSAttachPanel class
@implementation __SSAttachPanel

#pragma mark - Initializations

- ( void ) awakeFromNib
    {
    self.opaque = NO;
    self.backgroundColor = [ NSColor clearColor ];
    self.excludedFromWindowsMenu = YES;

    NSImage* maskImage = [ self _maskImageWithCornerRadius: 5.f ];
    self.panelBlurBackgroundView.maskImage = maskImage;

    self.cornerMask = maskImage;
    }

#pragma mark Properties

@dynamic constraintSize;
@dynamic userProvidedContentView;

- ( NSSize ) constraintSize
    {
    return NSMakeSize( self.__widthConstraint.constant, self.__heightConstraint.constant );
    }

- ( void ) setUserProvidedContentView: ( NSView* )_View
    {
    [ self.panelBlurBackgroundView setUserProvidedContentView: _View ];
    }

- ( NSView* ) userProvidedContentView
    {
    return self.panelBlurBackgroundView.userProvidedContentView;
    }

#pragma mark - Hack

- ( NSImage* ) _cornerMask
    {
    return self.cornerMask;
    }

#pragma mark - Private Interfaces

- ( NSImage* ) _maskImageWithCornerRadius: ( CGFloat )_CornerRadius
    {
    CGFloat edgeLength = 2.f * _CornerRadius + 1.f;
    NSImage* maskImage = [ NSImage imageWithSize: NSMakeSize( edgeLength, edgeLength )
                                         flipped: NO
                                  drawingHandler:
        ^BOOL( NSRect _DstRect )
            {
            NSBezierPath* bezierPath = [ NSBezierPath bezierPathWithRoundedRect: _DstRect xRadius: _CornerRadius yRadius: _CornerRadius ];
            [ [ NSColor whiteColor ] set ];
            [ bezierPath fill ];

            return YES;
            } ];

    [ maskImage setCapInsets: NSEdgeInsetsMake( _CornerRadius, _CornerRadius, _CornerRadius, _CornerRadius ) ];
    return maskImage;
    }

@end // __SSAttachPanel class

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