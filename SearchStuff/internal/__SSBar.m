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

#import "__SSBar.h"

#import "__SSBackingCell.h"
#import "__SSInputField.h"
#import "__SSWidget.h"
#import "SearchStuffWidget+__SSPrivate.h"

#import "SearchStuffWidget.h"
#import "SearchStuffToolbarItem.h"
#import "SearchStuffWidget+__SSPrivate.h"

typedef NS_ENUM( NSUInteger, __SSBarButtonState )
    { __SSBarButtonStateLeftAnchored    = 0
    , __SSBarButtonStateRightAnchored   = 1
    , __SSBarButtonStateLeftFloat       = 2
    , __SSBarButtonStateRightFloat      = 3
    };

// Private Interfaces
@interface __SSBar()

@property ( strong ) __SSBackingCell* __backingCell;
@property ( strong ) __SSInputField* __inputField;

@property ( strong ) NSArray <__kindof NSLayoutConstraint*>* __inputFieldConstraints;

@property ( assign ) BOOL __isInputting;

- ( void ) __init;

@end // Private Interfaces

// __SSBar class
@implementation __SSBar

@synthesize __backingCell;
@synthesize __inputField;
@dynamic __isInputting;

#pragma mark - Initializations

- ( instancetype ) initWithCoder: ( NSCoder* )_Coder
    {
    if ( self = [ super initWithCoder: _Coder ] )
        [ self __init ];

    return self;
    }

- ( instancetype ) initWithFrame: ( NSRect )_FrameRect
    {
    if ( self = [ super initWithFrame: _FrameRect ] )
        [ self __init ];

    return self;
    }

#pragma mark - Manipulating Widgets

- ( void ) reload
    {
    SearchStuffToolbarItem* tlbItem = self.hostingSSToolbarItem;
    id <SearchStuffDelegate> tlbItemDel = self.hostingSSToolbarItem.delegate;

    // Manipulation of left hand side anchored widgets
    if ( [ tlbItemDel respondsToSelector: @selector( ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers ) ] )
        {
        NSArray <__kindof NSString*>* lhsAnchoredWidgetIdentifiers =
            [ tlbItemDel ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers ];

        NSMutableArray* lhsAnchoredWidgets =
            [ NSMutableArray arrayWithCapacity: lhsAnchoredWidgetIdentifiers.count ];

        if ( lhsAnchoredWidgetIdentifiers.count > 0 )
            {
            for ( NSString* _WidgetIdentifier in lhsAnchoredWidgetIdentifiers )
                {
                if ( [ [ [ SearchStuffWidget class ] __stdIdentifiers ] containsObject: _WidgetIdentifier ] )
                    [ lhsAnchoredWidgets addObject: [ [ SearchStuffWidget alloc ] initWithIdentifier: _WidgetIdentifier ] ];
                else
                    {
                    if ( [ tlbItemDel respondsToSelector: @selector( ssToolbarItem:widgetForWidgetIdentifier: ) ] )
                        {
                        SearchStuffWidget* ssWidget = [ tlbItemDel ssToolbarItem: tlbItem widgetForWidgetIdentifier: _WidgetIdentifier ];
                        [ lhsAnchoredWidgets addObject: ssWidget ];
                        }
                    }
                }

            NSMutableArray* ssButtons = [ NSMutableArray arrayWithCapacity: lhsAnchoredWidgetIdentifiers.count ];
            for ( SearchStuffWidget* _Widget in lhsAnchoredWidgets )
                {
                __SSWidget* ssButton = [ __SSWidget ssButtonWithSSWidget: _Widget ];
                [ ssButtons addObject: ssButton ];
                [ self __arrangeSSButtons: ssButtons state: __SSBarButtonStateLeftAnchored ];
                }
            }
        }
    }

- ( void ) __arrangeSSButtons: ( NSArray <__SSWidget*>* )_Buttons
                        state: ( __SSBarButtonState )_ButtonState
    {
    CGFloat originX = 5.f;
    CGFloat originY = 5.f;

    for ( __SSWidget* _Button in _Buttons )
        {
        [ _Button setFrameOrigin: NSMakePoint( originX, originY ) ];
        [ self addSubview: _Button ];

        originX += ( 15.f + 3.f );
        }
    }

#pragma mark - Drawing

- ( void ) drawRect: ( NSRect )_DirtyRect
    {
    [ super drawRect: _DirtyRect ];
    [ self.__backingCell drawWithFrame: self.bounds inView: self ];
    }

#pragma mark - Events

- ( void ) mouseDown: ( NSEvent* )_Event
    {
    [ super mouseDown: _Event ];

    NSTextField* inputField = self.__inputField;
    [ inputField setFrame: self.bounds ];

    [ self addSubview: inputField ];

    if ( !self.__inputFieldConstraints )
        {
        NSDictionary <NSString*, NSView*>* viewsDict = NSDictionaryOfVariableBindings( inputField );
        NSDictionary <NSString*, NSNumber*>* metricsDict = @{ @"leadingSpace" : @2.f, @"trailingSpace" : @1.f };

        NSArray <__kindof NSLayoutConstraint*>* horConstraints = [ NSLayoutConstraint
            constraintsWithVisualFormat: @"H:|-leadingSpace-[inputField(>=0)]-trailingSpace-|" options: 0 metrics: metricsDict views: viewsDict ];

        NSArray <__kindof NSLayoutConstraint*>* verConstraints = [ NSLayoutConstraint
            constraintsWithVisualFormat: @"V:|[inputField(>=0)]|" options: 0 metrics: nil views: viewsDict ];

        self.__inputFieldConstraints = [ horConstraints arrayByAddingObjectsFromArray: verConstraints ];
        }

    [ self addConstraints: self.__inputFieldConstraints ];
    [ self.window makeFirstResponder: inputField ];

    self.__isInputting = YES;
    }

#pragma mark - Conforms to <NSTextFieldDelegate>

- ( void ) controlTextDidEndEditing: ( NSNotification* )_Notif
    {
    [ self.__inputField removeFromSuperview ];
    [ self removeConstraints: self.__inputFieldConstraints ];

    self.__isInputting = NO;

    // TODO: Waiting for animations
    }

#pragma mark - Dynamic Properties

- ( void ) set__isInputting: ( BOOL )_Flag
    {
    self->__isInputting = _Flag;
    }

- ( BOOL ) __isInputting
    {
    return self->__isInputting;
    }

#pragma mark - Private Interfaces

- ( void ) __init
    {
    [ self setWantsLayer: YES ];

    self.__backingCell = [ [ __SSBackingCell alloc ] init ];

    self.__inputField = [ [ __SSInputField alloc ] initWithFrame: NSZeroRect delegate: self ];
    [ self.__inputField setTranslatesAutoresizingMaskIntoConstraints: NO ];

    self.__isInputting = NO;

    self->__lhsAnchoredField = [ [ NSView alloc ] initWithFrame: NSZeroRect ];
    self->__rhsAnchoredField = [ [ NSView alloc ] initWithFrame: NSZeroRect ];
    self->__lhsFloatField = [ [ NSView alloc ] initWithFrame: NSZeroRect ];
    self->__rhsFloatField = [ [ NSView alloc ] initWithFrame: NSZeroRect ];
    }

@end // __SSBar class

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