//
//  __SSSearchStuffWidgetUser.h
//  Playground
//
//  Created by Tong G. on 10/20/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "SSSearchStuffWidget.h"

// __SSSearchStuffWidgetUser class
@interface __SSSearchStuffWidgetUser : SSSearchStuffWidget

@property ( assign, readwrite ) SEL action;
@property ( weak, readwrite ) id target;

@property ( strong, readwrite ) NSImage* image;
@property ( strong, readwrite ) NSImage* alternativeImage;

@property ( strong, readwrite ) NSView* view;

@property ( strong, readwrite ) NSString* toolTip;

@end // __SSSearchStuffWidgetUser class
