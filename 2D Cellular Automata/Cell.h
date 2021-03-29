//
//  Cell.h
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 30/03/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject

@property char cellState;

- (id)initWithState:(char)value;
- (void)changeState;

@end
