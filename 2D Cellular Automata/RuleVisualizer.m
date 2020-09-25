//
//  RuleVisualizer.m
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 23/04/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import "RuleVisualizer.h"

@implementation RuleVisualizer

@synthesize centerIsOne;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect bounds = [self bounds];
    float side = bounds.size.width/3;
    float twoSides = 2*side;
    
    NSBezierPath *littleRectPath = [NSBezierPath bezierPath];
    NSRect littleRect[9] = {
        NSMakeRect(side, side, side, side),             // center
        NSMakeRect(twoSides, twoSides, side, side),     // top-right
        NSMakeRect(0, 0, side, side),                   // bottom-left
        NSMakeRect(0, twoSides, side, side),            // top-left
        NSMakeRect(twoSides, 0, side, side),            // bottom-right
        NSMakeRect(side, twoSides, side, side),         // top
        NSMakeRect(side, 0, side, side),                // bottom
        NSMakeRect(0, side, side, side),                // left
        NSMakeRect(twoSides, side, side, side)          // right
    };

    int i, j;
    
    for(i = 0; i < 9; ++i) {
        // Draws the white
        [[NSColor whiteColor] set];
        [NSBezierPath fillRect:NSMakeRect(0, i*1.34*bounds.size.width, bounds.size.width, bounds.size.width)];

        // Draws black squares
        [[NSColor blackColor] set];
        for(j = centerIsOne ? 0 : 1; j <= i; ++j)
            [littleRectPath appendBezierPathWithRect:[self rectWithRect:littleRect[j] atReferenceOrigin:NSMakePoint(0, i*1.34*bounds.size.width)]];
        [littleRectPath closePath];
        [littleRectPath fill];
    }
    
    // Draws white borders around the squares
    [[NSColor whiteColor] set];
    for(i = 0; i < 9; ++i)
        for(j = centerIsOne ? 0 : 1; j <= i; ++j)
            [littleRectPath appendBezierPathWithRect:[self rectWithRect:littleRect[j] atReferenceOrigin:NSMakePoint(0, i*1.34*bounds.size.width)]];
    [littleRectPath closePath];
    [littleRectPath stroke];
    
}

- (NSRect)rectWithRect:(NSRect)oldRect atReferenceOrigin:(NSPoint)newReferenceOrigin {
    return NSMakeRect(oldRect.origin.x + newReferenceOrigin.x, oldRect.origin.y + newReferenceOrigin.y, oldRect.size.width, oldRect.size.height);
}

@end
