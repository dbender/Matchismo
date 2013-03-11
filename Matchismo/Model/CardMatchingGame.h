//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Duane Bender on 2/25/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id)initWithCardCount:(NSUInteger)count //How many cards in a deck?
              usingDeck:(Deck *)deck
           cardsToMatch:(NSUInteger)numCards //Match how many cards?
             matchBonus:(NSUInteger)matchBonus //How many points for match?
        mismatchPenalty:(NSUInteger)mismatchPenalty //How many points deducted for mismatch?
               flipCost:(NSUInteger)flipCost //How many points deducted for each card flip?
                   name:(NSString *)name;

-(NSDictionary *)flipCardAtIndex:(NSUInteger)index;

- (Card *) cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) int score;

@end
