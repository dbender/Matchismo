//
//  MatchGameViewController.m
//  Matchismo
//
//  Created by Duane Bender on 3/5/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "MatchGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@implementation MatchGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

// Begin implementation of CardGameViewController abstract methods
- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger) startingCardCount {
    return [self.cardButtons count];
}

- (NSUInteger) cardsToMatch {
    return 2;
}

- (NSUInteger) matchBonus {
    return 4;
}

-(NSUInteger) mismatchPenalty {
    return 2;
}

- (NSUInteger) flipCost {
    return 1;
}

- (NSString *) name {
    return @"Match";
}

-(void)updateCardButton:(UIButton *)cardButton withCard:(Card *)card {
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    UIImage *cardImage = [UIImage imageNamed:@"card-back.png"];
    [cardButton setImage:cardImage forState:UIControlStateNormal];
    cardButton.imageEdgeInsets = UIEdgeInsetsFromString(@"{1.0,1.0,1.0,1.0}");
    UIImage *blankImage = [[UIImage alloc]init];
    [cardButton setImage:blankImage forState:UIControlStateSelected];
    [cardButton setImage:blankImage forState:UIControlStateSelected|UIControlStateDisabled];
    cardButton.alpha = (card.isUnplayable) ? 0.3 : 1.0;
}

-(void) updateResultsLabel:(NSString *) result {
        self.resultsLabel.text = result;
}

// End abstract method implementations

@end


