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

#import "__SSBar.h"

#import "__SSBackingCell.h"
#import "__SSInputField.h"
#import "__SSWidgetBackingButton.h"
#import "__SSFixedWidgetsPallet.h"
#import "__SSAutoSizeWidgetsPallet.h"
#import "__SSConstants.h"
#import "SearchStuffWidget+__SSPrivate.h"
#import "SearchStuffWidget+__SSPrivate.h"

#import "SearchStuffWidget.h"
#import "SearchStuffToolbarItem.h"

@import QuartzCore;
#import <objc/message.h>

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

@property ( strong ) __SSFixedWidgetsPallet* __leftAnchoredWidgetsPallet;
@property ( strong ) __SSFixedWidgetsPallet* __rightAnchoredWidgetsPallet;
@property ( strong ) __SSFixedWidgetsPallet* __leftFloatWidgetsPallet;
@property ( strong ) __SSFixedWidgetsPallet* __rightFloatWidgetsPallet;
@property ( strong ) __SSAutoSizeWidgetsPallet* __titleWidgetsPallet;

- ( void ) __init;

@end // Private Interfaces

// __SSBar class
@implementation __SSBar
    {
@protected
    NSTimer __strong* __mouseEnteredTimer;
    }

@dynamic constraintWidth;

@synthesize hostingSSToolbarItem;

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
    NSObject <SearchStuffDelegate>* tlbItemDel = self.hostingSSToolbarItem.delegate;

    SEL lhsAnchoredWidgetIDsDelSEL = @selector( ssToolbarItemLeftHandSideAnchoredWidgetIdentifiers );
    SEL rhsAnchoredWidgetIDsDelSEL = @selector( ssToolbarItemRightHandSideAnchoredWidgetIdentifiers );
    SEL lhsFloatWidgetIDsDelSEL = @selector( ssToolbarItemLeftHandSideFloatWidgetIdentifiers );
    SEL rhsFloatWidgetIDsDelSEL = @selector( ssToolbarItemRightHandSideFloatWidgetIdentifiers );
    SEL titleWidgetIDsDelSEL = @selector( ssToolbarItemTitleWidgetsIdentifiers );

    NSArray <__kindof NSValue*>* widgetsSELs = @[ [ NSValue valueWithPointer: lhsAnchoredWidgetIDsDelSEL ]
                                                , [ NSValue valueWithPointer: rhsAnchoredWidgetIDsDelSEL ]
                                                , [ NSValue valueWithPointer: lhsFloatWidgetIDsDelSEL ]
                                                , [ NSValue valueWithPointer: rhsFloatWidgetIDsDelSEL ]
                                                , [ NSValue valueWithPointer: titleWidgetIDsDelSEL ]
                                                ];
    for ( NSValue* _SEL in widgetsSELs )
        {
        SEL delSel = ( SEL )_SEL.pointerValue;

        // Manipulation of widgets
        if ( [ tlbItemDel respondsToSelector: delSel ] )
            {
            NSArray <__kindof NSString*>* widgetIdentifiers = objc_msgSend( tlbItemDel, delSel );
            NSMutableArray <__kindof SearchStuffWidget*>* repWidgets = [ NSMutableArray arrayWithCapacity: widgetIdentifiers.count ];

            if ( widgetIdentifiers.count > 0 )
                {
                for ( NSString* _WidgetIdentifier in widgetIdentifiers )
                    {
                    if ( [ [ [ SearchStuffWidget class ] __stdIdentifiers ] containsObject: _WidgetIdentifier ] )
                        [ repWidgets addObject: [ [ SearchStuffWidget alloc ] initWithIdentifier: _WidgetIdentifier ] ];
                    else
                        {
                        if ( [ tlbItemDel respondsToSelector: @selector( ssToolbarItem:widgetForWidgetIdentifier: ) ] )
                            {
                            SearchStuffWidget* ssWidget = [ tlbItemDel ssToolbarItem: tlbItem widgetForWidgetIdentifier: _WidgetIdentifier ];
                            [ repWidgets addObject: ssWidget ];
                            }
                        }
                    }

                NSMutableArray <__kindof __SSWidgetBackingButton*>* ssWidgets = [ NSMutableArray arrayWithCapacity: repWidgets.count ];
                for ( SearchStuffWidget* _repWidget in repWidgets )
                    {
                    __SSWidgetBackingButton* ssWidget = [ __SSWidgetBackingButton ssWidgetWithRepWidget: _repWidget ];
                    [ ssWidgets addObject: ssWidget ];

                    __SSWidgetsPallet* ssPallet = nil;

                    if ( delSel == lhsAnchoredWidgetIDsDelSEL )      ssPallet = self.__leftAnchoredWidgetsPallet;
                    else if ( delSel == rhsAnchoredWidgetIDsDelSEL ) ssPallet = self.__rightAnchoredWidgetsPallet;
                    else if ( delSel == lhsFloatWidgetIDsDelSEL )    ssPallet = self.__leftFloatWidgetsPallet;
                    else if ( delSel == rhsFloatWidgetIDsDelSEL )    ssPallet = self.__rightFloatWidgetsPallet;
                    else if ( delSel == titleWidgetIDsDelSEL )       ssPallet = self.__titleWidgetsPallet;

                    ssPallet.ssWidgets = ssWidgets;
                    }
                }
            }
        }

    self->__widthConstraint.constant = self.constraintWidth;

    [ self.hostingSSToolbarItem setMinSize:
        NSMakeSize( self->__widthConstraint.constant, self.hostingSSToolbarItem.minSize.height ) ];
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

- ( void ) mouseEntered: ( NSEvent* )_Event
    {
    [ self->__mouseEnteredTimer invalidate ];

    self->__mouseEnteredTimer =
        [ NSTimer timerWithTimeInterval: .3f target: self selector: @selector( __mouseEnteredTimerFired: ) userInfo: nil repeats: NO ];

    [ [ NSRunLoop currentRunLoop ] addTimer: self->__mouseEnteredTimer forMode: NSDefaultRunLoopMode ];
    }

- ( void ) mouseExited: ( NSEvent* )_Event
    {
    [ self->__mouseEnteredTimer invalidate ];

    if ( !self.__leftFloatWidgetsPallet.hidden )
        [ self.__leftFloatWidgetsPallet setHidden: YES ];

    if ( !self.__rightFloatWidgetsPallet.hidden )
        [ self.__rightFloatWidgetsPallet setHidden: YES ];
    }

#pragma mark - Conforms to <CALayerDelegate>

- ( id <CAAction> ) actionForLayer: ( CALayer* )_Layer
                            forKey: ( NSString* )_EventKey
    {
    id <CAAction> action = nil;

    if ( [ _EventKey isEqualToString: @"hidden" ] )
        {
        CATransition* transitionAnim = [ CATransition animation ];
        [ transitionAnim setDuration: .4f ];
        [ transitionAnim setStartProgress: 0.f ];
        [ transitionAnim setEndProgress: 1.f ];

        [ transitionAnim setFillMode: kCAFillModeForwards ];
        [ transitionAnim setTimingFunction:
            [ CAMediaTimingFunction functionWithName: _Layer.hidden ? kCAMediaTimingFunctionEaseIn
                                                                    : kCAMediaTimingFunctionEaseOut ] ];
        action = transitionAnim;
        }

    return action;
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

- ( CGFloat ) constraintWidth
    {
    CGFloat finalWidth =
        self.__leftAnchoredWidgetsPallet.constraintWidth
            + self.__leftFloatWidgetsPallet.constraintWidth
            + self.__rightAnchoredWidgetsPallet.constraintWidth
            + self.__rightFloatWidgetsPallet.constraintWidth
            + [ __SSAutoSizeWidgetsPallet ssMinimumWidth ];

    return finalWidth;
    }

#pragma mark - Private Interfaces

@synthesize __backingCell;
@synthesize __inputField;
@dynamic __isInputting;

- ( void ) set__isInputting: ( BOOL )_Flag
    {
    self->__isInputting = _Flag;
    }

- ( BOOL ) __isInputting
    {
    return self->__isInputting;
    }

- ( void ) __init
    {
    [ self setWantsLayer: YES ];

    self.__backingCell = [ [ __SSBackingCell alloc ] init ];

    self.__inputField = [ [ __SSInputField alloc ] initWithFrame: NSZeroRect delegate: self ];
    [ self.__inputField setTranslatesAutoresizingMaskIntoConstraints: NO ];

    self.__isInputting = NO;

    self.__leftAnchoredWidgetsPallet = [ [ __SSFixedWidgetsPallet alloc ] initWithHost: self type: __SSPalletTypeLeftAnchored ];
    self.__rightAnchoredWidgetsPallet = [ [ __SSFixedWidgetsPallet alloc ] initWithHost: self type: __SSPalletTypeRightAnchored ];
    self.__leftFloatWidgetsPallet = [ [ __SSFixedWidgetsPallet alloc ] initWithHost: self type: __SSPalletTypeLeftFloat ];
    self.__rightFloatWidgetsPallet = [ [ __SSFixedWidgetsPallet alloc ] initWithHost: self type: __SSPalletTypeRightFloat ];
    self.__titleWidgetsPallet = [ [ __SSAutoSizeWidgetsPallet alloc ] initWithHost: self type: __SSPalletTypeTitle ];

    #if DEBUG
    self.__leftAnchoredWidgetsPallet.identifier = @"left-anchored-wp";
    self.__rightAnchoredWidgetsPallet.identifier = @"right-anchored-wp";
    self.__leftFloatWidgetsPallet.identifier = @"left-float-wp";
    self.__rightFloatWidgetsPallet.identifier = @"right-float-wp";
    self.__titleWidgetsPallet.identifier = @"title-wp";
    #endif

    NSView* lhsAnchoredWidgetsPallet = self.__leftAnchoredWidgetsPallet;
    NSView* rhsAnchoredWidgetsPallet = self.__rightAnchoredWidgetsPallet;
    NSView* lhsFloatWidgetsPallet = self.__leftFloatWidgetsPallet;
    NSView* rhsFloatWidgetsPallet = self.__rightFloatWidgetsPallet;
    NSView* titlePallet = self.__titleWidgetsPallet;

    NSDictionary* viewsDict =
        NSDictionaryOfVariableBindings( lhsAnchoredWidgetsPallet
                                      , rhsAnchoredWidgetsPallet
                                      , lhsFloatWidgetsPallet
                                      , rhsFloatWidgetsPallet
                                      , titlePallet
                                      );
    CGFloat palletWidth = 0.f;
    NSArray* horLayoutConstraints = [ NSLayoutConstraint
        constraintsWithVisualFormat: @"H:|"
                                      "-(==1)"
                                      "-[lhsAnchoredWidgetsPallet]"
                                      "[lhsFloatWidgetsPallet]"
                                      "[titlePallet]"
                                      "[rhsFloatWidgetsPallet]"
                                      "[rhsAnchoredWidgetsPallet]"
                                      "-(==1)"
                                      "-|"
                            options: 0
                            metrics: @{ @"palletWidth" : @( palletWidth ) }
                              views: viewsDict ];

    NSMutableArray* verLayoutConstraints = [ NSMutableArray array ];
    for ( NSString* _ViewName in viewsDict )
        {
        NSArray* constraints = [ NSLayoutConstraint
            constraintsWithVisualFormat: [ NSString stringWithFormat: @"V:|-(==1)-[%@]-(==2)-|", _ViewName ]
                                options: 0
                                metrics: nil
                                  views: @{ _ViewName : viewsDict[ _ViewName ] } ];

        [ verLayoutConstraints addObjectsFromArray: constraints ];
        }

    self->__widthConstraint = [ NSLayoutConstraint
        constraintWithItem: self
                 attribute: NSLayoutAttributeWidth
                 relatedBy: NSLayoutRelationGreaterThanOrEqual
                    toItem: nil
                 attribute: NSLayoutAttributeNotAnAttribute
                multiplier: 0.f
                  constant: 0.f ];

    [ self addConstraints: horLayoutConstraints ];
    [ self addConstraints: verLayoutConstraints ];
    [ self addConstraint: self->__widthConstraint ];

    NSTrackingArea* trackingArea =
        [ [ NSTrackingArea alloc ] initWithRect: self.bounds
                                        options: NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingCursorUpdate
                                                    | NSTrackingActiveAlways
                                                    /* This NSTrackingArea object was created with NSTrackingInVisibleRect option,
                                                     * in which case the AppKit handles the re-computation of tracking area */
                                                    | NSTrackingInVisibleRect
                                          owner: self
                                       userInfo: nil ];
    [ self addTrackingArea: trackingArea ];
    }

- ( void ) __mouseEnteredTimerFired: ( NSTimer* )_Timer
    {
    __CA_TRANSACTION_BEGIN__
    [ CATransaction setCompletionBlock:
    ^( void )
        {
        // TODO:
        } ];

    [ self.__leftFloatWidgetsPallet setHidden: NO ];
    [ self.__rightFloatWidgetsPallet setHidden: NO ];
    __CA_TRANSACTION_COMMIT__
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