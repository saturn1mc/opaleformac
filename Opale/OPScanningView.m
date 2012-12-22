//
//  OPScanningView.m
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import "OPScanningView.h"

@implementation OPScanningView

@synthesize splitView, deviceView, scannerView;

-(void)resetView{
    [splitView adjustSubviews];
}

-(void)deviceBrowserView:(IKDeviceBrowserView *)deviceBrowserView selectionDidChange:(ICDevice *)device{
    [scannerView setScannerDevice:(ICScannerDevice*)device];
}

-(void)deviceBrowserView:(IKDeviceBrowserView *)deviceBrowserView didEncounterError:(NSError *)error{
    //TODO
    NSLog(@"%@", error);
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
