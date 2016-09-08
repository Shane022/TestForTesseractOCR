//
//  ViewController.m
//  TestForOCR
//
//  Created by new on 16/9/8.
//  Copyright © 2016年 new. All rights reserved.
//

#import "ViewController.h"
//#import <TesseractOCR/TesseractOCR.h>
#import "TesseractOCR.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *_photoImageView;
    UITextView *_resultTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayoutAndInitData];
}

- (void)setupLayoutAndInitData {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(onHitGetPhotot:)];
    CGFloat margionLeft = 50;
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width-margionLeft*2, (self.view.frame.size.width-margionLeft*2)*16/9)];
    [self.view addSubview:_photoImageView];
    
    _resultTextView = [[UITextView alloc] initWithFrame:CGRectMake(_photoImageView.frame.size.width, 64, self.view.frame.size.width -  _photoImageView.frame.size.width, _photoImageView.frame.size.height)];
    _resultTextView.delegate = self;
    [self.view addSubview:_resultTextView];
}

- (void)onHitGetPhotot:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选取照片" message:@"选择方式" preferredStyle:UIAlertControllerStyleActionSheet];
    // 相册
    UIAlertAction *actionPhotos = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }];
    // 相机
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return ;
        }
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }];
    // 取消
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:actionPhotos];
    [alertController addAction:actionCamera];
    [alertController addAction:actionCancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@",info);
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _photoImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:^{
        [self performImageRecognition:image];
    }];
}

- (void)performImageRecognition:(UIImage *)image {
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
    tesseract.engineMode = G8OCREngineModeTesseractOnly;
    tesseract.pageSegmentationMode = G8PageSegmentationModeAuto;
    tesseract.maximumRecognitionTime = 60.0;
    tesseract.image = image.g8_blackAndWhite;
    
    _resultTextView.text = tesseract.recognizedText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
