//
//  __SSSearchStuffWidget.h
//  Playground
//
//  Created by Tong G. on 10/20/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "SSSearchStuffWidget.h"

// __SSSearchStuffWidget class
@interface SSSearchStuffWidget ( SearchStuffPrivate )

+ ( NSArray <__kindof NSString*>* ) __stdIdentifiers;

- ( instancetype ) __initWithIdentifier: ( NSString* )_Identifier;

@property ( strong, readwrite ) NSString* identifier;

@end // __SSSearchStuffWidget class
