// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {BaseChainSetup} from "./BaseChainSetup.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";
import {ChainAliases} from "./ChainAliases.sol";

contract TokenHelper is BaseChainSetup {
    mapping(string => address) tokenLookup;
    mapping(string => address) whaleLookup;

    function mintTokenTo(
        string memory chain,
        address to,
        uint amount
    ) internal {
        switchTo(chain);
        address whale = whaleLookup[chain];
        require(
            whale != address(0),
            string.concat("no whale for chain: ", chain)
        );
        startImpersonating(whale);
        address token = tokenLookup[chain];
        require(
            token != address(0),
            string.concat("no token for chain: ", chain)
        );
        ERC20(token).transfer(to, amount);
    }

    function getTokenAddress(
        string memory chain
    ) internal view returns (address) {
        address t = tokenLookup[chain];
        require(t != address(0), string.concat("no token for chain: ", chain));
        return t;
    }
}

contract UsdcHelper is TokenHelper, ChainAliases {
    function getUsdc(string memory chain) public view returns (address) {
        return getTokenAddress(chain);
    }

    function usdcBalance(
        string memory chain,
        address person
    ) public view returns (uint) {
        return ERC20(tokenLookup[chain]).balanceOf(person);
    }

    function mintUsdcTo(string memory chain, address to, uint amount) public {
        mintTokenTo(chain, to, amount);
    }

    function setupUsdcInfo() public {
        _setupUsdcTokenAddress();
        _setupUsdcWhaleInfo();
    }

    string constant TOKEN_NAME = "USDC";

    function _addTokenAddress(string memory chain, address addy) private {
        tokenLookup[chain] = addy;
        vm.label(addy, string.concat(chain, "_", TOKEN_NAME));
    }

    function _addWhaleAddress(string memory chain, address addy) private {
        whaleLookup[chain] = addy;
        vm.label(addy, string.concat(chain, "_", TOKEN_NAME, "_WHALE"));
    }

    function _setupUsdcTokenAddress() private {
        _addTokenAddress(ethereum, 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
        _addTokenAddress(arbitrum, 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8);
        _addTokenAddress(optimism, 0x7F5c764cBc14f9669B88837ca1490cCa17c31607);
        _addTokenAddress(polygon, 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174);
    }

    function _setupUsdcWhaleInfo() private {
        _addWhaleAddress(ethereum, 0xcEe284F754E854890e311e3280b767F80797180d);
        _addWhaleAddress(arbitrum, 0xC67E9Efdb8a66A4B91b1f3731C75F500130373A4);
        _addWhaleAddress(optimism, 0xDecC0c09c3B5f6e92EF4184125D5648a66E35298);
        _addWhaleAddress(polygon, 0xf89d7b9c864f589bbF53a82105107622B35EaA40);
    }
}
