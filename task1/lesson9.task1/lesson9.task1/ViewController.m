//
//  ViewController.m
//  lesson9.task1
//
//  Created by Maksym Savisko on 12/28/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//View
@property (weak, nonatomic) IBOutlet UIView *firstSquare;
@property (weak, nonatomic) IBOutlet UIView *secondSquare;
@property (weak, nonatomic) IBOutlet UIView *thirdSquare;
@property (weak, nonatomic) IBOutlet UIView *fourthSquare;

//Button
- (IBAction)startButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)resetButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

//Score
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

//Timer
@property (nonatomic) NSTimer *myTimer;

//Current speed of square
@property (nonatomic) NSInteger firstSquareSpeed;
@property (nonatomic) NSInteger secondSquareSpeed;
@property (nonatomic) NSInteger thirdSquareSpeed;
@property (nonatomic) NSInteger fourthSquareSpeed;

//Timer Count
@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSTimeInterval timeIntervalStart;
@property (nonatomic) NSTimeInterval timeIntervalEnd;

//Gesture
- (IBAction)firstGesture:(UITapGestureRecognizer *)sender;
- (IBAction)secondGesture:(UITapGestureRecognizer *)sender;
- (IBAction)thirdGesture:(UISwipeGestureRecognizer *)sender;
- (IBAction)fourthGesture:(UISwipeGestureRecognizer *)sender;


@end

@implementation ViewController

static NSInteger TIMERFORCHANGESPEED = 150;
static NSInteger increaseFirstSquareSpeed = 5;
static NSInteger increaseSecondSquareSpeed = 4;
static NSInteger increaseThirdSquareSpeed = 3.2;
static NSInteger increaseFourthSquareSpeed = 2.56;
static NSInteger finishLine = 160;
static NSInteger startLine = 35;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.scoreLabel.hidden = YES;
    self.resetButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)startButton:(id)sender {
    if ([self.startButton.titleLabel.text isEqual:@"Start!"]) {
        NSLog(@"Button title is Start!");
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                        target:self
                                                      selector:@selector(moveSquares)
                                                      userInfo:nil
                                                       repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
        [self.startButton setTitle:@"Stop!" forState:UIControlStateNormal];
        [self initStartParam];

    }
    
    if ([self.startButton.titleLabel.text isEqual:@"Stop!"]) {
        NSLog(@"Button title is Stop!");
        self.startButton.hidden = YES;
        self.resetButton.hidden = NO;
        [self.myTimer invalidate];
        [self showScore];
        self.myTimer = nil;
    }
    
}

- (void) initStartParam {
    self.timerCount = 0;
    self.timeIntervalStart = CFAbsoluteTimeGetCurrent();
    self.firstSquareSpeed = increaseFirstSquareSpeed;
    self.secondSquareSpeed = increaseSecondSquareSpeed;
    self.thirdSquareSpeed = increaseThirdSquareSpeed;
    self.fourthSquareSpeed = increaseFourthSquareSpeed;
}

//Check for game finish
- (void) checkForGameOver {
    if (self.firstSquare.frame.origin.y >= self.view.frame.size.height - finishLine) {
        NSLog(@"Square #1 finished");
        [self.myTimer invalidate];
        [self.startButton setTitle:@"Start!" forState:UIControlStateNormal];
        self.startButton.hidden = YES;
        self.resetButton.hidden = NO;
        [self showScore];
        self.myTimer = nil;
    }
    if (self.secondSquare.frame.origin.y >= self.view.frame.size.height - finishLine) {
        NSLog(@"Square #2 finished");
        [self.myTimer invalidate];
        [self.startButton setTitle:@"Start!" forState:UIControlStateNormal];
        self.startButton.hidden = YES;
        self.resetButton.hidden = NO;
        [self showScore];
        self.myTimer = nil;
    }
    if (self.thirdSquare.frame.origin.y >= self.view.frame.size.height - finishLine) {
        NSLog(@"Square #3 finished");
        [self.myTimer invalidate];
        [self.startButton setTitle:@"Start!" forState:UIControlStateNormal];
        self.startButton.hidden = YES;
        self.resetButton.hidden = NO;
        [self showScore];
        self.myTimer = nil;
    }
    if (self.fourthSquare.frame.origin.y >= self.view.frame.size.height - finishLine) {
        NSLog(@"Square #3 finished");
        [self.myTimer invalidate];
        [self.startButton setTitle:@"Start!" forState:UIControlStateNormal];
        self.startButton.hidden = YES;
        self.resetButton.hidden = NO;
        [self showScore];
        self.myTimer = nil;
    }
}

- (void) showScore {
    self.timeIntervalEnd = CFAbsoluteTimeGetCurrent();
    //NSString * stringTimer = [NSString stringWithFormat:@"Score: %d sec", self.timerCount/10];
    float timerResult = self.timeIntervalEnd - self.timeIntervalStart;
    NSString * stringResult = [NSString stringWithFormat:@"%f", timerResult];
    stringResult = [stringResult substringToIndex:4];
    
    NSString * stringTimer = [NSString stringWithFormat:@"Score: %@ sec", stringResult];
    self.scoreLabel.text = stringTimer;
    self.scoreLabel.hidden = NO;
    NSLog(@"Alternative time is:, %f", timerResult);
}

//Moved Square
- (void) moveSquares {
    self.timerCount++;
    self.firstSquare.frame = CGRectMake(self.firstSquare.frame.origin.x, self.firstSquare.frame.origin.y + self.firstSquareSpeed, self.firstSquare.frame.size.width, self.firstSquare.frame.size.height);
    self.secondSquare.frame = CGRectMake(self.secondSquare.frame.origin.x, self.secondSquare.frame.origin.y + self.secondSquareSpeed, self.secondSquare.frame.size.width, self.secondSquare.frame.size.height);
    self.thirdSquare.frame = CGRectMake(self.thirdSquare.frame.origin.x, self.thirdSquare.frame.origin.y + self.thirdSquareSpeed, self.thirdSquare.frame.size.width, self.thirdSquare.frame.size.height);
    self.fourthSquare.frame = CGRectMake(self.fourthSquare.frame.origin.x, self.fourthSquare.frame.origin.y + self.fourthSquareSpeed, self.fourthSquare.frame.size.width, self.fourthSquare.frame.size.height);
    [self checkForGameOver];
    [self increaseSpeed];
}


//Increase Speed
- (void) increaseSpeed {
    if (self.timerCount % TIMERFORCHANGESPEED == 0) {
        self.firstSquareSpeed = self.firstSquareSpeed + increaseFirstSquareSpeed;
        self.secondSquareSpeed = self.secondSquareSpeed + increaseSecondSquareSpeed;
        self.thirdSquareSpeed = self.thirdSquareSpeed + increaseThirdSquareSpeed;
        self.fourthSquareSpeed = self.fourthSquareSpeed + increaseFourthSquareSpeed;
        NSLog(@"====== Speed increased =======");
    }
}

- (void) reset {
    [self initStartParam];
    self.scoreLabel.hidden = YES;
    self.scoreLabel.text = nil;
    self.resetButton.hidden = YES;
    [self.startButton setTitle:@"Start!" forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.startButton.hidden = NO;
    });
    
}

//Gesture
- (IBAction)firstGesture:(UITapGestureRecognizer *)sender {
        self.firstSquare.frame = CGRectMake(self.firstSquare.frame.origin.x, startLine, self.firstSquare.frame.size.width, self.firstSquare.frame.size.height);
    NSLog(@"Timer Count is %ld", (long)self.timerCount);
}

- (IBAction)secondGesture:(UITapGestureRecognizer *)sender {
    self.secondSquare.frame = CGRectMake(self.secondSquare.frame.origin.x, startLine, self.secondSquare.frame.size.width, self.secondSquare.frame.size.height);
}

- (IBAction)thirdGesture:(UISwipeGestureRecognizer *)sender {
    self.thirdSquare.frame = CGRectMake(self.thirdSquare.frame.origin.x, startLine, self.thirdSquare.frame.size.width, self.thirdSquare.frame.size.height);
}

- (IBAction)fourthGesture:(UISwipeGestureRecognizer *)sender {
    self.fourthSquare.frame = CGRectMake(self.fourthSquare.frame.origin.x, startLine, self.fourthSquare.frame.size.width, self.fourthSquare.frame.size.height);
}


- (IBAction)resetButton:(id)sender {
    [self reset];
}
@end
