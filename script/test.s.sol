// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Script.sol";

contract CounterScript is Script {
  function run() public {
    vm.startBroadcast();
    address test = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    payable(test).transfer(30e6 ether);
    vm.stopBroadcast();
  }
}
