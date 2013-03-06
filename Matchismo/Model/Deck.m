//
//  Deck.m
//  Matchismo
//
//  Created by Duane Bender on 2/25/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray  *) cards {
    // Lazily instantiate a new deck of cards
    if (!_cards) 
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void) addCard:(Card *) card atTop:(BOOL) atTop {
    // Add the new card at top or bottom of self (the deck)
    if (atTop)
        [self.cards insertObject:card atIndex:0];
    else
        [self.cards addObject:card];
}

-(Card *) drawRandomCard {
    // Remove and return a random card from self (the deck)
    Card *randomCard = nil;
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
