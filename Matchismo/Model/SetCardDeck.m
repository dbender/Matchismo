//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Duane Bender on 3/5/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(id) init {
    // Initialize a standard deck of 52 playing cards
    self = [super init];
    if (self) {
        for (int i = 1; i <= 3; i++)
            for (NSString *symbol in [SetCard validSymbols])
                for (UIColor *color in [SetCard validColors])
                    for (NSNumber *shading in [SetCard validShadings]) {
                        SetCard *card = [[SetCard alloc]init];
                        card.number = [NSNumber numberWithInt:i];
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                    }
    }
    return self;
}

@end
