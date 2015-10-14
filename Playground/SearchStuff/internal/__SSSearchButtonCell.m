//
//  __SSSearchButtonCell.m
//  Playground
//
//  Created by Tong G. on 10/13/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#import "__SSSearchButtonCell.h"

// __SSSearchButtonCell class
@implementation __SSSearchButtonCell

#pragma mark - Drawing

- ( void ) drawWithFrame: ( NSRect )_CellFrame
                  inView: ( NSView* )_ControlView
    {
    NSImage* finalImage = self.isHighlighted ? self.alternateImage : self.image;

    NSRect ctrlFrameRect = _ControlView.bounds;
    NSAffineTransform* flipTransform = [ NSAffineTransform transform ];
    [ flipTransform translateXBy: 0.f yBy: ctrlFrameRect.size.height ];
    [ flipTransform scaleXBy: 1.f yBy: -1.f ];
    [ flipTransform concat ];

    [ finalImage drawInRect: _ControlView.bounds
                   fromRect: NSZeroRect
                  operation: NSCompositeSourceOver
                   fraction: 1.f ];

    [ flipTransform invert ];
    [ flipTransform concat ];
    }

@end // __SSSearchButtonCell class
