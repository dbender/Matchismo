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

#define CLEAR @0.0
#define SHADED @0.5
#define SOLID @1.0

-(int)match:(NSArray *)otherCards {
    NSMutableArray *cards = [otherCards mutableCopy];
    [cards addObject:self];
    NSCountedSet *numberSet = [[NSCountedSet alloc] init];
    NSCountedSet *symbolSet = [[NSCountedSet alloc] init];
    NSCountedSet *colorSet = [[NSCountedSet alloc] init];
    NSCountedSet *shadingSet = [[NSCountedSet alloc] init];
    
    for (SetCard* card in cards) {
        [numberSet addObject:card.number];
        [symbolSet addObject:card.symbol];
        [colorSet addObject:card.color];
        [shadingSet addObject:card.shading];
    }
    if (numberSet.count == 2) return 0;
    if (symbolSet.count == 2) return 0;
    if (colorSet.count == 2) return 0;
    if (shadingSet.count == 2) return 0;
    return 10;
}


//TO_DO: Return correct contents of setCard
- (NSString *) contents {
    NSString *contents = self.symbol;
    return contents;
}

-(void) setNumber:(NSNumber*) number {
    if (1 <= [number integerValue] <= 3) {
        _number = number;
    }
}

-(void) setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol])
        _symbol = symbol;
}

- (void) setShading:(NSNumber *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (void) setColor:(UIColor *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

-(NSString *) symbol {
    return _symbol ? _symbol : @"?";
}


+(NSArray *) validSymbols{
    static NSArray *validSymbols = nil;
    if (!validSymbols) {
        validSymbols = @[@"△",@"○",@"☐"];
    }
    return validSymbols;
}

+(NSArray *) validShadings {
    static NSArray *validShadings = nil;
    if (!validShadings) {
        validShadings = @[CLEAR,SHADED,SOLID];
    }
    return validShadings;
}

+(NSArray *) validColors {
    static NSArray *validColors = nil;
    if (!validColors) {
        validColors = @[[UIColor blueColor],[UIColor redColor],[UIColor greenColor]];
    }
    return validColors;
}



@end
