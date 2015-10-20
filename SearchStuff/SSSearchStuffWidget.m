//
//  SSSearchStuffWidget.m
//  Playground
//
//  Created by Tong G. on 10/5/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "SSSearchStuffWidget.h"

#import "__SSSearchStuffWidget.h"

// Standard Identifiers
NSString* const SearchStuffSearchWidgetIdentifier = @"__ssSearchWidgetIdentifier";
NSString* const SearchStuffReloadWidgetIdentifier = @"__ssReloadWidgetIdentifier";

// Private Interfaces
@interface SSSearchStuffWidget ()

@end // Private Interfaces

NSArray <__kindof NSString*> static* sStandardIdentifiers;

// SSSearchStuffWidget 
@implementation SSSearchStuffWidget

#pragma mark - Initializations

+ ( NSArray <__kindof NSString*>* ) __stdIdentifiers
    {
    return@[ SearchStuffSearchWidgetIdentifier
           , SearchStuffReloadWidgetIdentifier
           ];
    }

- ( instancetype ) initWithIdentifier: ( NSString* )_Identifier
    {
    self.identifier = _Identifier;

    SSSearchStuffWidget* clusterMember = nil;
//    if ( self.ho

    return clusterMember;
    }

@end // SSSearchStuffWidget class
