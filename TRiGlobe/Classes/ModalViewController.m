//
//  ModalViewController.m
//  iGlobe
//
//  Created by Marcio Valenzuela on 3/7/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "ModalViewController.h"

@implementation ModalViewController

-(IBAction)userWillLogIn{
	//Call checklogin.php to compare user/pass and return value
	NSString *loginSuccess = [self checkUserLogin:self.userName.text withPass:self.userPass.text];
	if ([loginSuccess isEqualToString:@"SUCCESS"]) {
		NSLog(@"We did it...");
		//If all is well, then store userDefaults
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		[prefs setObject:self.userName.text forKey:@"storedUser"];
		[prefs setObject:self.userPass.text forKey:@"storedPass"];
		[prefs synchronize];
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		NSLog(@"Authentication Failed..");
		//Add UIAlertView
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops..." message:loginSuccess delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
	//if checklogin.php = OK then dismiss
	
}

-(IBAction)userWillRegister{
	// Create uniqueIdentifier
	//UIDevice *device = [UIDevice currentDevice];
	//NSString *uniqueIdentifier = [device uniqueIdentifier];
	
	//1. Get the LOGIN errorsDictionary
	NSDictionary *errorsDict = [self addUser:self.userName.text withPass:self.userPass.text withAddress:self.userEmail.text];
	//2. if dictcount = 1 then dismiss && = 5926, then OK
	if ([[errorsDict objectForKey:@"code1"] intValue] == 5926) {
		NSLog(@"yeay");
		//If all is well, then store userDefaults
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		[prefs setObject:self.userName.text forKey:@"storedUser"];
		[prefs setObject:self.userPass.text forKey:@"storedPass"];
		[prefs synchronize];
		//Dismis ModalVC after users first login
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		NSLog(@"Errors");
		// extract nsdict
		NSMutableString *resultString = [NSMutableString string];
		for (NSString* key in [errorsDict allKeys]){
			if ([resultString length]>0)
				[resultString appendString:@"&"];
			[resultString appendFormat:@"%@=%@", key, [errorsDict objectForKey:key]];
		}
		NSLog(@"rS:%@",resultString);
		//Add UIAlertView
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Check your user,pass or email" message:resultString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		}
}

-(IBAction)userWillDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//registering user----moved to modalVC
-(NSString*)checkUserLogin:(NSString *)loginUsuario withPass:(NSString *)loginClave{
	//CREATE URL TO SEND
	NSString *urlString = [NSString stringWithFormat:@"username=%@&password=%@",loginUsuario,loginClave];
	NSLog(@"login string:%@",urlString);
	//POST THE STRING
    NSData *postData = [urlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.yourserver.com/login2/checklogin.php"]];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
	// We should probably be parsing the data returned by this call, for now just check the error.
    NSData *myData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	//NSError *outError = NULL;
	//NSDictionary *tempDict = [NSDictionary dictionaryWithJSONData:myData error:&outError];
	NSString *string=[[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding ];
	//NSLog(@"string es:%@, %i, %C",string,[string length],[string characterAtIndex:7]);
	NSLog(@"string ess:%@",string);
	//NSLog(@"Dict of errors:%@",tempDict);
	return string;
}



-(NSDictionary*)addUser:(NSString *)usuario withPass:(NSString *)clave withAddress:(NSString*)direccion{
	//CREATE URL TO SEND
	NSString *urlString = [NSString stringWithFormat:@"username=%@&password=%@&email=%@",usuario,clave,direccion];
	NSLog(@"user registration string:%@",urlString);
	//POST THE STRING
    NSData *postData = [urlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.yourserver.com/login2/user_add_save.php"]];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
	// We should probably be parsing the data returned by this call, for now just check the error.
    NSData *myData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSError *outError = NULL;
	NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:&outError];
                              //dataWithJSONObject:myData options:NSJSONWritingPrettyPrinted error:&outError];
                              //dictionaryWithJSONData:myData error:&outError];
	//NSString *string=[[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding ];
	NSLog(@"Dict of errors:%@",tempDict);
	return tempDict;
}

///////////////////////////////////----------------PHOTO UPLOAD-----
-(IBAction)uploadPhoto:(id)sender{
    NSLog(@"picker");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"pickerPicked");

    UIImage *profile_image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self uploadImage:UIImageJPEGRepresentation(profile_image, 1.0) filename:@"globe57.png"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)uploadImage:(NSData *)imageData filename:(NSString *)filename{
    
    NSLog(@"uploading");

    NSString *urlString = @"http://www.yourserver.com/photos/uploadPhoto.php";
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"0xKhTmLbOuNdArY";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Set the filename
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n",filename]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //append the image data
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding] autorelease];
    
    NSLog(@"returningOKString");

    return ([returnString isEqualToString:@"OK"]);
}

//////////////////////////////

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
