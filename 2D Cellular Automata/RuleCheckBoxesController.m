//
//  RuleCheckBoxesController.m
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 26/04/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import "RuleCheckBoxesController.h"

@implementation RuleCheckBoxesController

@synthesize ruleCodeField;


- (IBAction)s0t0Press:(id)sender{
    if([[sender cellAtRow:0 column:0] state] != NSOffState)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 1];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 1];
}
- (IBAction)s0t1Press:(id)sender{
    if([[sender cellAtRow:1 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 4];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 4];
}
- (IBAction)s0t2Press:(id)sender{
    if([[sender cellAtRow:2 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 16];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 16];
}
- (IBAction)s0t3Press:(id)sender{
    if([[sender cellAtRow:3 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 64];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 64];
}
- (IBAction)s0t4Press:(id)sender{
    if([[sender cellAtRow:4 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 256];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 256];
}
- (IBAction)s0t5Press:(id)sender{
    if([[sender cellAtRow:5 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 1024];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 1024];
}
- (IBAction)s0t6Press:(id)sender{
    if([[sender cellAtRow:6 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 4096];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 4096];
}
- (IBAction)s0t7Press:(id)sender{
    if([[sender cellAtRow:7 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 16384];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 16384];
}
- (IBAction)s0t8Press:(id)sender{
    if([[sender cellAtRow:8 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 65536];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 65536];
}


- (IBAction)s1t0Press:(id)sender{
    if([[sender cellAtRow:0 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 2];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 2];
}
- (IBAction)s1t1Press:(id)sender{
    if([[sender cellAtRow:1 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 8];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 8];
}
- (IBAction)s1t2Press:(id)sender{
    if([[sender cellAtRow:2 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 32];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 32];
}
- (IBAction)s1t3Press:(id)sender{
    if([[sender cellAtRow:3 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 128];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 128];
}
- (IBAction)s1t4Press:(id)sender{
    if([[sender cellAtRow:4 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 512];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 512];
}
- (IBAction)s1t5Press:(id)sender{
    if([[sender cellAtRow:5 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 2048];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 2048];
}
- (IBAction)s1t6Press:(id)sender{
    if([[sender cellAtRow:6 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 8192];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 8192];    
}
- (IBAction)s1t7Press:(id)sender{
    if([[sender cellAtRow:7 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 32768];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 32768];    
}
- (IBAction)s1t8Press:(id)sender{
    if([[sender cellAtRow:8 column:0] state] != NO)
        [ruleCodeField setIntValue:ruleCodeField.intValue += 131072];
    else
        [ruleCodeField setIntValue:ruleCodeField.intValue -= 131072];
}

@end