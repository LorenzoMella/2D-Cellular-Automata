//
//  CellularAutomaton.m
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 29/03/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import "CellularAutomaton.h"

#define trueMod(a, b)  ((a) % (b) + (b) * ((a) < 0))

// Border types by name
enum {
    absorbing = 0,
    thoroidal = 1
};


@implementation CellularAutomaton
{
    unsigned int ruleCArray[2][9];  // nextState = rule[currentState][totalLiveCellsAround]
}

@synthesize grid, rule0, rule1;


//////////////////////////////////
#pragma mark Grid inits & setters
//////////////////////////////////


- (id)initWithGrid:(NSMutableArray *)initialGrid andRule:(unsigned int)ruleCode {
    self = [super init];
    if(self) {
        self.grid = initialGrid;
        
        rule0 = [NSMutableArray array];
        rule1 = [NSMutableArray array];
        
        for(int n = 0; n < 18; ++n) {
            if(n % 2 == 0) {
                ruleCArray[0][n / 2] = (ruleCode & (1 << n)) != 0;
                [rule0 addObject:[NSNumber numberWithUnsignedInt:ruleCArray[0][n / 2]]];
            }
            else {
                ruleCArray[1][n / 2] = (ruleCode & (1 << n)) != 0;
                [rule1 addObject:[NSNumber numberWithUnsignedInt:ruleCArray[1][n / 2]]];
            }
        }
    }
    return self;
}


- (void)setWithNWGliderAtI:(NSUInteger)i andJ:(NSUInteger)j {
    // We set everything to zero
    for(int h = 0; h < GRID_DIMENSION; ++h)
        for(int k = 0; k < GRID_DIMENSION; ++k)
            [grid[h][k] setCellState:0];
        
    // Drawing the glider
    
    [grid[i][j] changeState];
    [grid[i][j + 1] changeState];
    [grid[i][j + 2] changeState];
    [grid[i + 1][j + 2] changeState];
    [grid[i + 2][j + 1] changeState];
}

- (id)initWithNWGliderAtI:(NSUInteger)i andJ:(NSUInteger)j {

    NSMutableArray *initialGrid = [NSMutableArray array];
    
    // Initialize everything to zero
    for(int h = 0; h < GRID_DIMENSION; ++h) {
        NSMutableArray *row = [NSMutableArray array];
        for(int k = 0; k < GRID_DIMENSION; ++k) {
            [row addObject:[[Cell alloc] initWithState:0]];
        }
        [initialGrid addObject:row];
    }
    // Build a glider facing South-East
    [initialGrid[i][j] setCellState:1];
    [initialGrid[i][j + 1] setCellState:1];
    [initialGrid[i][j + 2] setCellState:1];
    [initialGrid[i + 1][j + 2] setCellState:1];
    [initialGrid[i + 2][j + 1] setCellState:1];
    
    // Let's log the beast
    for(int h = 0; h < GRID_DIMENSION; ++h, puts("")) {
        for(int k = 0; k < GRID_DIMENSION; ++k) {
            printf("%d", [initialGrid[h][k] cellState]);
        }
    }
    puts("");

    return [self initWithGrid:initialGrid andRule:224];
}

- (id)initWithZeroes {

    NSMutableArray *initialGrid = [NSMutableArray array];
    
    // We create and then return a "zero grid".
    for(int i = 0; i < GRID_DIMENSION; ++i) {
        NSMutableArray *row = [NSMutableArray array];
        for(int j = 0; j < GRID_DIMENSION; ++j) {
            [row addObject:[[Cell alloc] initWithState:0]];
        }
        [initialGrid addObject:row];
    }
    return [self initWithGrid:initialGrid andRule:224];
}

- (id)initWithCStrings:(char **)CStringGrid {

    NSMutableArray *initialGrid = [NSMutableArray array];
    
    // We create and then return a "zero grid".
    for(int i = 0; i < GRID_DIMENSION; ++i) {
        NSMutableArray *row = [NSMutableArray array];
        for(int j = 0; j < GRID_DIMENSION; ++j) {
            char stateFromString = CStringGrid[i][j] == '1';
            [row addObject:[[Cell alloc] initWithState:stateFromString]];
        }
        [initialGrid addObject:row];
    }
    return [self initWithGrid:initialGrid andRule:224];
    
}


/////////////////////////////////////////////
#pragma mark Rule accessors & code retriever
/////////////////////////////////////////////

- (void)setRuleWithCode:(unsigned int)ruleCode {
    for(int n = 0; n < 18; ++n)
        if(n % 2 == 0) {
            ruleCArray[0][n / 2] = (ruleCode & (1 << n)) != 0;
            [rule0 replaceObjectAtIndex:n/2 withObject:[NSNumber numberWithUnsignedInt:ruleCArray[0][n / 2]]];
        }
        else {
            ruleCArray[1][n / 2] = (ruleCode & (1 << n)) != 0;
            [rule1 replaceObjectAtIndex:n / 2 withObject:[NSNumber numberWithUnsignedInt:ruleCArray[1][n / 2]]];
        }
}

- (unsigned int)readRuleCode {
    
    unsigned int ruleCode = 0;
    
    // ruleCode in binary form:
    //
    //      1    8
    //      SUM  SUM rule[s][t] * 2^(2*t + s)
    //      s=0  t=0
    
    for(int total = 0; total <= 8; ++total) {
        ruleCode += ruleCArray[0][total] == 1 ? (1 << (total << 1)) : 0;
        ruleCode += ruleCArray[1][total] == 1 ? (1 << ((total << 1) + 1)) : 0;
    }
    return ruleCode;
}

- (void)setRule0:(NSMutableArray *)newRule0 {
    rule0 = newRule0;
    for(int j = 0; j < 9; ++j)
        ruleCArray[0][j] = [newRule0[j] unsignedIntValue];
}

- (NSMutableArray *)rule0 {
    return rule0;
}

- (void)setRule1:(NSMutableArray *)newRule1 {
    rule1 = newRule1;
    for(int j = 0; j < 9; ++j)
        ruleCArray[1][j] = [newRule1[j] unsignedIntValue];
}

- (NSMutableArray *)rule1 {
    return rule1;
}

////////////////////////////////////
#pragma mark Next state calculators
////////////////////////////////////

- (char)nextStateFromState:(char)s andTotal:(NSUInteger)t {
    return ruleCArray[s][t];
}

- (void)evolutionStepWithBorderType:(int)borderType {
    
    static NSInteger devI[8], devJ[8];
    
    devI[0] = 0; devJ[0] = 1;           //
    devI[1] = 1; devJ[1] = 1;           //      
    devI[2] = 1; devJ[2] = 0;           //      Indices:
    devI[3] = 1; devJ[3] = -1;          //
    devI[4] = 0; devJ[4] = -1;          //       7 0 1
    devI[5] = -1; devJ[5] = -1;         //       6 @ 2
    devI[6] = -1; devJ[6] = 0;          //       5 4 3
    devI[7] = -1; devJ[7] = 1;          //
    
    CellularAutomaton *nextAutomaton = [[CellularAutomaton alloc] initWithZeroes];
    NSUInteger total = 0;
    
    // Calculating the inner part
    for(int h = 0; h < GRID_DIMENSION; ++h)
        for(int k = 0; k < GRID_DIMENSION; ++k) {
            // Counts ones in the 8 adjacent cells; stores in total
            total = 0;
            for(int n = 0; n < 8; ++n)
                total+= [grid[trueMod(h+devI[n], GRID_DIMENSION)][trueMod(k+devJ[n], GRID_DIMENSION)] cellState];

            // Given the total number of ones around [i][j], we apply the present rule to the cell
            [nextAutomaton.grid[h][k] setCellState:[self nextStateFromState:[grid[h][k] cellState] andTotal:total]];
        }
    /*
    // Calculating border cells depending on border type
    switch(borderType) {
        case thoroidal:
            {
            for(int h = 1; h < GRID_DIMENSION-1; ++h) {
                // Calculating cells in grid[h][0]
                total = 0;
                total += [grid[h-1][0] cellState];  // position 6
                total += [grid[h-1][1] cellState];  // position 7
                for(int n = 0; n <= 2; ++n)
                    total += [grid[h+devI[n]][devJ[n]] cellState];
                for(int n = 3; n <= 5; ++n)
                    total += [grid[h+devI[n]][GRID_DIMENSION-1] cellState];
                [nextAutomaton.grid[h][0] setCellState:[self nextStateFromState:[grid[h][0] cellState] andTotal:total]];
                
                // Calculating cells in grid[h][GRID_DIMENSION-1]
                total = 0;
                total += [grid[h-1][0] cellState];  // position 7
                for(int n = 0; n <= 1; ++n)
                    total += [grid[h+devI[n]][0] cellState];
                for(int n = 2; n <= 6; ++n)
                    total += [grid[h+devI[n]][GRID_DIMENSION-1+devJ[n]] cellState];
                [nextAutomaton.grid[h][GRID_DIMENSION-1] setCellState:[self nextStateFromState:[grid[h][GRID_DIMENSION-1] cellState] andTotal:total]];
                
            }
            
            for(int k = 1; k < GRID_DIMENSION-1; ++k) {
                // Calculating cells in grid[0][k]
                total = 0;
                for(int n = 0; n <= 4; ++n)
                    total += [grid[devI[n]][k+devJ[n]] cellState];
                for(int n = 5; n <= 7; ++n)
                    total += [grid[GRID_DIMENSION-1][k+devJ[n]] cellState];
                [nextAutomaton.grid[0][k] setCellState:[self nextStateFromState:[grid[0][k] cellState] andTotal:total]];
                
                // Calculating cells in grid[GRID_DIMENSION-1][k]
                total = 0;
                for(int n = 1; n <= 3; ++n)
                    total += [grid[0][k+devJ[n]] cellState];
                for(int n = 4; n <= 7; ++n)
                    total += [grid[GRID_DIMENSION-1+devI[n]][k+devJ[n]] cellState];
                total += [grid[GRID_DIMENSION-1][k+1] cellState]; // position 0
                [nextAutomaton.grid[GRID_DIMENSION-1][k] setCellState:[self nextStateFromState:[grid[GRID_DIMENSION-1][k] cellState] andTotal:total]];
                
            }
            
            // The 4 vertices, at last!
            total = 0;
            for(int n = 0; n <= 2; ++n)
                total += [grid[devI[n]][devJ[n]] cellState];
            total += [grid[1][GRID_DIMENSION-1] cellState];     // position 3
            total += [grid[0][GRID_DIMENSION-1] cellState];     // position 4
            total += [grid[GRID_DIMENSION-1][GRID_DIMENSION-1] cellState]; // position 5
            total += [grid[GRID_DIMENSION-1][0] cellState];     // position 6
            total += [grid[GRID_DIMENSION-1][1] cellState];     // position 7
            [nextAutomaton.grid[0][0] setCellState:[self nextStateFromState:[grid[0][0] cellState] andTotal:total]];
            
            total = 0;
            for(int n = 2; n <= 4; ++n)
                total += [grid[devI[n]][GRID_DIMENSION-1+devJ[n]] cellState];
            total += [grid[GRID_DIMENSION-1][GRID_DIMENSION-1] cellState];  // position 6
            total += [grid[GRID_DIMENSION-1][GRID_DIMENSION-2] cellState];  // position 5
            total += [grid[GRID_DIMENSION-1][0] cellState];                 // position 7
            total += [grid[0][0] cellState];                                // position 0
            total += [grid[1][0] cellState];                                // position 1
            [nextAutomaton.grid[0][GRID_DIMENSION-1] setCellState:[self nextStateFromState:[grid[0][GRID_DIMENSION-1] cellState] andTotal:total]];
            
            total = 0;
            for(int n = 4; n <= 6; ++n)
                total += [grid[GRID_DIMENSION-1+devI[n]][GRID_DIMENSION-1+devJ[n]] cellState];
            total += [grid[GRID_DIMENSION-2][0] cellState]; // position 7
            total += [grid[GRID_DIMENSION-1][0] cellState]; // position 0
            total += [grid[0][0] cellState];                // position 1
            total += [grid[0][GRID_DIMENSION-1] cellState]; // position 2
            total += [grid[0][GRID_DIMENSION-2] cellState]; // position 3
            [nextAutomaton.grid[GRID_DIMENSION-1][GRID_DIMENSION-1] setCellState:[self nextStateFromState:[grid[GRID_DIMENSION-1][GRID_DIMENSION-1] cellState] andTotal:total]];
            
            total = 0;
            total += [grid[GRID_DIMENSION-2][0] cellState]; // position 6
            total += [grid[GRID_DIMENSION-2][1] cellState]; // position 7
            total += [grid[GRID_DIMENSION-1][1] cellState]; // position 0
            total += [grid[0][1] cellState];                // position 1
            total += [grid[0][0] cellState];                // position 2
            total += [grid[0][GRID_DIMENSION-1] cellState]; // position 3
            total += [grid[GRID_DIMENSION-2][GRID_DIMENSION-1] cellState];  // position 4
            total += [grid[GRID_DIMENSION-1][GRID_DIMENSION-1] cellState];  // position 5
            [nextAutomaton.grid[GRID_DIMENSION-1][0] setCellState:[self nextStateFromState:[grid[GRID_DIMENSION-1][0] cellState] andTotal:total]];
            }
            break;
        case absorbing: // (should be checked for errors)
            {
            for(int h = 1; h < GRID_DIMENSION-1; ++h) {
                // Calculating cells in grid[h][0]
                total = 0;
                total += [grid[h-1][0] cellState];  // position 6
                total += [grid[h-1][1] cellState];  // position 7
                for(int n = 0; n <= 2; ++n)
                    total += [grid[h+devI[n]][devJ[n]] cellState];
                [nextAutomaton.grid[h][0] setCellState:[self nextStateFromState:[grid[h][0] cellState] andTotal:total]];
                
                // Calculating cells in grid[h][GRID_DIMENSION-1]
                total = 0;
                for(int n = 2; n <= 6; ++n)
                    total += [grid[h+devI[n]][GRID_DIMENSION-1+devJ[n]] cellState];
                [nextAutomaton.grid[h][GRID_DIMENSION-1] setCellState:[self nextStateFromState:[grid[h][GRID_DIMENSION-1] cellState] andTotal:total]];
                
            }
            
            for(int k = 1; k < GRID_DIMENSION-1; ++k) {
                // Calculating cells in grid[0][k]
                total = 0;
                for(int n = 0; n <= 4; ++n)
                    total += [grid[devI[n]][k+devJ[n]] cellState];
                [nextAutomaton.grid[0][k] setCellState:[self nextStateFromState:[grid[0][k] cellState] andTotal:total]];
                
                // Calculating cells in grid[GRID_DIMENSION-1][k]
                total = 0;
                for(int n = 4; n <= 7; ++n)
                    total += [grid[GRID_DIMENSION-1+devI[n]][k+devJ[n]] cellState];
                total += [grid[GRID_DIMENSION-1][k+1] cellState]; // position 0
                [nextAutomaton.grid[GRID_DIMENSION-1][k] setCellState:[self nextStateFromState:[grid[GRID_DIMENSION-1][k] cellState] andTotal:total]];
                
            }
            
            // The 4 vertices, at last!
            total = 0;
            for(int n = 0; n <= 2; ++n)
                total += [grid[devI[n]][devJ[n]] cellState];
            [nextAutomaton.grid[0][0] setCellState:[self nextStateFromState:[grid[0][0] cellState] andTotal:total]];
            
            total = 0;
            for(int n = 2; n <= 4; ++n)
                total += [grid[devI[n]][GRID_DIMENSION-1+devJ[n]] cellState];
            [nextAutomaton.grid[0][GRID_DIMENSION-1] setCellState:[self nextStateFromState:[grid[0][GRID_DIMENSION-1] cellState] andTotal:total]];
            
            total = 0;
            for(int n = 4; n <= 6; ++n)
                total += [grid[GRID_DIMENSION-1+devI[n]][GRID_DIMENSION-1+devJ[n]] cellState];
            [nextAutomaton.grid[GRID_DIMENSION-1][GRID_DIMENSION-1] setCellState:[self nextStateFromState:[grid[GRID_DIMENSION-1][GRID_DIMENSION-1] cellState] andTotal:total]];
            
            total = 0;
            total += [grid[GRID_DIMENSION-2][0] cellState]; // position 6
            total += [grid[GRID_DIMENSION-2][1] cellState]; // position 7
            total += [grid[GRID_DIMENSION-1][1] cellState]; // position 0
            [nextAutomaton.grid[GRID_DIMENSION-1][0] setCellState:[self nextStateFromState:[grid[GRID_DIMENSION-1][0] cellState] andTotal:total]];
            }
            break;
    }*/
    
    self.grid = nextAutomaton.grid;
}

@end
