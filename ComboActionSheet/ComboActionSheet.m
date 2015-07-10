//
//  ComboActionSheet.m
//  ComboActionSheet
//
//  Created by Leo_hsu on 2015/7/10.
//  Copyright (c) 2015年 Leo_hsu. All rights reserved.
//

#import "ComboActionSheet.h"

@implementation ComboActionSheet {
    __weak id<ClickComboActionSheetProtocol> privateDelegate;
    ComboActionSheet *comboActionSheet;
}

- (id)init {
    self = [super init];
    if(self) {
        comboActionSheet = self;
    }
    return self;
}

- (void)showWithVC:(UIViewController *)VC delegate:(id<ClickComboActionSheetProtocol>)delegate title:(NSString *)title message:(NSString *)message cancelButtonText:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    if ([UIAlertController class]) {
        // For io8 and later
        UIAlertController *actionSheetIos8 = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (int i = 0 ; i < [otherButtonTitles count] ; i++) {
            UIAlertActionStyle sty = UIAlertActionStyleDefault;
            NSString *title = [otherButtonTitles objectAtIndex:i];
            int index = i;
            if ([title isEqualToString:self.lastSelected]) {
                sty = UIAlertActionStyleDestructive;
            }
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:sty handler:^(UIAlertAction * action) {
                [delegate ClickComboActionSheetAtIndex:index andTitle:title];
            }];
            [actionSheetIos8 addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            [delegate ClickComboActionSheetAtIndex:[otherButtonTitles count] andTitle:cancelButtonTitle];
            [actionSheetIos8 dismissViewControllerAnimated:YES completion:nil];
        }];
        [actionSheetIos8 addAction:cancelAction];
        
        // Support ipad
        actionSheetIos8.popoverPresentationController.sourceView = VC.view;
        actionSheetIos8.popoverPresentationController.sourceRect = CGRectMake(VC.view.bounds.size.width / 2.0, VC.view.bounds.size.height / 2.0, 1.0, 1.0);
        // Hide arrow from iPad action sheet.
        actionSheetIos8.popoverPresentationController.permittedArrowDirections = 0;
        
        // This a bug report to Apple: rdar://19285091
        // Workaround
        dispatch_async(dispatch_get_main_queue(), ^{
            [VC presentViewController:actionSheetIos8 animated:YES completion:nil];
        });
    }
    else {
        // For ios7 and earlier
        UIActionSheet *mActionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:comboActionSheet cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        for (int i = 0 ; i < [otherButtonTitles count] ; i++) {
            [mActionSheet addButtonWithTitle:[otherButtonTitles objectAtIndex:i]];
        }
        mActionSheet.cancelButtonIndex = [mActionSheet addButtonWithTitle:cancelButtonTitle];
        [mActionSheet showInView:[UIApplication sharedApplication].keyWindow];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:comboActionSheet action:@selector(tapOut:)];
        recognizer.cancelsTouchesInView = NO;
        [mActionSheet.window addGestureRecognizer:recognizer];
        privateDelegate = delegate;
    }
}

- (void)tapOut:(UIGestureRecognizer *)gestureRecognizer {
    UIActionSheet *mActionSheet = (UIActionSheet *)gestureRecognizer.view;
    CGPoint p = [gestureRecognizer locationInView:mActionSheet];
    if (p.y < 0) {
        [mActionSheet dismissWithClickedButtonIndex:0 animated:TRUE];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)willPresentActionSheet:(UIActionSheet *)_actionSheet {
    for (UIView *subview in _actionSheet.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            if([button.titleLabel.text isEqualToString:self.lastSelected]) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([privateDelegate respondsToSelector:@selector(ClickComboActionSheetAtIndex:andTitle:)]) {
        [privateDelegate ClickComboActionSheetAtIndex:buttonIndex andTitle:[actionSheet buttonTitleAtIndex:buttonIndex]];
    }
}

@end
