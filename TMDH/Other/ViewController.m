//
//  ViewController.m
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    button.titleLabel.font = SystemFont(SCRXFromX(13));
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:button];
    
    @weakify(self);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.offset(SCRXFromX(65));
        make.height.offset(SCRXFromX(40));
        make.centerX.centerY.equalTo(self.view);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [TMCommonlyMethods makeRoundedCorners:button onTopLeft:YES topRight:YES bottomLeft:NO bottomRight:NO radius:SCRXFromX(10)];
    });
}

- (void)buttonClick
{
    [TMRouterInstance pushToVC:@"FirstVC"];
}

@end
