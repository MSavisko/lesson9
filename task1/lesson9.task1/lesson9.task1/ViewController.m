//
//  ViewController.m
//  lesson9.task1
//
//  Created by Anton Lookin on 12/24/15.
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
@property (nonatomic) NSTimer* myTimer;

//Guesture
- (IBAction)firstGesture:(UITapGestureRecognizer *)sender;
- (IBAction)secondGesture:(UITapGestureRecognizer *)sender;
- (IBAction)thirdGesture:(UISwipeGestureRecognizer *)sender;
- (IBAction)fourthGesture:(UISwipeGestureRecognizer *)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)startButton:(id)sender {
    if ([self.startButton.titleLabel.text isEqual:@"Start!"]) {
        NSLog(@"Button title is Start!");
        //Do some stuff
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                        target:self
                                                      selector:@selector(moveSquares)
                                                      userInfo:nil
                                                       repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
        [self.startButton setTitle:@"Stop!" forState:UIControlStateNormal];
        
    }
    
    if ([self.startButton.titleLabel.text isEqual:@"Stop!"]) {
        NSLog(@"Button title is Stop!");
        self.startButton.hidden = YES;
        NSLog(@"Current timer is %@", self.myTimer);
        [self.myTimer invalidate];
    }
    
}

- (void) moveSquares {
    self.firstSquare.frame = CGRectMake(self.firstSquare.frame.origin.x, self.firstSquare.frame.origin.y + 5, self.firstSquare.frame.size.width, self.firstSquare.frame.size.height);
    self.secondSquare.frame = CGRectMake(self.secondSquare.frame.origin.x, self.secondSquare.frame.origin.y + 4, self.secondSquare.frame.size.width, self.secondSquare.frame.size.height);
    self.thirdSquare.frame = CGRectMake(self.thirdSquare.frame.origin.x, self.thirdSquare.frame.origin.y + 3.2, self.thirdSquare.frame.size.width, self.thirdSquare.frame.size.height);
    self.fourthSquare.frame = CGRectMake(self.fourthSquare.frame.origin.x, self.fourthSquare.frame.origin.y + 2.56, self.fourthSquare.frame.size.width, self.fourthSquare.frame.size.height);
}


//Gesture

- (IBAction)firstGesture:(UITapGestureRecognizer *)sender {
    self.firstSquare.frame = CGRectMake(self.firstSquare.frame.origin.x, 15, self.firstSquare.frame.size.width, self.firstSquare.frame.size.height);
    
}

- (IBAction)secondGesture:(UITapGestureRecognizer *)sender {
    self.secondSquare.frame = CGRectMake(self.secondSquare.frame.origin.x, 15, self.secondSquare.frame.size.width, self.secondSquare.frame.size.height);
}

- (IBAction)thirdGesture:(UISwipeGestureRecognizer *)sender {
    self.thirdSquare.frame = CGRectMake(self.thirdSquare.frame.origin.x, 15, self.thirdSquare.frame.size.width, self.thirdSquare.frame.size.height);
}

- (IBAction)fourthGesture:(UISwipeGestureRecognizer *)sender {
    self.fourthSquare.frame = CGRectMake(self.fourthSquare.frame.origin.x, 15, self.fourthSquare.frame.size.width, self.fourthSquare.frame.size.height);
}


@end
