//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Duane Bender on 2/25/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#define TWO_CARD_MODE 2 // 2-card game mode
#define THREE_CARD_MODE 3 // 3-card game mode

@interface CardMatchingGame : NSObject

- (id) initWithCardCount: (NSUInteger) cardCount usingDeck: (Deck *) deck;
- (void) flipCardAtIndex: (NSUInteger) index;
- (Card *) cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) int score;
@property (strong, nonatomic) NSString *result;
@property (nonatomic) NSUInteger gameMode;

@end
