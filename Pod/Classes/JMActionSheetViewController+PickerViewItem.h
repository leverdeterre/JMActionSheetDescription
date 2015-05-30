//
//  JMActionSheetViewController+PickerViewItem.h
//  Pods
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetViewController.h"
#import "JMActionSheetPickerItem.h"

@interface JMActionSheetViewController (PickerViewItem) <UIPickerViewDataSource, UIPickerViewDelegate>

- (void)jm_setPickerViewElements:(NSArray *)elements;
- (NSArray *)jm_getPickerViewElements;

- (void)jm_setPickerActionBlock:(JMActionSheetPickerItemAction)actionBlock;
- (JMActionSheetPickerItemAction)jm_getPickerActionBlock;

@end
