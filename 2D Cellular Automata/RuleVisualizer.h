//
//  RuleVisualizer.h
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 23/04/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RuleVisualizer : NSView

@property BOOL centerIsOne;

- (NSRect)rectWithRect:(NSRect)oldRect atReferenceOrigin:(NSPoint)newOrigin;

@end
