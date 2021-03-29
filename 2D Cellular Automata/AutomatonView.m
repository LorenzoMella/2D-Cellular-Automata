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
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect wholeView = [self bounds];
    NSSize cellRectSize = {
        wholeView.size.height/GRID_DIMENSION,
        wholeView.size.height/GRID_DIMENSION};
    
    // Draw background layer
    [deadCellColor set];
    NSRectFill(wholeView);
    
    // Draw currentAutomaton state
    [liveCellColor set];
    
    NSRect squareToRedraw;
    for (NSUInteger i = 0; i < GRID_DIMENSION; ++i) {
        for (NSUInteger j = 0; j < GRID_DIMENSION; ++j) {
            if ([self.grid[i][j] cellState] == 1) {
                squareToRedraw.origin.x = i*cellRectSize.height;
                squareToRedraw.origin.y = j*cellRectSize.width;
                squareToRedraw.size = cellRectSize;
                NSRectFill(squareToRedraw);
            }
        }
    }
}



//////////////////////////
#pragma mark Mouse events
//////////////////////////


- (void)mouseDown:(NSEvent *)event {
    
    NSRect wholeView = [self bounds];
    
    lastPoint = [self convertPoint:[event locationInWindow] fromView:nil];
    
    NSInteger i = (lastPoint.x / wholeView.size.width) * GRID_DIMENSION;
    NSInteger j = (lastPoint.y / wholeView.size.height) * GRID_DIMENSION;
    
    NSLog(@"Mouse pressed at row: %lu, column: %lu", i, j);

    [self.grid[i][j] changeState];
    lastPointState = [self.grid[i][j] cellState];   // Save state, to keep the same color while dragging
    
    [self setNeedsDisplay:YES];
}


- (void)mouseDragged:(NSEvent *)event {
    
    NSPoint currentPoint = [self convertPoint:[event locationInWindow] fromView:nil];
    NSRect wholeView = [self bounds];
    
    NSInteger i = (currentPoint.x / wholeView.size.width) * GRID_DIMENSION;
    NSInteger j = (currentPoint.y / wholeView.size.height) * GRID_DIMENSION;

    NSInteger lastI = (lastPoint.x / wholeView.size.width) * GRID_DIMENSION;
    NSInteger lastJ = (lastPoint.y / wholeView.size.height) * GRID_DIMENSION;
    
    if (i != lastI || j != lastJ) {
        if (0 <= i && i < GRID_DIMENSION && 0 <= j && j < GRID_DIMENSION) {
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
