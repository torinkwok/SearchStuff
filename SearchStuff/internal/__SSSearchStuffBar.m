//
//  __SSSearchStuffBar.m
//  Playground
//
//  Created by Tong G. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchStuffBar.h"

#import "__SSSearchStuffBackingCell.h"
#import "__SSSearchStuffInputField.h"

#import "__SSSearchStuffToolbarItem.h"

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
    if ( [ self.hostingSSToolbarItem.delegate respondsToSelector: @selector( ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers ) ] )
        {
        NSArray <__kindof NSString*>* lhsAnchoredWidgets =
            [ self.hostingSSToolbarItem.delegate ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers ];

        NSLog( @"%@", self.hostingSSToolbarItem.__standardIdentifiers );
        }
    }

#pragma Drawing

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
