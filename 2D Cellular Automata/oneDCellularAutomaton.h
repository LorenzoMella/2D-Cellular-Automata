//
//  oneDCellularAutomaton.h
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 21/04/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import "Cell.h"

#import <Foundation/Foundation.h>

@interface oneDCellularAutomaton : NSObject
{
    char ruleCArray[8];
}

@property NSMutableArray *rule;
@property NSMutableArray *cellTape;

- (id)initWithRuleFromCode:(NSUInteger)code andInitialTape:(NSMutableArray *)tape;
- (id)initWithSingleCellFromCode:(NSUInteger)code;

- (void)setRuleFromCode:(NSUInteger)code;
- (NSUInteger)codeFromRule;

- (char)nextStateFromLeft:(char)l center:(char)c right:(char)r;
- (void)evolutionStep;

@end
