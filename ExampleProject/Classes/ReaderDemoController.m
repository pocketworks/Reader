//
//	ReaderDemoController.m
//	Reader v2.7.0
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2013 Julius Oklamcak. All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//	of the Software, and to permit persons to whom the Software is furnished to
//	do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ReaderDemoController.h"
#import "ReaderViewController.h"
#import "ReaderFileViewController.h"

@interface ReaderDemoController () <ReaderViewControllerDelegate>

- (void)pushStandardViewControllerButton:(id)sender;
- (void)pushSubviewViewControllerButton:(id)sender;

@end

@implementation ReaderDemoController

#pragma mark Constants

#define DEMO_VIEW_CONTROLLER_PUSH FALSE

#pragma mark UIViewController methods


- (void)viewDidLoad
{
	[super viewDidLoad];
    
	self.view.backgroundColor = [UIColor clearColor]; // Transparent
    
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor whiteColor]];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor blackColor]}];
    
    // A button to push a ReaderViewController instance onto the current UINavigationBar stack.
    // This is the typically and recommended way to use ReaderViewController with a navigation stack.
    UIButton *standardPushViewControllerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [standardPushViewControllerButton setTitle:@"Push ReaderViewController" forState:UIControlStateNormal];
    [standardPushViewControllerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [standardPushViewControllerButton addTarget:self action:@selector(pushStandardViewControllerButton:) forControlEvents:UIControlEventTouchUpInside];
    [standardPushViewControllerButton setFrame:CGRectMake(0.0f, 200.0f, self.view.frame.size.width, 50.0f)];
    [self.view addSubview:standardPushViewControllerButton];

    // A button to push a ReaderFileViewController instnace onto the current navigation stack.
    // This class has a ReaderViewController property in it, which is then added as a subview to
    // the ReaderFileViewController's view.
    UIButton *subviewPushViewControllerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [subviewPushViewControllerButton setTitle:@"Push ReaderFileViewController" forState:UIControlStateNormal];
    [subviewPushViewControllerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [subviewPushViewControllerButton addTarget:self action:@selector(pushSubviewViewControllerButton:) forControlEvents:UIControlEventTouchUpInside];
    [subviewPushViewControllerButton setFrame:CGRectMake(0.0f, 260.0f, self.view.frame.size.width, 50.0f)];
    [self.view addSubview:subviewPushViewControllerButton];

}

- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) // See README
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	else
		return YES;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

#pragma mark UIGestureRecognizer methods

- (void)pushStandardViewControllerButton:(id)sender {
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hackermonthly-issue2" ofType:@"pdf"];
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
    
    if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
        [self.navigationController pushViewController:readerViewController animated:YES];
        
#else // present in a modal view controller
        
        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:readerViewController];
        [navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
        
        [self presentViewController:navigationController animated:YES completion:NULL];
        
#endif // DEMO_VIEW_CONTROLLER_PUSH
    }
}

- (void)pushSubviewViewControllerButton:(id)sender {
    ReaderFileViewController *fileViewController = [[ReaderFileViewController alloc] init];
    
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    [self.navigationController pushViewController:fileViewController animated:YES];
#else
    fileViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:fileViewController];
    
    [self presentViewController:navigationController animated:YES completion:NULL];

#endif
}

#pragma mark ReaderViewControllerDelegate methods

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController popViewControllerAnimated:YES];

#else // dismiss the modal view controller

	[self dismissViewControllerAnimated:YES completion:NULL];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

@end
