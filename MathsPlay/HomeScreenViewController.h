//
//  HomeScreenViewController.h
//  MathsPlay
//
//  Created by qainfotech on 10/21/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface HomeScreenViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITextField *nameTextfield;
    UISegmentedControl *segmentForGender,*classSegmentControl;
    UIImageView *avatarImage;
    UIPopoverController *popover;
    UIImagePickerController *imagePicker;
    UILabel *skillLabelValue;
    UIView *classOneView, *classThreeView, *classFiveView,*classSixView;
}
-(id)init;
@end
