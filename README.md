# JMActionSheetDescription

[![CI Status](http://img.shields.io/travis/Jerome Morissard/JMActionSheetDescription.svg?style=flat)](https://travis-ci.org/Jerome Morissard/JMActionSheetDescription)
[![Version](https://img.shields.io/cocoapods/v/JMActionSheetDescription.svg?style=flat)](http://cocoapods.org/pods/JMActionSheetDescription)
[![License](https://img.shields.io/cocoapods/l/JMActionSheetDescription.svg?style=flat)](http://cocoapods.org/pods/JMActionSheetDescription)
[![Platform](https://img.shields.io/cocoapods/p/JMActionSheetDescription.svg?style=flat)](http://cocoapods.org/pods/JMActionSheetDescription)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JMActionSheetDescription is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JMActionSheetDescription"
```

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

//item + block
JMActionSheetItem *otherItem = [[JMActionSheetItem alloc] init];
otherItem.title = @"otherItem";
otherItem.action = ^(void){
    NSLog(@"otherItem pressed");
};

desc.items = @[itemShare,otherItem];
[JMActionSheet showActionSheetDescription:desc inViewController:self];
```

## Author

Jerome Morissard, jerome.morissard@backelite.com

## License

JMActionSheetDescription is available under the MIT license. See the LICENSE file for more info.
