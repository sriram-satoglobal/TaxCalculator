//
//  ViewController.m
//  TaxCalculator
//
//  Created by SriramSGS on 12/21/15.
//  Copyright © 2015 Sato Global Solutions Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (nonatomic, weak) IBOutlet UITextField *amountTF;
@property (nonatomic, weak) IBOutlet UITextView *detailsTV;
@property (nonatomic, weak) IBOutlet UIImageView *tempImageView;
@property (nonatomic, weak) IBOutlet UIImageView *destImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _detailsTV.layer.borderColor = [UIColor blackColor].CGColor;
    _detailsTV.layer.borderWidth = 1.0;
    _detailsTV.layer.cornerRadius = 5.0;
    [_amountTF becomeFirstResponder];
}


-(IBAction)calculate:(id)sender{
    
    _destImageView.image = [self pb_takeSnapshot];
    
    float amount = [_amountTF.text floatValue];

    if (amount == 0.0) {
        [self showAlertWithMessage:@"Please enter some amount to calculate Tax" isError:NO];
        return;
    }
    
    float taxAmount = 0.0;
    float diff = 0.0;
    if (amount > 413200) {
        diff = amount - 413200;
        taxAmount += diff * 39.6/100;
        amount = 413200;
    }
    
    if (amount >= 411501) {
        diff = amount - 411501;
        taxAmount += diff * 35/100;
        amount = 411500;
    }
    
    if (amount >= 189301) {
        diff = amount - 189301;
        taxAmount += diff * 25/100;
        amount = 189300;
    }
    
    if (amount >= 90751) {
        diff = amount - 90751;
        taxAmount += diff * 28/100;
        amount = 90750;
    }
    
    if (amount >= 37451) {
        diff = amount - 37451;
        taxAmount += diff * 25/100;
        amount = 37450;
    }
    
    if (amount >= 9226) {
        diff = amount - 9226;
        taxAmount += diff * 15/100;
        amount = 9225;
    }
    
    taxAmount += amount * 0.1;
    
    _detailsTV.text = [NSString stringWithFormat:@"Net amount:  %0.2f\nNet Income: %0.2f\nTax amount:  %0.2f\nPercentage of Tax:  %0.2f%%", _amountTF.text.floatValue, _amountTF.text.floatValue-taxAmount, taxAmount, (taxAmount/_amountTF.text.floatValue) * 100];
    
}

- (UIImage *)pb_takeSnapshot {
    UIGraphicsBeginImageContextWithOptions(_tempImageView.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [_tempImageView drawViewHierarchyInRect:_tempImageView.bounds afterScreenUpdates:YES];
    
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark- SHOW ALERTS
-(void)showAlertWithMessage:(NSString *)titleString isError:(BOOL)isError{
    NSString *errorString = (isError) ? @"Error!" : @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:errorString message:titleString preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
