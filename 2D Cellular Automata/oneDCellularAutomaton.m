//
//  oneDCellularAutomaton.m
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 21/04/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import "oneDCellularAutomaton.h"

@implementation oneDCellularAutomaton

@synthesize rule = _rule;
@synthesize cellTape = _cellTape;


////////////////////////////
#pragma mark - Initializers
////////////////////////////

- (id)initWithRuleFromCode:(NSUInteger)code andInitialTape:(NSMutableArray *)tape {
    self = [super init];
    if(self) {
        _rule = [NSMutableArray array];
        [self setRuleFromCode:code];
        [self setCellTape:tape];
    }
    return self;
}

- (id)initWithSingleCellFromCode:(NSUInteger)code {
    NSMutableArray *tape = [NSMutableArray array];
    
    for(int i = 0; i < GRID_DIMENSION; ++i)
        [tape addObject:[NSNumber numberWithChar:0]];
    [tape[GRID_DIMENSION/2] setState:1];
    
    return [self initWithRuleFromCode:code andInitialTape:tape];
}


//////////////////////////////
#pragma mark - Rule accessors
//////////////////////////////

- (void)setRuleFromCode:(NSUInteger)code {
    for(int i = 0; i < 8; ++i) {
        ruleCArray[i] = (code & (1 << i)) >> i;
        [_rule addObject:[NSNumber numberWithChar:ruleCArray[i]]];
    }
}

- (NSUInteger)codeFromRule {

    NSUInteger code = 0;
    for(int i = 0; i < 8; ++i)
        code += ruleCArray[i] << i;
    
    return code;
}


/////////////////////////
#pragma mark - Evolution
/////////////////////////

- (char)nextStateFromLeft:(char)ell center:(char)c right:(char)r {
    if(ell < 0 || ell > 1 || c < 0 || c > 1 || r < 0 || r > 1) {
        NSLog(@"Warning: non-binary values in triplet");
        return 0;
    }
    else
        return r + 2*c + 4*ell;
}

- (void)evolutionStep {
    NSMutableArray *nextCellTape = [NSMutableArray array];
    NSUInteger tapeLength = [self.cellTape count];
    char state;
    
    // We prevent left border reflection
    if([self codeFromRule] % 2)
        [nextCellTape addObject:[NSNumber numberWithChar:0]];
    else
        [nextCellTape addObject:[NSNumber numberWithChar:1]];
    
    // We calculate the non-border cells as usual
    for(int i = 1; i < tapeLength-1; ++i) {
        state = [self nextStateFromLeft:[self.cellTape[i-1] charValue] center:[self.cellTape[i] charValue] right:[self.cellTape[i+1] charValue]];
        [nextCellTape addObject:[NSNumber numberWithChar:state]];
    }
    
    // We prevent right border reflection
    if([self codeFromRule] % 2)
        [nextCellTape addObject:[NSNumber numberWithChar:0]];
    else
        [nextCellTape addObject:[NSNumber numberWithChar:1]];
    
    self.cellTape = nextCellTape;
}


@end
