//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by Duane Bender on 3/5/13.
//  Copyright (c) 2013 Duane Bender. All rights reserved.
//

//
//  GameResultViewController.m
//  Matchismo
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University.
//  All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;  // wire this up to a UITextView
@property (nonatomic) SEL sortSelector; // added after lecture
@end

@implementation GameResultsViewController

- (void)updateUI
{
    NSString *displayText = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];         
    [formatter setTimeStyle:NSDateFormatterShortStyle];     
    for (GameResult *result in [[GameResult allGameResults] sortedArrayUsingSelector:self.sortSelector]) { 
        displayText = [displayText stringByAppendingFormat:@"Game: %@, Score: %d (%@, %0g)\n",result.name, result.score, [formatter stringFromDate:result.end], round(result.duration)];  // formatted date
    }
    self.display.text = displayText;
}

#pragma mark - View Controller Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

#pragma mark - Sorting

@synthesize sortSelector = _sortSelector;  // because we implement BOTH setter and getter

// return default sort selector if none set (by score)

- (SEL)sortSelector
{
    if (!_sortSelector) _sortSelector = @selector(compareScoreToGameResult:);
    return _sortSelector;
}

// update the UI when changing the sort selector

- (void)setSortSelector:(SEL)sortSelector
{
    _sortSelector = sortSelector;
    [self updateUI];
}

- (IBAction)sortByDate:(id) sender;
{
    self.sortSelector = @selector(compareEndDateToGameResult:);
}

- (IBAction)sortByScore:(id) sender;
{
    self.sortSelector = @selector(compareScoreToGameResult:);
}

- (IBAction)sortByDuration:(id) sender;
{
    self.sortSelector = @selector(compareDurationToGameResult:);
}

#pragma mark - (Unused) Initialization before viewDidLoad

- (void)setup
{
    // initialization that can't wait until viewDidLoad
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

@end

