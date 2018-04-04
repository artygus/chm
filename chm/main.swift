//
//  main.swift
//  chm
//
//  Created by Arty Gus on 19/03/18.
//  Copyright © 2018 Arty Gus. All rights reserved.
//

import IOKit
import IOKit.hid
import Foundation

let hidManagerRef = IOHIDManagerCreate(kCFAllocatorDefault, IOOptionBits(kIOHIDOptionsTypeNone))
IOHIDManagerSetDeviceMatching(hidManagerRef, nil)

let hidManagerRet = IOHIDManagerOpen(hidManagerRef, IOOptionBits(kIOHIDOptionsTypeNone))
if (hidManagerRet != kIOReturnSuccess) {
    print("Failed to open device manager")
    exit(1)
}

let hidDeviceSet = IOHIDManagerCopyDevices(hidManagerRef)
let hidDeviceNum = CFSetGetCount(hidDeviceSet)

print(String(format: "Found %X devices", hidDeviceNum))

CFSetApplyFunction(hidDeviceSet, { value, context in
    let hidDevice = Unmanaged<IOHIDDevice>.fromOpaque(value!).takeRetainedValue()
    print(hidDevice)
}, nil)

IOHIDManagerClose(hidManagerRef, IOOptionBits(kIOHIDOptionsTypeNone))


