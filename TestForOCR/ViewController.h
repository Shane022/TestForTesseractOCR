//
//  ViewController.h
//  TestForOCR
//
//  Created by new on 16/9/8.
//  Copyright © 2016年 new. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (nonatomic, strong)UIImagePickerController *imagePicker;


@end

