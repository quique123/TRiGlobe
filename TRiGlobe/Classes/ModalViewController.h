//
//  ModalViewController.h
//  iGlobe
//
//  Created by Marcio Valenzuela on 3/7/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SantiappsHelper.h"

@interface ModalViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
	
}
@property (nonatomic,retain) NSURLConnection *myConnection;
@property (nonatomic,retain) NSMutableData *incomingPostData;
@property (nonatomic,retain) IBOutlet UIButton *registerUser;
@property (nonatomic,retain) IBOutlet UIButton *loginUser;
@property (nonatomic,retain) IBOutlet UIButton *dismissModal;
@property (nonatomic,retain) IBOutlet UITextField *userName;
@property (nonatomic,retain) IBOutlet UITextField *userPass;
@property (nonatomic,retain) IBOutlet UITextField *userEmail;

-(IBAction)userWillDismiss;
-(IBAction)userWillLogIn;
-(IBAction)userWillRegister;
-(NSDictionary*)addUser:(NSString *)usuario withPass:(NSString *)clave withAddress:(NSString*)direccion;
-(NSString*)checkUserLogin:(NSString *)loginUsuario withPass:(NSString *)loginClave;
@end
