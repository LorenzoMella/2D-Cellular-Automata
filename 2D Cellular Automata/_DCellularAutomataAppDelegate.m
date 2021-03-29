//
//  _DCellularAutomataAppDelegate.m
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 29/03/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import "_DCellularAutomataAppDelegate.h"


@implementation _DCellularAutomataAppDelegate
{
    enum BorderType borderType;
    NSTimer *timer;
    NSTimer *demoTimer;
}

@synthesize automatonView;
@synthesize ruleCodeField;
@synthesize ruleCode;
@synthesize currentAutomaton;
@synthesize testArray;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.currentAutomaton = [[CellularAutomaton alloc] initWithNWGliderAtI:GRID_DIMENSION / 2 andJ:GRID_DIMENSION / 2];
    ruleCode = EXAMPLE_RULE;
    [self.currentAutomaton setRuleWithCode:ruleCode];
    [ruleCodeField setIntegerValue:ruleCode];
    [self.automatonView setGrid:[currentAutomaton grid]];
    self.automatonView.liveCellColor = [NSColor yellowColor];
    self.automatonView.deadCellColor = [NSColor colorWithCalibratedHue:0.5 saturation:0.62 brightness:0.32 alpha:1.0];
    [self.automatonView setNeedsDisplay:YES];
}


/////////////////////
#pragma mark Buttons
/////////////////////

- (IBAction)stepButton:(id)sender {
    NSLog(@"Step pressed");
    [self stepManager];
    NSLog(@"testArray: %@", testArray);
}

- (IBAction)startStop:(id)sender {
    
    if (timer == nil) {
        NSLog(@"Start pressed");
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(stepManager) userInfo:nil repeats:YES];
    } else {
        NSLog(@"Stop pressed");
        [timer invalidate];
        timer = nil;
    }
}

- (IBAction)erase:(id)sender {
    [self.currentAutomaton setWithNWGliderAtI:GRID_DIMENSION/2 andJ:GRID_DIMENSION/2];
    [self.automatonView setNeedsDisplay:YES];
}

- (IBAction)demonstration:(id)sender {
    
    if (demoTimer == nil) {
        NSLog(@"Demonstration pressed");
        demoTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(demoManager) userInfo:nil repeats:YES];
    } else {
        NSLog(@"Demonstration pressed again");
        [timer invalidate];
        [demoTimer invalidate];
        demoTimer = nil;
    }

}

- (void)demoManager {
    static int currentRule = EXAMPLE_RULE;
    
    ruleCode = currentRule;
    
    if (timer)
        [timer invalidate];
    
    [self erase:self];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(stepManager) userInfo:nil repeats:YES];
    currentRule += 2;
    [ruleCodeField setIntegerValue:ruleCode];
}


- (void)stepManager {
    [self.currentAutomaton evolutionStepWithBorderType:borderType];
    
    if (0 <= ruleCode && ruleCode < 262144) {
        [self.currentAutomaton setRuleWithCode:ruleCode];
    } else {
        [ruleCodeField setIntValue:EXAMPLE_RULE];
        [self.currentAutomaton setRuleWithCode:EXAMPLE_RULE];
    }
    
    for(int t = 0; t < 9; ++t) {
        [self.zeroCheckBoxes setState:[self.currentAutomaton nextStateFromState:0 andTotal:t] atRow:8-t column:0];
        [self.oneCheckBoxes setState:[self.currentAutomaton nextStateFromState:1 andTotal:t] atRow:8-t column:0];
    }
    
    [self.automatonView setGrid:[currentAutomaton grid]];
    [self.automatonView setNeedsDisplay:YES];
}

@end
