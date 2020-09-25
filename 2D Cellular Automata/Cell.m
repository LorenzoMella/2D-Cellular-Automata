//
//  Cell.m
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 30/03/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import "Cell.h"

@implementation Cell

@synthesize cellState;

- (id)initWithState:(char)value {
    self = [super init];
    
    if(self)
        self.cellState = value;

    return self;
}

- (id)init {
    return [self initWithState:0];
}

-(void)changeState {
    self.cellState = (self.cellState == 0 ? 1 : 0);
}

@end
