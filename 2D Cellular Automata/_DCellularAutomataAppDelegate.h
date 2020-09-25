//
//  _DCellularAutomataAppDelegate.h
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 29/03/13.
//  Copyright (c) 2013 Lorenzo Mella. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CellularAutomaton.h"
#import "oneDCellularAutomaton.h"
#import "AutomatonView.h"

@interface _DCellularAutomataAppDelegate : NSObject <NSApplicationDelegate>

// Outlets
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSWindow *rulePanel;
@property (weak) IBOutlet AutomatonView *automatonView;
@property (weak) IBOutlet NSTextField *ruleCodeField;
@property (weak) IBOutlet NSMatrix *zeroCheckBoxes;
@property (weak) IBOutlet NSMatrix *oneCheckBoxes;
// Bound variables
@property int ruleCode;
@property NSMutableArray *testArray;
// Other model variables
@property (strong) CellularAutomaton *currentAutomaton;


- (IBAction)stepButton:(id)sender;
- (IBAction)startStop:(id)sender;
- (IBAction)erase:(id)sender;
- (IBAction)demonstration:(id)sender;

- (void)stepManager;

@end
