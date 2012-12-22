//
//  OPScanningView.h
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import <Quartz/Quartz.h>

#import "OPView.h"

@interface OPScanningView : OPView<IKDeviceBrowserViewDelegate, IKScannerDeviceViewDelegate>{
    IBOutlet NSSplitView* splitView;
    IBOutlet IKDeviceBrowserView* deviceView;
    IBOutlet IKScannerDeviceView* scannerView;
}

@property (nonatomic, retain) IBOutlet NSSplitView* splitView;
@property (nonatomic, retain) IBOutlet IKDeviceBrowserView* deviceView;
@property (nonatomic, retain) IBOutlet IKScannerDeviceView* scannerView;

@end
