//
//  PinAnnotationView.m
//  FuelOn
//
//  Created by B0081006 on 8/30/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import "PinAnnotationView.h"

@implementation PinAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *nibContents = [[NSBundle mainBundle]loadNibNamed:@"PinAnnotationView" owner:self options:nil];
        [self addSubview:nibContents[0]];
    }
    
    return self;
}

@end
