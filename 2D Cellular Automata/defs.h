//
//  defs.h
//  2D Cellular Automata
//
//  Created by Lorenzo Mella on 28/03/2021.
//  Copyright © 2021 Lorenzo Mella. All rights reserved.
//

#ifndef defs_h
#define defs_h


#define GRID_DIMENSION      200  // Number of cells per row/column
#define NUM_NEIGHBORS       9    // Neighbors, including the central cell
#define EXAMPLE_RULE        224  // Rule used on initialization


// Border types by name
enum BorderType {
    ABSORBING = 0,
    THOROIDAL
};

#endif /* defs_h */
