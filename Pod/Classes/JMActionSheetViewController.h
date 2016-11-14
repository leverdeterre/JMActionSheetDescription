//
//  JMActionSheetViewController.h
//  Pods
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMActionSheetItem.h"
#import "JMActionSheetPickerItem.h"
#import "JMActionSheetDatePickerItem.h"
#import "JMActionSheet.h"

@class JMActionSheetViewController;
@protocol JMActionSheetViewControllerDelegate <NSObject>

- (void)dismissActionSheet;
- (void)actionSheetWillRotate;
- (void)actionSheetDidSelectPickerView:(UIPickerView *)pickerView element:(id)element block:(JMActionSheetSelectedItemBlock)block;
- (void)actionSheetDidSelectCollectionView:(UICollectionView *)collectionView element:(id)element block:(JMActionSheetSelectedItemBlock)block;
- (void)actionSheetDidSelectCollectionView:(UICollectionView *)collectionView element:(id)element block:(JMActionSheetSelectedItemBlock)block dismissEnable:(BOOL)dismissEnable;

@end

@class JMActionSheetDescription;
@interface JMActionSheetViewController : UIViewController

@property (weak, nonatomic, readonly) id <JMActionSheetViewControllerDelegate> delegate;

- (void)reloadWithActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription
                             delegate:(id <JMActionSheetViewControllerDelegate>)delegate
                                   style:(JMActionSheetStyle)style;

- (CGSize)estimatedContentSizeWithDescription:(JMActionSheetDescription *)actionSheetDescription width:(CGFloat)width style:(JMActionSheetStyle)style;
- (CGSize)contentSizeForViewInPopover;

@end
