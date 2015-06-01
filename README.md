# JMActionSheetDescription

[![Twitter](https://img.shields.io/badge/contact-@leverdeterre-green.svg)](http://twitter.com/leverdeterre)
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/leverdeterre/PermissiveResearch/blob/master/LICENCE)
[![Cocoapods](http://img.shields.io/cocoapods/v/JMActionSheetDescription.svg)](https://github.com/leverdeterre/PermissiveResearch)
[![Platform](https://img.shields.io/cocoapods/p/JMActionSheetDescription.svg?style=flat)](http://cocoapods.org/pods/JMActionSheetDescription)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```

## Screenshots

![Image](./screenshots/iphones.png)
![Image](./screenshots/ipads.png)
![Image](./screenshots/demo.gif)

## Installation

JMActionSheetDescription is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JMActionSheetDescription"


```objective-c
//init your description
JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];

//Configure your colors
desc.actionSheetTintColor = [UIColor grayColor];
desc.actionSheetCancelButtonFont = [UIFont boldSystemFontOfSize:17.0f];
desc.actionSheetOtherButtonFont = [UIFont systemFontOfSize:16.0f];

//Cancel item
JMActionSheetItem *cancelItem = [[JMActionSheetItem alloc] init];
cancelItem.title = @"Cancel";
desc.cancelItem = cancelItem;

//Can configure a context for your action .. an url ? image ? (work in progress)
JMActionContextItem *contextItem = [[JMActionContextItem alloc] init];
contextItem.image = [UIImage imageNamed:@"gif_experiments"];
contextItem.imageHeight = 200.0f;
desc.contextItem = contextItem;
desc.title = @"Available actions for component";

//item + block
JMActionSheetItem *itemShare = [[JMActionSheetItem alloc] init];
itemShare.title = @"last action";
itemShare.action = ^(void){
    NSLog(@"last action pressed");
};

//Pickeritem + block
JMActionSheetPickerItem *pickerItem = [[JMActionSheetPickerItem alloc] init];
    pickerItem.elements = @[@"One", @"Two", @"three", @"Four"];
    pickerItem.pickerAction = ^(NSString *selectedValue){
        NSLog(@"selectedValue %@",selectedValue);
    };

desc.items = @[itemShare,pickerItem];
[JMActionSheet showActionSheetDescription:desc inViewController:self];
```

## Author

Jérôme Morissard, morissardj@gmail.com

## License

JMActionSheetDescription is available under the MIT license. See the LICENSE file for more info.
