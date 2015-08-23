

//
//  iGlobe
//
//  Created by Marcio Valenzuela on 9/15/10.
//  Copyright 2010 Personal. All rights reserved.
//

#import "NewMapViewController.h"

@interface NewMapViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    BOOL _datePickerVisible;
}

@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UITextView *instructionsTextView;
@property (nonatomic, strong) IBOutlet UILabel *photoLabel;
@property (nonatomic, strong) IBOutlet UIImageView *photoImageView;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *awardTypeLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation NewMapViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder])) {
		self.name = @"";
		self.instructions = @"";
		self.date = [NSDate date];
		self.awardType = @"Gold and Silver";
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.photoImageView.hidden = YES;

	// Put the values from the properties into the table view cells. These are
	// either the default values (for a new treasure map) or the values from an
	// existing TreasureMap object.

	self.nameTextField.text = self.name;
	self.instructionsTextView.text = self.instructions;
    self.dateLabel.text = [self formatDate:self.date];
    self.awardTypeLabel.text = self.awardType;
	[self showPhoto];

	// There is no button that hides the keyboard, so instead we allow the user
	// to tap anywhere else in the table view in order to hide the keyboard.

	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	gestureRecognizer.cancelsTouchesInView = NO;
	[self.navigationController.view addGestureRecognizer:gestureRecognizer];

	#if CUSTOM_APPEARANCE
	self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableBackground"]];
	self.tableView.separatorColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	#endif

	_datePickerVisible = NO;
	self.datePicker.hidden = YES;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideDatePicker) name:UIKeyboardWillShowNotification object:nil];
}

// Answer to challenge 1
//
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:2] animated:YES];
}

- (void)hideKeyboard
{
	// This trick dismissed the keyboard, no matter which text field or text
	// view is currently active.
	[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (NSString *)formatDate:(NSDate *)theDate
{
	static NSDateFormatter *formatter;
	if (formatter == nil) {
		formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterNoStyle];
	}

	return [formatter stringFromDate:theDate];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Save"]) {
		// Note: This is an unwind segue to go back to the previous screen.

		self.name = self.nameTextField.text;
		self.instructions = self.instructionsTextView.text;

	} else if ([segue.identifier isEqualToString:@"ChooseAwardType"]) {
		//AwardTypeViewController *controller = segue.destinationViewController;
		//controller.awardType = self.awardType;
	}
}

- (IBAction)pickedAwardType:(UIStoryboardSegue *)segue
{
	// This handles the unwind segue from the Award Type picker screen.

	//AwardTypeViewController *controller = segue.sourceViewController;
	//self.awardType = controller.awardType;
    //self.awardTypeLabel.text = self.awardType;
}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// This makes the "Add Photo" row taller when the user picked a photo.

	if (indexPath.section == 1) {
		return 88.0f;
	} else if (indexPath.section == 2 && indexPath.row == 0) {
		return self.photoImageView.hidden ? 44.0f : 280.0f;
	} else if (indexPath.section == 2 && indexPath.row == 2) {
		return _datePickerVisible ? 217.0f : 0.0f;
	} else {
		return 44.0f;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// If the row has a text view but the user tapped outside the actual text
	// view (it's a bit smaller than the row), we still show the keyboard.
	if (indexPath.section == 0) {
		[self.nameTextField becomeFirstResponder];
	} else if (indexPath.section == 1) {
		[self.instructionsTextView becomeFirstResponder];
	}

	if (indexPath.section == 2) {
		if (indexPath.row == 0) {
			[self choosePhotoFromLibrary];
		} else if (indexPath.row == 1) {
			[tableView deselectRowAtIndexPath:indexPath animated:YES];

			if (!_datePickerVisible) {
				[self showDatePicker];
			} else {
				[self hideDatePicker];
			}
			return;
		}
	}

	// Also hide the date picker when tapped on any other row.
	[self hideDatePicker];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 2 && indexPath.row == 2) {
		return nil;
	} else {
		return indexPath;
	}
}

#if CUSTOM_APPEARANCE
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (section == 2) {
		return nil;
	}

	UILabel *label = [ [UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 300.0f, 44.0f)];
	label.font = [UIFont boldSystemFontOfSize:14.0f];
	label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
	label.textColor = LightTextColor;
	label.shadowColor = [UIColor blackColor];
	label.shadowOffset = CGSizeMake(0.0f, -1.0f);
	label.backgroundColor = [UIColor clearColor];

	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
	[view addSubview:label];
	return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableCellSelection"]];
	cell.backgroundColor = TableColor;
	cell.textLabel.textColor = DarkTextColor;
	cell.detailTextLabel.textColor = LightTextColor;
}
#endif

#pragma mark - Date Picker

- (void)showDatePicker
{
	// 1
	NSIndexPath *dateRowIndexPath = [NSIndexPath indexPathForRow:1 inSection:2];
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:dateRowIndexPath];
	cell.detailTextLabel.textColor = cell.detailTextLabel.tintColor;

	[self.datePicker setDate:self.date animated:NO];

	// 3
	_datePickerVisible = YES;
	[self.tableView beginUpdates];
	[self.tableView endUpdates];

	// 4
	self.datePicker.hidden = NO;
	self.datePicker.alpha = 0.0f;
	[UIView animateWithDuration:0.25 animations:^{
		self.datePicker.alpha = 1.0f;
	}];

	// 5
	NSIndexPath *pickerIndexPath = [NSIndexPath indexPathForRow:dateRowIndexPath.row + 1 inSection:dateRowIndexPath.section];

	[self.tableView scrollToRowAtIndexPath:pickerIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)hideDatePicker
{
	if (_datePickerVisible) {
		// 1
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:2];
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
		cell.detailTextLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];

		// 2
		_datePickerVisible = NO;
		[self.tableView beginUpdates];
		[self.tableView endUpdates];

		// 3
		[UIView animateWithDuration:0.25 animations:^{
			self.datePicker.alpha = 0.0f;
		} completion:^(BOOL finished) {
			self.datePicker.hidden = YES;
		}];
	}
}

- (IBAction)dateChanged:(UIDatePicker *)datePicker
{
	self.date = self.datePicker.date;
	self.dateLabel.text = [self formatDate:self.date];
}

#pragma mark - Photo Picker

- (void)choosePhotoFromLibrary
{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePicker.delegate = self;
	imagePicker.allowsEditing = NO;
	imagePicker.view.tintColor = self.view.tintColor;
	[self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	self.photo = info[UIImagePickerControllerOriginalImage];

	[self showPhoto];
	[self.tableView reloadData];

	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)showPhoto
{
	if (self.photo != nil) {
		self.photoImageView.image = self.photo;
		self.photoImageView.hidden = NO;
		self.photoLabel.hidden = YES;
	}
}

@end
