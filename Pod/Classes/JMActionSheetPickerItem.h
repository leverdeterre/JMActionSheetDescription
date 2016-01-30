//
//  JMActionSheetPickerItem.h
//  Pods
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetItem.h"

@protocol JMActionSheetPickerItemDisplayable <NSObject>
@property (readonly) NSString *displayableValueForActionSheetPicker;
@end

typedef void (^JMActionSheetSelectedItemBlock)(id selectedItem);

@interface JMActionSheetPickerItem : JMActionSheetItem

@property (strong, nonatomic) NSArray <JMActionSheetPickerItemDisplayable> *pickerElements;
@property (copy, nonatomic) JMActionSheetSelectedItemBlock pickerActionBlock;

@end


@interface NSString (JMActionSheetPickerItem) <JMActionSheetPickerItemDisplayable>

@end