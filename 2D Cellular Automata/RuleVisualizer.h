//
//  RuleVisualizer.h
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 23/04/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import "defs.h"

#import <Cocoa/Cocoa.h>

@interface RuleVisualizer : NSView

@property BOOL centerIsOne;  // There are two RuleVisualizer columns: one with "black" and one with "white" centers

- (NSRect)rectWithRect:(NSRect)oldRect atReferenceOrigin:(NSPoint)newOrigin;

@end
