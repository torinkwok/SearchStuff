//
//  SSSearchStuffWidget.m
//  Playground
//
//  Created by Tong G. on 10/5/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "SSSearchStuffWidget.h"

// Standard Identifiers
NSString* const SearchStuffSearchWidgetIdentifier = @"__ssSearchWidgetIdentifier";
NSString* const SearchStuffReloadWidgetIdentifier = @"__ssReloadWidgetIdentifier";

// Private Interfaces
@interface SSSearchStuffWidget ()
@property ( strong, readwrite ) NSString* identifier;
@end // Private Interfaces

// SSSearchStuffWidget 
@implementation SSSearchStuffWidget

#pragma mark - Initializations

- ( instancetype ) initWithIdentifier: ( NSString* )_WidgetIdentifier
    {
    if ( self = [ super init ] )
        self.identifier = _WidgetIdentifier;

    return self;
    }

@end // SSSearchStuffWidget class
