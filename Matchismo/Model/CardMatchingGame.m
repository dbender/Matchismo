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
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id) initWithCardCount: (NSUInteger) cardCount usingDeck: (Deck *) deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            }
            else {
                self.cards[i] = card;
            }
        }
    }
    self.gameMode = TWO_CARD_MODE;
    return self;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

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
                self.score += matchScore * MATCH_BONUS;
                self.result =[NSString stringWithFormat:@"Matched %@ and %@ for %d points!",[upCards componentsJoinedByString:@", "],card.contents, matchScore * MATCH_BONUS];
            } else {
                for (Card *otherCard in upCards) {
                    otherCard.faceUp = NO;
                }
                self.score -= MISMATCH_PENALTY;
                self.result = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!",[upCards componentsJoinedByString:@", "],card.contents,MISMATCH_PENALTY];
            }
        } else {
            self.result = [NSString stringWithFormat:@"Flipped up %@",card.contents];
        }
        self.score -= FLIP_COST;
    }
    card.faceUp = !card.faceUp;
}

- (Card *) cardAtIndex: (NSUInteger) index {
    return (index < self.cards.count ? self.cards[index] : nil);
}


@end
