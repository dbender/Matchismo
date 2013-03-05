//
//  SetCard.h
//  Matchismo
//
//  Created by Duane Bender on 3/5/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) NSNumber *shading;
@property (strong, nonatomic) UIColor *color;

+(NSArray *) validSymbols;
+(NSArray *) validShadings;
+(NSArray *) validColors;


@end
