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

#import "__SSSearchStuffBar.h"

#import "__SSSearchStuffBackingCell.h"
#import "__SSSearchStuffInputField.h"
#import "__SSSearchStuffWidget.h"

#import "SSSearchStuffWidget.h"
#import "SSSearchStuffToolbarItem.h"

// Private Interfaces
@interface __SSSearchStuffBar()

@property ( strong ) __SSSearchStuffBackingCell* __backingCell;
@property ( strong ) __SSSearchStuffInputField* __inputField;

@property ( strong ) NSArray <__kindof NSLayoutConstraint*>* __inputFieldConstraints;

@property ( assign ) BOOL __isInputting;

- ( void ) __init;

@end // Private Interfaces

// __SSSearchStuffBar class
@implementation __SSSearchStuffBar

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
    // Manipulation of left hand side anchored widgets
    if ( [ self.hostingSSToolbarItem.delegate respondsToSelector: @selector( ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers ) ] )
        {
        NSArray <__kindof NSString*>* lhsAnchoredWidgetIdentifiers =
            [ self.hostingSSToolbarItem.delegate ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers ];

        NSMutableArray* lhsAnchoredWidgets = [ NSMutableArray arrayWithCapacity: lhsAnchoredWidgetIdentifiers.count ];
        for ( NSString* _WidgetIdentifier in lhsAnchoredWidgetIdentifiers )
            {
//            NSLog( @"%@", _WidgetIdentifier );
            if ( [ [ [ SSSearchStuffWidget class ] __stdIdentifiers ] containsObject: _WidgetIdentifier ] )
                [ lhsAnchoredWidgets addObject: [ [ SSSearchStuffWidget alloc ] initWithIdentifier: _WidgetIdentifier ] ];
            }

//        NSLog( @"%@", self.hostingSSToolbarItem.__standardIdentifiers );
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

    self.__backingCell = [ [ __SSSearchStuffBackingCell alloc ] init ];

    self.__inputField = [ [ __SSSearchStuffInputField alloc ] initWithFrame: NSZeroRect delegate: self ];
    [ self.__inputField setTranslatesAutoresizingMaskIntoConstraints: NO ];

    self.__isInputting = NO;

    self->__lhsAnchoredField = [ [ NSView alloc ] initWithFrame: NSZeroRect ];
    self->__rhsAnchoredField = [ [ NSView alloc ] initWithFrame: NSZeroRect ];
    self->__lhsFloatField = [ [ NSView alloc ] initWithFrame: NSZeroRect ];
    self->__rhsFloatField = [ [ NSView alloc ] initWithFrame: NSZeroRect ];
    }

@end // __SSSearchStuffBar class

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