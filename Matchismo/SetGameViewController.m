//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Duane Bender on 3/5/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "SetCard.h"

@implementation SetGameViewController

- (void) setup {
    // Anything needed before viewDidLoad
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) awakeFromNib {
    [self setup];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

// Begin implementation of CardGameViewController abstract methods
- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (NSUInteger) startingCardCount {
    return [self.cardButtons count];
}

- (NSUInteger) cardsToMatch {
    return 3;
}

- (NSUInteger) matchBonus {
    return 8;
}

-(NSUInteger) mismatchPenalty {
    return 4;
}

- (NSUInteger) flipCost {
    return 1;
}

-(void)updateCardButton:(UIButton *)cardButton withCard:(Card *)card {
    NSAttributedString *cardButtonTitle = [[NSAttributedString alloc] initWithString:card.contents attributes:[self getAttributesFromCard:card]];
    [cardButton setAttributedTitle:cardButtonTitle forState:UIControlStateNormal];
    [cardButton setBackgroundColor:(cardButton.selected) ? [UIColor blueColor] : nil];
    
    cardButton.alpha = (card.isUnplayable) ? 0.0 : 1.0;
}

-(void) updateResultsLabel:(NSString *) result {
    self.resultsLabel.text = result;
}
// End abstract method implementations

-(NSDictionary *)getAttributesFromCard:(Card *)card {
    NSDictionary *attributes = nil;
    UIColor *color = nil;
    
    if ([card isKindOfClass:[SetCard class]]){
        
        SetCard *setCard = (SetCard *)card;
        
        //setting color
        if ([setCard.color isEqualToString:@"red"]) {
            color = [UIColor redColor];
        } else if ([setCard.color isEqualToString:@"green"]) {
            color = [UIColor greenColor];
        } else if ([setCard.color isEqualToString:@"blue"]) {
            color = [UIColor blueColor];
        }
        
        //setting pattern and creating output
        if ([setCard.pattern isEqualToString:@"solid"]) {
            attributes = @{NSForegroundColorAttributeName: color};
        } else if ([setCard.pattern isEqualToString:@"striped"]) {
            attributes = @{NSStrokeColorAttributeName: color,NSStrokeWidthAttributeName: @(-5), NSForegroundColorAttributeName:[color colorWithAlphaComponent:0.2F]};
        } else if ([setCard.pattern isEqualToString:@"open"]) {
            attributes = @{NSStrokeColorAttributeName: color,NSStrokeWidthAttributeName: @(5)};
        }
    }
    
    return attributes;
    
}

- (NSMutableAttributedString *) getCardsFlippedContents:(NSArray *)cardsFlipped {
    NSMutableAttributedString *cardContents = [[NSMutableAttributedString alloc] initWithString:@""];
    
    if (cardsFlipped) {
        
        SetCard *card = nil;
        
        for (int i = 0;  i < [cardsFlipped count]; i++) {
            
            if ([cardsFlipped[i] isKindOfClass:[SetCard class]]) {
                card = (SetCard *)cardsFlipped[i];
                [cardContents appendAttributedString:[[NSAttributedString alloc] initWithString:card.contents attributes:[self getAttributesFromCard:card]]];
                
                if (i < [cardsFlipped count] - 1) {
                    [cardContents appendAttributedString:[[NSAttributedString alloc] initWithString:@","]];//separator
                }
            }
        }
    }
    return cardContents;
}

@end
