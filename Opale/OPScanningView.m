//
//  OPScanningView.m
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import "OPScanningView.h"

@implementation OPScanningView

@synthesize scannerSelectView, scannerView;

-(void)reload{
    
}

-(void)deviceBrowserView:(IKDeviceBrowserView *)deviceBrowserView selectionDidChange:(ICDevice *)device{
    [scannerView setScannerDevice:(ICScannerDevice*)device];
}

-(void)scannerDeviceView:(IKScannerDeviceView *)scannerDeviceView didScanToURL:(NSURL *)url fileData:(NSData *)data error:(NSError *)error{
    
    //TODO
    NSLog(@"%@", error);
}

-(void)scannerDeviceView:(IKScannerDeviceView *)scannerDeviceView didEncounterError:(NSError *)error{
    //TODO
    NSLog(@"%@", error);
}

@end
