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

#pragma mark - Pure Virtual Methods

@property ( strong, readwrite ) NSImage* ssImage;
@property ( strong, readwrite ) NSImage* ssDefaultAlternativeImage;

#pragma mark - Default Properties

@property ( assign, readonly ) NSSize ssDefaultSize;

@end // __SSButton class
