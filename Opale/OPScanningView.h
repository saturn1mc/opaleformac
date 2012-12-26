//
//  OPScanningView.h
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import <Quartz/Quartz.h>

#import "OPView.h"

@class OPPatient;

@interface OPScanningView : OPView< IKDeviceBrowserViewDelegate, IKScannerDeviceViewDelegate>{
    OPPatient* patient;
    
    IBOutlet NSSplitView* splitView;
    IBOutlet IKDeviceBrowserView* deviceBrowser;
    IBOutlet IKScannerDeviceView* scannerView;
}

@property (nonatomic, retain) OPPatient* patient;
@property (nonatomic, retain) IBOutlet NSSplitView* splitView;
@property (nonatomic, retain) IBOutlet IKDeviceBrowserView * deviceBrowser;
@property (nonatomic, retain) IBOutlet IKScannerDeviceView* scannerView;

-(void)setPatient:(OPPatient*)nPatient;
-(void)setScanner:(ICScannerDevice*)scanner;

@end
