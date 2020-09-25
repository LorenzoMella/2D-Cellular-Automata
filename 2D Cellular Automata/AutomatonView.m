//
//  AutomatonView.m
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 29/03/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import "AutomatonView.h"

@implementation AutomatonView
{
    // Buffer stuff for when the mouse is dragged
    NSPoint lastPoint;
    char lastPointState;
}

@synthesize grid;
@synthesize liveCellColor, deadCellColor;

///////////////////////////////////////////
#pragma mark View init and drawing methods
///////////////////////////////////////////

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect wholeView = [self bounds];
    NSSize cellRectSize = {
        wholeView.size.height/GRID_DIMENSION,      // Both width and height are the same: we want squares, after all.
        wholeView.size.height/GRID_DIMENSION};
    
    // We use the overkill strategy for now: at each step we redraw everything!! Background and 'live' squares
    
    // Background layer
    //[[NSColor colorWithCalibratedHue:0.5 saturation:0.62 brightness:0.32 alpha:1.0] set];
    [deadCellColor set];
    NSRectFill(wholeView);
    
    // Draws currentAutomaton state
    [liveCellColor set];
    NSRect squareToRedraw;
    for(NSUInteger i = 0; i < GRID_DIMENSION; ++i)
        for(NSUInteger j = 0; j < GRID_DIMENSION; ++j)
            if([self.grid[i][j] cellState] == 1) {
                squareToRedraw.origin.x = i*cellRectSize.height;
                squareToRedraw.origin.y = j*cellRectSize.width;
                squareToRedraw.size = cellRectSize;
                NSRectFill(squareToRedraw);
            }
}

- (BOOL)isOpaque {
    return YES;
}

//////////////////////////
#pragma mark Mouse events
//////////////////////////

- (void)mouseDown:(NSEvent *)event {
    
    NSRect wholeView = [self bounds];
    NSInteger i, j;
    
    lastPoint = [self convertPoint:[event locationInWindow] fromView:nil];
    
    i = (lastPoint.x / wholeView.size.width)*GRID_DIMENSION;
    j = (lastPoint.y / wholeView.size.height)*GRID_DIMENSION;
    
    NSLog(@"Mouse pressed at row: %lu, column: %lu", i, j);

    [self.grid[i][j] changeState];
    lastPointState = [self.grid[i][j] cellState];   // This is memorized so that the same color will be drawn while dragging
    
    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event {
    
    NSPoint currentPoint = [self convertPoint:[event locationInWindow] fromView:nil];
    NSRect wholeView = [self bounds];
    
    NSInteger i, j;
    NSInteger lastI, lastJ;
    
    i = (currentPoint.x / wholeView.size.width)*GRID_DIMENSION;
    j = (currentPoint.y / wholeView.size.height)*GRID_DIMENSION;

    lastI = (lastPoint.x / wholeView.size.width)*GRID_DIMENSION;
    lastJ = (lastPoint.y / wholeView.size.height)*GRID_DIMENSION;
    
    if(i != lastI || j != lastJ) {
        if(i >= 0 && i < GRID_DIMENSION && j >= 0 && j < GRID_DIMENSION) {
            NSLog(@"Mouse dragged across row: %lu, column: %lu", i, j);
    
            [self.grid[i][j] setCellState:lastPointState];
            [self setNeedsDisplay:YES];
        
            lastPoint = currentPoint;
        }
        else
            NSLog(@"Mouse dragged outside view");
    }
}


@end
