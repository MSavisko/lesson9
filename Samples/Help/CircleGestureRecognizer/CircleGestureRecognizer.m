//
//  CircleGestureRecognizer.m
//  HelpGestureRecognizer
//
//  Created by Maksym Savisko on 12/27/15.
//  Copyright © 2015 Max Chuquimia. All rights reserved.
//

#import "CircleGestureRecognizer.h"

@implementation CircleGestureRecognizer

- (id) init {
    if ( (self = [super init]) ) {
        _circleClosureAngleVariance = 45.0;
        _circleClosureDistanceVariance = 50.0;
        _maximumCircleTime = 20.0;
        _radiusVariancePercent = 25.0;
        _overlapTolerance = 3;
        points_ = [[NSMutableArray alloc] init];
        firstTouch_ = CGPointZero;
        firstTouchTime_ = 0.0;
        _center = CGPointZero;
        _radius = 0.0;
    }
    return self;
}

- (void) reset
{
    [super reset];
    [points_ removeAllObjects];
    firstTouch_ = CGPointZero;
    firstTouchTime_ = 0.0;
    _center = CGPointZero;
    _radius = 0.0;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    firstTouch_ = [[touches anyObject] locationInView:self.view];
    firstTouchTime_ = [NSDate timeIntervalSinceReferenceDate];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    CGPoint startPoint = [[touches anyObject] locationInView:self.view];
    [points_ addObject:NSStringFromCGPoint(startPoint)];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    CGPoint endPoint = [[touches anyObject] locationInView:self.view];
    [points_ addObject:NSStringFromCGPoint(endPoint)];
    
    if (distanceBetweenPoints(firstTouch_, endPoint) > _circleClosureDistanceVariance ) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    if ( [NSDate timeIntervalSinceReferenceDate] - firstTouchTime_ > _maximumCircleTime ) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    if ( [points_ count] < 7 ) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    CGPoint leftMost = firstTouch_;
    NSUInteger leftMostIndex = NSUIntegerMax;
    CGPoint topMost = firstTouch_;
    NSUInteger topMostIndex = NSUIntegerMax;
    CGPoint rightMost = firstTouch_;
    NSUInteger  rightMostIndex = NSUIntegerMax;
    CGPoint bottomMost = firstTouch_;
    NSUInteger bottomMostIndex = NSUIntegerMax;
    
    int index = 0;
    for ( NSString *onePointString in points_ ) {
        CGPoint onePoint = CGPointFromString(onePointString);
        if ( onePoint.x > rightMost.x ) {
            rightMost = onePoint;
            rightMostIndex = index;
        }
        if ( onePoint.x < leftMost.x ) {
            leftMost = onePoint;
            leftMostIndex = index;
        }
        if ( onePoint.y > topMost.y ) {
            topMost = onePoint;
            topMostIndex = index;
        }
        if ( onePoint.y < bottomMost.y ) {
            onePoint = bottomMost;
            bottomMostIndex = index;
        }
        index++;
    }
    
    if ( rightMostIndex == NSUIntegerMax ) {
        rightMost = firstTouch_;
    }
    if ( leftMostIndex == NSUIntegerMax ) {
        leftMost = firstTouch_;
    }
    if ( topMostIndex == NSUIntegerMax ) {
        topMost = firstTouch_;
    }
    if ( bottomMostIndex == NSUIntegerMax ) {
        bottomMost = firstTouch_;
    }
    
    _center = CGPointMake(leftMost.x + (rightMost.x - leftMost.x) / 2.0, bottomMost.y + (topMost.y - bottomMost.y) / 2.0);
    _radius = fabsf(distanceBetweenPoints(_center, firstTouch_));
    
    CGFloat currentAngle = 0.0;
    BOOL    hasSwitched = NO;

    CGFloat minRadius = _radius - (_radius * _radiusVariancePercent);
    CGFloat maxRadius = _radius + (_radius * _radiusVariancePercent);
    
    index = 0;
    for ( NSString *onePointString in points_ ) {
        CGPoint onePoint = CGPointFromString(onePointString);
        CGFloat distanceFromRadius = fabsf(distanceBetweenPoints(_center, onePoint));
        
        if ( distanceFromRadius < minRadius || distanceFromRadius > maxRadius ) {
            self.state = UIGestureRecognizerStateFailed;
            return;
        }
        
        
        CGFloat pointAngle = angleBetweenLines(firstTouch_, _center, onePoint, _center);
        
        if ( (pointAngle > currentAngle && hasSwitched) && (index < [points_ count] - _overlapTolerance) ) {
            self.state = UIGestureRecognizerStateFailed;
            return;
        }
        
        if ( pointAngle < currentAngle ) {
            if ( !hasSwitched )
                hasSwitched = YES;
        }
        
        currentAngle = pointAngle;
        index++;
    }
    
    self.state = UIGestureRecognizerStateRecognized;
}

#define degreesToRadian(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (180.0 * x / M_PI)

CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
CGFloat deltaX = second.x - first.x;
CGFloat deltaY = second.y - first.y;
return sqrt(deltaX*deltaX + deltaY*deltaY);
}

CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
CGFloat height = second.y - first.y;
CGFloat width = first.x - second.x;
CGFloat rads = atan(height/width);
return radiansToDegrees(rads);
}

CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {

CGFloat a = line1End.x - line1Start.x;
CGFloat b = line1End.y - line1Start.y;
CGFloat c = line2End.x - line2Start.x;
CGFloat d = line2End.y - line2Start.y;

CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));

return radiansToDegrees(rads);
}

@end
