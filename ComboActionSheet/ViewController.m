//
//  ViewController.m
//  ComboActionSheet
//
//  Created by Leo_hsu on 2015/7/10.
//  Copyright (c) 2015年 Leo_hsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)tapButton:(id)sender {
    ComboActionSheet *actionSheet = [[ComboActionSheet alloc] init];
    actionSheet.lastSelected = [NSString stringWithFormat:@"0~20"];
    [actionSheet showWithVC:self delegate:self title:@"Hello" message:@"How old are you?" cancelButtonText:@"Cancel" otherButtonTitles:@[@"0~20",@"20~40",@"over 40"]];
}

#pragma mark - ClickComboActionSheetProtocol

- (void)ClickComboActionSheetAtIndex:(NSUInteger)index andTitle:(NSString *)str {
    NSLog(@"buttonIndex = %zd", index);
    NSLog(@"buttonTitle = %@", str);
}

@end
