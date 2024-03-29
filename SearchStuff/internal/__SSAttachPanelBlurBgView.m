/*=============================================================================┐
|             _  _  _       _                                                  |  
|            (_)(_)(_)     | |                            _                    |██
|             _  _  _ _____| | ____ ___  ____  _____    _| |_ ___              |██
|            | || || | ___ | |/ ___) _ \|    \| ___ |  (_   _) _ \             |██
|            | || || | ____| ( (__| |_| | | | | ____|    | || |_| |            |██
|             \_____/|_____)\_)____)___/|_|_|_|_____)     \__)___/             |██
|                                                                              |██
|                 ______                   _  _  _ _ _     _ _                 |██
|                (_____ \                 (_)(_)(_|_) |   (_) |                |██
|                 _____) )   _  ____ _____ _  _  _ _| |  _ _| |                |██
|                |  ____/ | | |/ ___) ___ | || || | | |_/ ) |_|                |██
|                | |    | |_| | |   | ____| || || | |  _ (| |_                 |██
|                |_|    |____/|_|   |_____)\_____/|_|_| \_)_|_|                |██
|                                                                              |██
|                                                                              |██
|                         Copyright (c) 2015 Tong Kuo                          |██
|                                                                              |██
|                             ALL RIGHTS RESERVED.                             |██
|                                                                              |██
└==============================================================================┘██
  ████████████████████████████████████████████████████████████████████████████████
  ██████████████████████████████████████████████████████████████████████████████*/

#import "__SSAttachPanelBlurBgView.h"

// __SSAttachPanelBlurBgView class
@implementation __SSAttachPanelBlurBgView
    {
@protected
    NSMutableArray __strong* __cachedContentViewConstraints;
    }

@dynamic userProvidedContentView;

- ( void ) setUserProvidedContentView: ( NSView* )_View
    {
    [ self setSubviews: @[] ];

    if ( !self->__cachedContentViewConstraints )
        self->__cachedContentViewConstraints = [ NSMutableArray array ];

    if ( self->__cachedContentViewConstraints.count > 0 )
        {
        [ self removeConstraints: self->__cachedContentViewConstraints ];
        [ self->__cachedContentViewConstraints removeAllObjects ];
        }

    if ( _View )
        {
        NSView* contentView = _View;
        [ contentView setTranslatesAutoresizingMaskIntoConstraints: NO ];
        [ self addSubview: contentView ];

        NSDictionary* viewsDict = NSDictionaryOfVariableBindings( contentView );

        NSArray* contentViewHorConstraints = [ NSLayoutConstraint
            constraintsWithVisualFormat: @"H:|[contentView]|"
                                options: 0
                                metrics: nil
                                  views: viewsDict ];

        NSArray* contentViewVerConstraints = [ NSLayoutConstraint
            constraintsWithVisualFormat: @"V:|[contentView]|"
                                options: 0
                                metrics: nil
                                  views: viewsDict ];

        [ self->__cachedContentViewConstraints addObjectsFromArray: contentViewHorConstraints ];
        [ self->__cachedContentViewConstraints addObjectsFromArray: contentViewVerConstraints ];

        [ self addConstraints: self->__cachedContentViewConstraints ];
        }
    }

- ( NSView* ) userProvidedContentView
    {
    return self.subviews[ 0 ];
    }

@end // __SSAttachPanelBlurBgView class

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