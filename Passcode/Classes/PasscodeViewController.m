//
//  PasscodeViewController.m
//  Passcode
//
//  Created by Hamid Farooq on 19/07/2022.
//

#import "PasscodeViewController.h"
#import "PasscodeBlurView.h"
#import "PasscodeView.h"

@interface PasscodeViewController ()
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, strong) IBOutlet UIButton *forgotPasscodeButton;

@property (nonatomic, strong) IBOutletCollection(PasscodeView) NSArray *inputViews;
@property (nonatomic, strong) IBOutletCollection(PasscodeView) NSArray *buttons;

@property (nonatomic, assign) PasscodeView *lastSelectedButton;
@property (nonatomic, readonly) PasscodeBlurView *blurView;
@end

@implementation PasscodeViewController

- (NSString *)passcode {
    return [[[self.inputViews valueForKey:@"value"] allObjects] componentsJoinedByString:@""];
}

- (PasscodeBlurView *)blurView {
    return (PasscodeBlurView *)self.view;
}

- (id)init {
    NSBundle *frameworkBundle = [NSBundle bundleForClass:PasscodeViewController.self];
    NSString *path = [NSBundle pathForResource:@"Resources" ofType:@"bundle" inDirectory:frameworkBundle.resourcePath];
    if (self = [super initWithNibName:@"PasscodeViewController" bundle:[NSBundle bundleWithPath:path]]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in self.gradientColors) {
        [cgColors addObject:(id)[[color colorWithAlphaComponent:self.blurEffactOpacity] CGColor]];
    }
    
    [self.blurView applyBlurEffectWithColors:cgColors];
    
    self.imageView.image = self.titleImage;
    self.titleLabel.text = self.titleText;
    self.subtitleLabel.text = self.detailTitleText;
    
    for (int i=0; i<self.inputViews.count; i++) {
        PasscodeView *input = self.inputViews[i];
        input.font = [UIFont boldSystemFontOfSize:14];
        input.titleColor = [UIColor blueColor];
        input.isSecured = self.isSecuredPassword;
        input.type = CodeViewTypeInput;
        input.readonly = true;
    }
    
    for (int i=0; i<self.buttons.count; i++) {
        PasscodeView *button = self.buttons[i];
        button.font = [UIFont boldSystemFontOfSize:20];
        switch (i) {
            case 0 ... 9:  // 1 - 9 & 0
                button.type = CodeViewTypeNumber;
                button.title = [NSString stringWithFormat:@"%d", (i + 1) % 10];
                break;
            default:
                button.type = CodeViewTypeDelete;
                if (@available(iOS 13.0, *)) {
                    button.image = [UIImage systemImageNamed:@"delete.backward"];
                    button.contentBackgroundColor = [UIColor separatorColor];
                } else {
                    // Fallback on earlier versions
                }
                button.contentTintColor = [UIColor whiteColor];
                break;
        }
        
        [button setDidTap:^(NSString * _Nonnull value, enum CodeViewType type) {
            if (type == CodeViewTypeDelete) {
                NSArray *objects = self.inputViews.reverseObjectEnumerator.allObjects;
                for (PasscodeView *input in objects) {
                    if (input.title.length > 0) {
                        input.title = @"";
                        break;
                    }
                }
            }
            else if (self.passcode.length < self.inputViews.count) {
                if (self.didEnteredNumber != nil) {
                    self.didEnteredNumber(value);
                }
                
                NSArray *objects = self.inputViews;
                for (PasscodeView *input in objects) {
                    if (input.title.length == 0) {
                        input.title = value;
                        break;
                    }
                }
                
                NSString *passcode = self.passcode;
                if (passcode.length == self.inputViews.count) {
                    if (self.didEnteredPasscode != nil) {
                        self.didEnteredPasscode(passcode);
                    }
                }
            }
        }];
    }
}

- (IBAction)dismiss {
    [self dismissViewControllerAnimated:true completion:self.didDismissed];
}

- (IBAction)forgotPasscodeButtonAction:(id)sender {
    if (self.didForgotPasscode != nil) {
        self.didForgotPasscode();
    }
}

@end
