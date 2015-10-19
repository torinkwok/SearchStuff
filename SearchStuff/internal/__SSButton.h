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

#pragma mark - Dynamic Properties

@property ( strong, readwrite ) NSImage* ssImage;
@property ( strong, readwrite ) NSImage* ssAlternativeImage;

@property ( assign, readonly ) NSSize ssDefaultSize;

@end // __SSButton class
