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
        if (numCards >=2) {
            self.gameMode = numCards;
        }
    }
    self.matchBonus = matchBonus;
    self.mismatchPenalty = mismatchPenalty;
    self.flipCost = flipCost;
    
    return self;
}


-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *upCards = [[NSMutableArray alloc] init];
    if (card && !card.isFaceUp) {
        for (Card *otherCard in self.cards)
            if (otherCard.isFaceUp && !otherCard.isUnplayable)
                [upCards addObject:otherCard];
        if (upCards.count + 1 == self.gameMode) {
            int matchScore = [card match:upCards];
            if (matchScore) {
                card.unplayable = YES;
                for (Card *otherCard in upCards) {
                    otherCard.unplayable = YES;
                }
                self.score += matchScore * self.matchBonus;
                self.result =[NSString stringWithFormat:@"Matched %@ and %@ for %d points!",[upCards componentsJoinedByString:@", "],card.contents, matchScore * self.matchBonus];
            } else {
                for (Card *otherCard in upCards) {
                    otherCard.faceUp = NO;
                }
                self.score -= self.mismatchPenalty;
                self.result = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!",[upCards componentsJoinedByString:@", "],card.contents,self.mismatchPenalty];
            }
        } else {
            self.result = [NSString stringWithFormat:@"Flipped up %@",card.contents];
        }
        self.score -= self.flipCost;
    }
    card.faceUp = !card.faceUp;
}

- (Card *) cardAtIndex: (NSUInteger) index {
    return (index < self.cards.count ? self.cards[index] : nil);
}


@end
