//
//  SSSearchStuffWidget.h
//  Playground
//
//  Created by Tong G. on 10/4/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

@import Cocoa;

// Standard Identifiers
NSString extern* const SearchStuffSearchWidgetIdentifier;
NSString extern* const SearchStuffReloadWidgetIdentifier;

// SSSearchStuffWidget class
@interface SSSearchStuffWidget : NSObject

@property ( strong, readonly ) NSString* identifier;

#pragma mark - Initializations

- ( instancetype ) initWithIdentifier: ( NSString* )_WidgetIdentifier;

@end // SSSearchStuffWidget class
