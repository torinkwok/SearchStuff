//
//  __SSButton.h
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

@import Cocoa;

// __SSButton class
@interface __SSButton : NSButton

#pragma mark - Pure Virtual Properties

+ ( NSImage* ) defaultImage;
+ ( NSImage* ) defaultAlternativeImage;

#pragma mark - Default Properties

+ ( NSSize ) defaultSize;

@end // __SSButton class
