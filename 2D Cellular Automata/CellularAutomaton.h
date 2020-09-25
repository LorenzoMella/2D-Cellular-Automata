//
//  CellularAutomaton.h
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 29/03/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface CellularAutomaton : NSObject

@property NSMutableArray *grid;
@property NSMutableArray *rule0, *rule1;

- (id)initWithGrid:(NSMutableArray *)initialGrid andRule:(unsigned int)ruleCode;
- (id)initWithZeroes;
- (id)initWithNWGliderAtI:(NSUInteger)i andJ:(NSUInteger)j;
- (id)initWithCStrings:(char **)CStringGrid;
- (void)setWithNWGliderAtI:(NSUInteger)i andJ:(NSUInteger)j;

- (void)setRuleWithCode:(unsigned int)ruleCode;
- (unsigned int)readRuleCode;

- (char)nextStateFromState:(char)state andTotal:(NSUInteger)t;
- (void)evolutionStepWithBorderType:(int)type;

@end
