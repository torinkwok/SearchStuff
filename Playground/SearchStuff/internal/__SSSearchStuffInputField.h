//
//  __SSSearchStuffInputField.h
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

@import Cocoa;

// __SSSearchStuffInputField class
@interface __SSSearchStuffInputField : NSTextField

#pragma mark - Initializations
- ( instancetype ) initWithFrame: ( NSRect )_Frame delegate: ( id <NSTextFieldDelegate> )_Delegate;

@end // __SSSearchStuffInputField class
