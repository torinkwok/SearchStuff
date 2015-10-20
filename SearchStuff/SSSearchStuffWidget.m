//
//  SSSearchStuffWidget.m
//  Playground
//
//  Created by Tong G. on 10/5/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "SSSearchStuffWidget.h"

#import "__SSSearchStuffWidget.h"
#import "__SSSearchStuffWidgetStd.h"
#import "__SSSearchStuffWidgetUser.h"

// Standard Identifiers
NSString* const SearchStuffSearchWidgetIdentifier = @"__ssSearchWidgetIdentifier";
NSString* const SearchStuffReloadWidgetIdentifier = @"__ssReloadWidgetIdentifier";

NSArray <__kindof NSString*> static* sStandardIdentifiers;

// SSSearchStuffWidget 
@implementation SSSearchStuffWidget

#pragma mark - Initializations

- ( instancetype ) initWithIdentifier: ( NSString* )_Identifier
    {
    self.identifier = _Identifier;

    SSSearchStuffWidget* clusterMember = nil;
    if ( [ [ [ self class ] __stdIdentifiers ] containsObject: self.identifier ] )
        clusterMember = [ [ __SSSearchStuffWidgetStd alloc ] __initWithIdentifier: self.identifier ];
    else
        clusterMember = [ [ __SSSearchStuffWidgetUser alloc ] __initWithIdentifier: self.identifier ];

    return clusterMember;
    }

@end // SSSearchStuffWidget class

// SSSearchStuffWidget + SearchStuffPrivate
@implementation SSSearchStuffWidget ( SearchStuffPrivate )

@dynamic identifier;

+ ( NSArray <__kindof NSString*>* ) __stdIdentifiers
    {
    return@[ SearchStuffSearchWidgetIdentifier
           , SearchStuffReloadWidgetIdentifier
           ];
    }

- ( instancetype ) __initWithIdentifier: ( NSString* )_Identifier
    {
    if ( !_Identifier )
        return nil;

    if ( self = [ super init ] )
        self.identifier = _Identifier;

    return self;
    }

@end // SSSearchStuffWidget + SearchStuffPrivate