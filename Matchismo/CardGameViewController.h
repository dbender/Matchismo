//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Duane Bender on 2/24/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

// Abstract methods. Must be implemented in subclass
- (Deck *) createDeck;
- (void) updateResultsLabel:(NSString *) result;
-(void)updateCardButton:(UIButton *)cardButton withCard:(Card *)card;

// Abstract properties. Must be set by subclass
@property (nonatomic, readonly) NSUInteger startingCardCount;
@property (nonatomic, readonly) NSUInteger cardsToMatch;
@property (nonatomic, readonly) NSUInteger matchBonus;
@property (nonatomic, readonly) NSUInteger mismatchPenalty;
@property (nonatomic, readonly) NSUInteger flipCost;
@property (nonatomic, readonly) NSString *name;


@end
