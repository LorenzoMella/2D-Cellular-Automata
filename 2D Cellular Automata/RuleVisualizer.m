//
//  RuleVisualizer.m
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 23/04/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//


#import "RuleVisualizer.h"

#define RELATIVE_GAP     1.34

@implementation RuleVisualizer

@synthesize centerIsOne;


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    NSRect bounds = [self bounds];
    float side = bounds.size.width / 3;  // big square subdivided in 3x3 grid

    NSBezierPath *littleRectPath = [NSBezierPath bezierPath];
    NSRect littleRect[NUM_NEIGHBORS] = {
        NSMakeRect(side, side, side, side),             // center
        NSMakeRect(2 * side, 2 * side, side, side),     // top-right
        NSMakeRect(0, 0, side, side),                   // bottom-left
        NSMakeRect(0, 2 * side, side, side),            // top-left
        NSMakeRect(2 * side, 0, side, side),            // bottom-right
        NSMakeRect(side, 2 * side, side, side),         // top
        NSMakeRect(side, 0, side, side),                // bottom
        NSMakeRect(0, side, side, side),                // left
        NSMakeRect(2 * side, side, side, side)          // right
    };
    
    for(int i = 0; i < NUM_NEIGHBORS; ++i) {
        // Draws the white
        [[NSColor whiteColor] set];
        [NSBezierPath fillRect:NSMakeRect(0, i * RELATIVE_GAP * bounds.size.width, bounds.size.width, bounds.size.width)];

        // Draws black squares
        [[NSColor blackColor] set];
        for(int j = centerIsOne ? 0 : 1; j <= i; ++j) {
            [littleRectPath appendBezierPathWithRect:[self rectWithRect:littleRect[j]
                                                      atReferenceOrigin:NSMakePoint(0, i * RELATIVE_GAP * bounds.size.width)]];
        }
        
        [littleRectPath closePath];
        [littleRectPath fill];
    }
    
    // Draws white borders around the squares
    [[NSColor whiteColor] set];
    for (int i = 0; i < NUM_NEIGHBORS; ++i) {
        for (int j = centerIsOne ? 0 : 1; j <= i; ++j) {
            [littleRectPath appendBezierPathWithRect:[self rectWithRect:littleRect[j]
                                                      atReferenceOrigin:NSMakePoint(0, i * RELATIVE_GAP * bounds.size.width)]];
        }
    }
    
    [littleRectPath closePath];
    [littleRectPath stroke];
    
}


- (NSRect)rectWithRect:(NSRect)oldRect atReferenceOrigin:(NSPoint)newReferenceOrigin {
    return NSMakeRect(oldRect.origin.x + newReferenceOrigin.x, oldRect.origin.y + newReferenceOrigin.y,
                      oldRect.size.width, oldRect.size.height);
}


@end
