//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Duane Bender on 2/24/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSArray *resultsArray;
@property (weak, nonatomic) IBOutlet UISlider *resultsSlider;
@property (nonatomic) NSUInteger displayedResult;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game {
    // Lazily instantiate a card matching game
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}

- (void) loadCardImages {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        UIImage *cardImage = [UIImage imageNamed:@"card-back.png.png"];
        [cardButton setImage:cardImage forState:UIControlStateNormal];
        cardButton.imageEdgeInsets = UIEdgeInsetsFromString(@"{1.0,1.0,1.0,1.0}");
        UIImage *blankImage = [[UIImage alloc] init];
        [cardButton setImage:blankImage forState:UIControlStateSelected];
        [cardButton setImage:blankImage forState:UIControlStateSelected|UIControlStateDisabled];
    }
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self loadCardImages];
    self.resultsSlider.hidden = YES;
}

- (NSArray *) resultsArray {
    if (!_resultsArray) _resultsArray = [[NSArray alloc] init];
    return _resultsArray;
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.gameModeSegmentedControl.selectedSegmentIndex = self.game.gameMode - 2;
    if (self.resultsArray.count > 0) {
        self.resultsSlider.hidden = NO;
        if (self.displayedResult > 0) {
            self.resultsLabel.text = self.resultsArray[self.displayedResult - 1];
        }
    }else {
        self.resultsSlider.hidden = YES;
        self.resultsLabel.text = @"Flip a card.";
    }
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.gameModeSegmentedControl.enabled = NO;
    self.resultsArray = [self.resultsArray arrayByAddingObject:self.game.result];
    self.displayedResult = self.resultsArray.count;
    if (self.displayedResult > 0)
        [self.resultsSlider setValue:self.displayedResult / self.resultsArray.count animated:YES];
    [self updateUI];
}

- (IBAction)dealNewGame:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    self.gameModeSegmentedControl.enabled = YES;
    self.resultsArray = nil;
    [self loadCardImages];
    [self updateUI];
}

- (IBAction)changeCardCount:(id)sender {
    self.game.gameMode = self.gameModeSegmentedControl.selectedSegmentIndex + 2; // Index 0 for 2-card mode, Index 1 for 3-card mode
}
- (IBAction)changeResultToShow:(UISlider *)sender {
    self.displayedResult = floor(self.resultsArray.count * self.resultsSlider.value + 0.5);
    [self updateUI];
}

@end
