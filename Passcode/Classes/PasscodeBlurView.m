//
//  PasscodeBlurView.m
//  Passcode
//
//  Created by Hamid Farooq on 19/07/2022.
//

#import "PasscodeBlurView.h"

@interface PasscodeBlurView ()
@property (nonatomic, copy) CAGradientLayer *gradientLayer;
@end

@implementation PasscodeBlurView

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        [self.layer insertSublayer:_gradientLayer atIndex:0];
    }
    return _gradientLayer;
}

- (void)applyBlurEffectWithColors:(NSArray *)colors {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.backgroundColor = [UIColor clearColor];
    blurView.frame = self.bounds;
    
    self.gradientLayer.colors = colors;
    
    [self.layer insertSublayer:blurView.layer below:self.gradientLayer];
}

@end
