//
//  Deck.h
//  Matchismo
//
//  Created by Duane Bender on 2/25/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard:(Card *) card atTop:(BOOL) atTop;
-(Card *) drawRandomCard;

@end
