//
//  ComboActionSheet.h
//  ComboActionSheet
//
//  Created by Leo_hsu on 2015/7/10.
//  Copyright (c) 2015年 Leo_hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol ClickComboActionSheetProtocol <NSObject>
- (void)ClickComboActionSheetAtIndex:(NSUInteger)index andTitle:(NSString *)str;
@end

@interface ComboActionSheet : NSObject<UIActionSheetDelegate>

@property NSString *lastSelected;

- (void)showWithVC:(UIViewController *)VC delegate:(id<ClickComboActionSheetProtocol>)delegate title:(NSString *)title message:(NSString *)message cancelButtonText:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

@end
