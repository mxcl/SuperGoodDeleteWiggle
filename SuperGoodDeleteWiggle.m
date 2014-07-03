@import UIKit;


@implementation OMGWiggleView : UIView

static float angle = 0.035;
static float offset = 0;
static float transform = -0.5;

- (void)wiggle {
    self.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1.0);
    
    angle = -angle;
    
    offset += 0.03;
    if (offset > 0.9)
        offset -= 0.9;
    
    transform = -transform;
    
    CABasicAnimation *aa = [CABasicAnimation animationWithKeyPath:@"transform"];
    aa.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(angle, 0, 0, 1.0)];
    aa.repeatCount = HUGE_VALF;
    aa.duration = 0.12;
    aa.autoreverses = YES;
    aa.timeOffset = offset;
    [self.layer addAnimation:aa forKey:nil];
    
    aa = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    aa.duration = 0.08;
    aa.repeatCount = HUGE_VALF;
    aa.autoreverses = YES;
    aa.fromValue = @(transform);
    aa.toValue = @(-transform);
    aa.fillMode = kCAFillModeForwards;
    aa.timeOffset = offset;
    [self.layer addAnimation:aa forKey:nil];

    aa = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    aa.duration = 0.09;
    aa.repeatCount = HUGE_VALF;
    aa.autoreverses = YES;
    aa.fromValue = @(transform);
    aa.toValue = @(-transform);
    aa.fillMode = kCAFillModeForwards;
    aa.timeOffset = offset + 0.6;
    [self.layer addAnimation:aa forKey:nil];
}

- (void)unwiggle {
    [self.layer removeAllAnimations];
    self.layer.transform = CATransform3DIdentity;
}

@end

@interface UIColor (mxcl)
@end
@implementation UIColor (mxcl)
+ (UIColor *)randomColor {
    float hue = rand();
    hue /= RAND_MAX;
    return [UIColor colorWithHue:hue saturation:0.8 brightness:0.8 alpha:1];
}
@end


@interface MyAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation MyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [UIViewController new];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    UIView *superview = self.window.rootViewController.view;
    for (int x = 0; x < 4; x++) {
        for (int y = 0; y < 4; y++) {
            OMGWiggleView *wiggler = [[OMGWiggleView alloc] initWithFrame:CGRectMake(15 + x * 75, 35 + y * 75, 65, 65)];
            wiggler.backgroundColor = [UIColor randomColor];
            [superview addSubview:wiggler];
            [wiggler wiggle];
        }
    }

    return YES;
}

@end


int main(int argc, char **argv) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([MyAppDelegate class]));
    }
}
