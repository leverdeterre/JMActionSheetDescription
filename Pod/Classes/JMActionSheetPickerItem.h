//
//  JMActionSheetPickerItem.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetItem.h"

@protocol JMActionSheetPickerItemDisplayable <NSObject>

- (NSString *)displayableValueForActionSheetPicker;

@end

@interface JMActionSheetPickerItem : JMActionSheetItem

@property (strong, nonatomic) NSArray <JMActionSheetPickerItemDisplayable> *pickerElements;
@property (copy, nonatomic) JMActionSheetSelectedItemBlock pickerActionBlock;

@end


@interface NSString (JMActionSheetPickerItem) <JMActionSheetPickerItemDisplayable>

@end