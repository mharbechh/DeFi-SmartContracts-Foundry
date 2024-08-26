// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "../src/SwapTokens.sol";
import "../src/IERC20.sol";

contract ReswapTest is Test {
    SwapTokens swapTokens;
    IERC20 contractTokenIn;
    IERC20 contractTokenOut;
    address WHALE = 0x7eE80628e2CaFe7246619B62a3BB74a06803d565;
    // tokenIn =>>>> AAVEE
    address tokenIn = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;
    // tokenOut =>>>> LINK
    address tokenOut = 0x514910771AF9Ca656af840dff83E8264EcF986CA;
    uint256 amountIn = 1000;

    function setUp() public {
        swapTokens = new SwapTokens();
        // initialiser erc20 contracts
        contractTokenIn = IERC20(tokenIn);
        contractTokenOut = IERC20(tokenOut);

        vm.prank(WHALE);
        contractTokenIn.approve(address(swapTokens), amountIn);
    }

    function testswap() public {
        uint256 amountOutMin = 1;
        address to = address(this);
        uint256 deadline = block.timestamp;
        vm.prank(WHALE);
        swapTokens.swap(tokenIn, tokenOut, amountIn, amountOutMin, to, deadline);
        uint256 Balance_Token_Out = contractTokenOut.balanceOf(address(this));
        console.log("here is the amount of LINK token you get: ", Balance_Token_Out);
        assertGt(Balance_Token_Out, 0);
    }
}
