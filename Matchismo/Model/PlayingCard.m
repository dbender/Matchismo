//
//  PlayingCard.m
//  Matchismo
//
//  Created by Duane Bender on 2/25/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    NSMutableArray *otherUpCards = [otherCards mutableCopy];
    for (PlayingCard *otherCard in otherUpCards) {
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            if ([self.suit isEqualToString:otherCard.suit])
                score += 1;
            else if (self.rank == otherCard.rank)
                score += 4;
        }
    }
    PlayingCard *lastCard = [otherUpCards lastObject];
    if (lastCard) {
        [otherUpCards removeLastObject];
        score += [lastCard match:otherUpCards];
    } 
    return score;
}

-(NSString *) contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

-(void) setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit])
        _suit = suit;
}

-(NSString *) suit {
    return _suit ? _suit : @"?";
}

-(void) setRank:(NSUInteger)rank {
    if (1 <= rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

+(NSArray *) validSuits{
    static NSArray *validSuits = nil;
    if (!validSuits) {
        validSuits = @[@"♣",@"♠",@"♥",@"♦"];
    }
    return validSuits;
    
}

+(NSUInteger) maxRank{
    return 13;
}

+(NSArray *) rankStrings {
    static NSArray *rankStrings = nil;
    if (!rankStrings) {
        rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    }
    return rankStrings;
}

@end
