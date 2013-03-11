//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Duane Bender on 2/24/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSArray *resultsArray;
@property (weak, nonatomic) IBOutlet UISlider *resultsSlider;
@property (nonatomic) NSUInteger displayedResult;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                usingDeck:[self createDeck]
             cardsToMatch:self.cardsToMatch
               matchBonus:self.matchBonus
          mismatchPenalty:self.mismatchPenalty
                 flipCost:self.flipCost];
    return _game;
}

// Abstract methods that must be implemented in sublcass
- (Deck *) createDeck {
    return nil;  //implemented in subclass
}

- (void) updateResultsLabel:(NSString *) result {
    //implemented in subclass
}

-(void)updateCardButton:(UIButton *)cardButton withCard:(Card *)card {
    //implemented in subclass
}
// End abstract methods

- (void) viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    self.resultsSlider.hidden = YES;
    self.resultsLabel.text = @"";
}

- (NSArray *) resultsArray {
    if (!_resultsArray) _resultsArray = [[NSArray alloc] init];
    return _resultsArray;
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        
        [self updateCardButton:cardButton withCard:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"score: %d", self.game.score];
    if ([self.resultsArray count] > 0) {
        self.resultsSlider.hidden = NO;
        if (self.displayedResult > 0)
            [self updateResultsLabel:self.resultsArray[self.displayedResult - 1]];
    }else {
        self.resultsSlider.hidden = YES;
        self.resultsLabel.text = @"";
    }
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    NSDictionary *resultOfFlip = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:sender]];

    self.flipCount++;
    NSString *flipResult = @"Flipped up ";
    flipResult = [flipResult stringByAppendingString:card.contents];
    
    if ([[resultOfFlip valueForKey:@"matchAttempted"]boolValue]) {
        NSArray *upCards = [resultOfFlip valueForKey:@"upCards"];
        int match = [[resultOfFlip valueForKey:@"match"] boolValue];
        int matchScore = [[resultOfFlip valueForKey:@"matchScore"] intValue];
        NSString *upCardString = @"";
        upCardString = [upCards componentsJoinedByString:@" & "];
        if (match) {
            flipResult =[NSString stringWithFormat:@"Matched %@ and %@ for %d points!",upCardString, card.contents, matchScore * self.matchBonus];
        }
        else {
            flipResult = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!",upCardString,card.contents, self.mismatchPenalty];
        }
    }
    NSLog(@"flipResult = %@",flipResult);
    self.resultsArray = [self.resultsArray arrayByAddingObject:flipResult];
    self.displayedResult = [self.resultsArray count];
    
    [self.resultsSlider setValue:1.0 animated:YES];
    [self updateUI];
 
}

- (IBAction)dealNewGame:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    self.resultsArray = nil;
    self.resultsLabel.text = @"";
    [self updateUI];
}

- (IBAction)changeResultToShow:(UISlider *)sender {
    self.displayedResult = floor([self.resultsArray count] * self.resultsSlider.value + 0.5);
    [self updateUI];
}

@end
