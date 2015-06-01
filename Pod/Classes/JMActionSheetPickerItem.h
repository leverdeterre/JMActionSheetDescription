//
//  JMActionSheetPickerItem.h
//  Pods
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetItem.h"

@protocol JMActionSheetPickerItem <NSObject>
@property (readonly) NSString *displayableValueForActionSheetPicker;
@end

@interface JMActionSheetPickerItem : JMActionSheetItem

@property (strong, nonatomic) NSArray *elements; //Array of id <JMActionSheetPickerItem>
@property (copy, nonatomic) JMActionSheetSelectedItemBlock pickerActionBlock;

@end
