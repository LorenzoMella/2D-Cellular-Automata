//
//  AutomatonView.h
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 29/03/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//


#import "CellularAutomaton.h"

#import <Cocoa/Cocoa.h>


@interface AutomatonView : NSView

@property (assign) NSMutableArray *grid;
@property NSColor *liveCellColor;
@property NSColor *deadCellColor;

@end
