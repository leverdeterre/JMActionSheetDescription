//
//  JMActionSheetPickerItem.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetItem.h"

@protocol JMActionSheetPickerItemDisplayable <NSObject>

- (nonnull NSString *)displayableValueForActionSheetPicker;

@end

@interface JMActionSheetPickerItem : JMActionSheetItem

@property (nullable, assign, nonatomic) id selectedItem;
@property (nonnull, strong, nonatomic) NSArray <JMActionSheetPickerItemDisplayable> *pickerElements;
@property (nonnull, copy, nonatomic) JMActionSheetSelectedItemBlock pickerActionBlock;

@end


@interface NSString (JMActionSheetPickerItem) <JMActionSheetPickerItemDisplayable>

@end
