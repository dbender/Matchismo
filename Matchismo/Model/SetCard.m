//
//  SetCard.m
//  Matchismo
//
//  Created by Duane Bender on 3/5/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
@synthesize symbol = _symbol;

#define SYMBOL_1 @"●" // oval
#define SYMBOL_2 @"■" // squiggle
#define SYMBOL_3 @"▲"  // diamond
#define PATTERN_1 @"open"
#define PATTERN_2 @"solid"
#define PATTERN_3 @"striped"
#define COLOR_1 @"red"
#define COLOR_2 @"green"
#define COLOR_3 @"blue"

-(int)match:(NSArray *)otherCards {
    // Uses NSSets to count distinct characteristics of cards
    // If any characteristic appears on exactly two cards, it's not a set
    
    NSMutableArray *cards = [otherCards mutableCopy];
    [cards addObject:self];
    NSMutableSet *numberSet = [[NSMutableSet alloc] init];
    NSMutableSet *symbolSet = [[NSMutableSet alloc] init];
    NSMutableSet *colorSet = [[NSMutableSet alloc] init];
    NSMutableSet *patternSet = [[NSMutableSet alloc] init];

    for (SetCard* card in cards) {
        [numberSet addObject:card.number];
        [symbolSet addObject:card.symbol];
        [colorSet addObject:card.color];
        [patternSet addObject:card.pattern];
    }
    if ([numberSet count] == 2) return 0;
    if ([symbolSet count] == 2) return 0;
    if ([colorSet count] == 2) return 0;
    if ([patternSet count] == 2) return 0;
    
    return 1;
}

-(NSString *) symbol {
    return _symbol ? _symbol : @"?";
}

-(void) setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol])
        _symbol = symbol;
}

-(NSString *) contents {
    NSString *cardContents = @"";
    for (int i=1; i<=[self.number integerValue]; i++) {
        cardContents = [cardContents stringByAppendingString:self.symbol];
    }
    return cardContents;
}

-(NSString *)description {
    return [self.contents stringByAppendingFormat:@", %@, %@",self.color,self.pattern];
}

+(NSArray *)validColors {
    static NSArray *colors = nil;
    if (!colors) colors = @[COLOR_1,COLOR_2,COLOR_3];
    return colors;
}

+(NSArray *)validSymbols {
    static NSArray *symbols = nil;
    if (!symbols) symbols = @[SYMBOL_1,SYMBOL_2,SYMBOL_3];
    return symbols;
}

+(NSArray *)validPatterns {
    static NSArray *patterns = nil;
    if (!patterns) patterns = @[PATTERN_1,PATTERN_2,PATTERN_3];
    return patterns;
}

-(void) setNumber:(NSNumber*) number {
    if (1 <= [number integerValue] <= 3) {
        _number = number;
    }
}

- (void) setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void) setpattern:(NSString *)pattern {
    if ([[SetCard validPatterns] containsObject:pattern]) {
        _pattern = pattern;
    }
}

@end
