//
//  ReaderFileViewController.m
//  Reader
//
//  Created by Kiran Panesar on 15/10/2014.
//
//

#import "ReaderFileViewController.h"
#import "ReaderViewController.h"

@interface ReaderFileViewController () <ReaderViewControllerDelegate>

@end

@implementation ReaderFileViewController

#pragma mark ReaderViewControllerDelegate

- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ReaderDocument *document = [[ReaderDocument alloc] initWithFilePath:[[NSBundle mainBundle] pathForResource:@"hackermonthly-issue2" ofType:@"pdf"]
                                                               password:nil];
    
    _readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
    [_readerViewController setDelegate:self];
    [_readerViewController setRemoteNavigationItem:self.navigationItem];
    [_readerViewController setRemoteNavigationController:self.navigationController];

    [self.view addSubview:_readerViewController.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_readerViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_readerViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_readerViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_readerViewController viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
