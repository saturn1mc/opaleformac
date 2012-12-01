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
    IBOutlet IKDeviceBrowserView* scannerSelectView;
    IBOutlet IKScannerDeviceView* scannerView;
}

@property (nonatomic, retain) IBOutlet IKDeviceBrowserView* scannerSelectView;
@property (nonatomic, retain) IBOutlet IKScannerDeviceView* scannerView;

@end
