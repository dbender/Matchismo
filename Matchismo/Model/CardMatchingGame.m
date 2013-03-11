//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Duane Bender on 2/25/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) NSUInteger gameMode;
@property (nonatomic) NSUInteger flipCost;
@property (nonatomic) NSUInteger matchBonus;
@property (nonatomic) NSUInteger mismatchPenalty;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
           cardsToMatch:(NSUInteger)numCards
             matchBonus:(NSUInteger)matchBonus
        mismatchPenalty:(NSUInteger)mismatchPenalty
               flipCost:(NSUInteger)flipCost
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        if (numCards >=2)
            self.gameMode = numCards;
        
        self.matchBonus = matchBonus;
        self.mismatchPenalty = mismatchPenalty;
        self.flipCost = flipCost;
    }
    return self;
}

-(NSDictionary *)flipCardAtIndex:(NSUInteger)index {
    BOOL matchAttempted = NO;
    BOOL match = NO;
    Card *card = [self cardAtIndex:index];
    int matchScore = 0;;
    NSMutableArray *upCards = [[NSMutableArray alloc] init];
    if (card && !card.isFaceUp) {
        for (Card *otherCard in self.cards)
            if (otherCard.isFaceUp && !otherCard.isUnplayable)
                [upCards addObject:otherCard];
        if ([upCards count] + 1 == self.gameMode) {
            matchScore = [card match:upCards];
            matchAttempted = YES;
            if (matchScore) {
                card.unplayable = YES;
                for (Card *otherCard in upCards) {
                    otherCard.unplayable = YES;
                }
                matchScore *= self.matchBonus;
                self.score += matchScore;
                match = YES;
            } else {
                for (Card *otherCard in upCards) {
                    otherCard.faceUp = NO;
                }
                self.score -= self.mismatchPenalty;
                match = NO;
            }
        }
        self.score -= self.flipCost;
    }
    card.faceUp = !card.faceUp;
    NSDictionary *resultOfFlip = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithBool:matchAttempted], @"matchAttempted",
                                  upCards, @"upCards",
                                  [NSNumber numberWithBool:match], @"match",
                                  [NSNumber numberWithInt:matchScore], @"matchScore",nil];
    return resultOfFlip;
}

- (Card *) cardAtIndex: (NSUInteger) index {
    return (index < [self.cards count] ? self.cards[index] : nil);
}


@end
