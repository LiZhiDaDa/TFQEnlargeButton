//
//  ViewController.m
//  TFQEnlargeButton
//
//  Created by 王立志 on 2019/9/26.
//  Copyright © 2019 Thread_Fight_Queue. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+TFQClickArea.h"
#import "TFQEnlargeButton.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *friendshipBtn;
@property (nonatomic, strong) TFQEnlargeButton *friendshipBtn1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.friendshipBtn];
    [self.view addSubview:self.friendshipBtn1];
}

#pragma mark - lazy method
- (UIButton *)friendshipBtn{
    if(_friendshipBtn == nil){
        _friendshipBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 70, 30)];
        [_friendshipBtn setTitle:@"朋友圈" forState:UIControlStateNormal];
        [_friendshipBtn addTarget:self action:@selector(didClickFriendship) forControlEvents:UIControlEventTouchUpInside];
        _friendshipBtn.backgroundColor = [UIColor blackColor];
        _friendshipBtn.clickScale = 2;
        _friendshipBtn.showClickArea = YES;
    }
    return _friendshipBtn;
}

- (UIButton *)friendshipBtn1{
    if(_friendshipBtn1 == nil){
        _friendshipBtn1 = [[TFQEnlargeButton alloc] initWithFrame:CGRectMake(100, 500, 70, 30)];
        [_friendshipBtn1 setTitle:@"朋友圈1" forState:UIControlStateNormal];
        [_friendshipBtn1 addTarget:self action:@selector(didClickFriendship) forControlEvents:UIControlEventTouchUpInside];
        _friendshipBtn1.backgroundColor = [UIColor blackColor];
        _friendshipBtn1.clickWidthScale = 2;
        _friendshipBtn1.showClickArea = YES;
    }
    return _friendshipBtn1;
}

- (void)didClickFriendship{
    NSLog(@"朋友去哪");
}

@end
