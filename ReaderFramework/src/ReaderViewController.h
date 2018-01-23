//
//	ReaderViewController.h
//	Reader v2.7.1
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

#import <UIKit/UIKit.h>

#import "ReaderDocument.h"

@class ReaderViewController;

@protocol ReaderViewControllerDelegate <NSObject>

@optional // Delegate protocols

- (void)dismissReaderViewController:(ReaderViewController *)viewController;

@end

@interface ReaderViewController : UIViewController

@property (strong, nonatomic, readwrite) ReaderDocument *document;
@property (assign, nonatomic, readwrite) NSInteger currentPage;

//
// A UINavigationItem property to allow the PDF View Controller to set its nav
// bar elements in a UINavigationItem other than its own default.
//
// This is useful when you're implementing the PDF View Controller as a subview
// of another VC's view in a UINavigationController, so the PDF View Controller will
// automatically add its bar button items to the UINavigationController's nav bar.
//

@property (strong, nonatomic, readwrite) UINavigationItem *remoteNavigationItem;
@property (strong, nonatomic, readwrite) UINavigationController *remoteNavigationController;

@property (nonatomic, weak, readwrite) id <ReaderViewControllerDelegate> delegate;

- (id)initWithReaderDocument:(ReaderDocument *)object;

- (void)showDocumentPage:(NSInteger)page;

@end
