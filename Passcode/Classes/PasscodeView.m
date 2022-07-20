//
//  PasscodeView.m
//  Passcode
//
//  Created by Hamid Farooq on 19/07/2022.
//

#import "PasscodeView.h"

@interface PasscodeView ()
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, assign) UIButton *selectedbutton;
@end

@implementation PasscodeView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.backgroundColor = [UIColor clearColor];
    
    self.faceColor = [UIColor whiteColor];
    self.selectedFaceColor = [UIColor blueColor];
    
    [self addSubview:self.button];
}

- (void)setReadonly:(BOOL)readonly {
    self.userInteractionEnabled = !readonly;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    
    self.button.titleLabel.font = font;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    [self.button setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setContentTintColor:(UIColor *)color {
    [self.button setTintColor:color];
}

- (void)setContentBackgroundColor:(UIColor *)color {
    [self.button setBackgroundColor:color];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    [self.button setImage:self.image forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    if (self.isSecured) {
        if (title.length > 0) {
            [self.button setBackgroundColor:self.button.currentTitleColor];
        }
        else {
            [self.button setBackgroundColor:self.faceColor];
        }
    }
    
    _title = title;
    
    [self.button setTitle:self.title forState:UIControlStateNormal];
}

- (NSString *)value {
    return self.title.length > 0 ? self.title : @"";
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setBackgroundColor:self.faceColor];
        [_button setFrame:CGRectInset(self.bounds, 4, 4)];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchDragExit];
        [_button addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchCancel];
        [_button addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
        [_button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self dropShadow];
     }
    return _button;
}

- (void)dropShadow {
    _button.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    _button.layer.shadowOffset = CGSizeMake(0, 2.0f);
    _button.layer.shadowOpacity = 0.5;
    _button.layer.shadowRadius = 8;
    _button.layer.masksToBounds = false;
    _button.layer.cornerRadius = _button.frame.size.width / 2;
    _button.layer.borderColor = [[UIColor systemGrayColor] CGColor];
    _button.layer.borderWidth = 0.5;
}

- (void)buttonCancel:(UIButton *)sender {
    if (self.type != CodeViewTypeDelete) {
        [sender setBackgroundColor:self.faceColor];
    }
}

- (void)buttonDown:(UIButton *)sender {
    if (self.type != CodeViewTypeDelete) {
        [sender setBackgroundColor:self.selectedFaceColor];
    }
}

- (void)buttonTap:(UIButton *)sender {
    if (self.type != CodeViewTypeDelete) {
        [sender setBackgroundColor:self.faceColor];
    }
    
    self.didTap(sender.currentTitle, self.type);
}

@end
