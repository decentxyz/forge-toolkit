// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {BaseChainSetup} from "./BaseChainSetup.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";
import {ChainAliases} from "./ChainAliases.sol";

contract TokenHelper is BaseChainSetup {
    string TOKEN_NAME;
    mapping(string => address) tokenLookup;
    mapping(string => address) whaleLookup;

    constructor(string memory tokenName) {
        TOKEN_NAME = tokenName;
    }

    function mintTokenTo(
        string memory chain,
        address to,
        uint amount
    ) internal {
        switchTo(chain);
        address whale = whaleLookup[chain];
        require(
            whale != address(0),
            string.concat("no whale for ", TOKEN_NAME, " on chain: ", chain)
        );
        startImpersonating(whale);
        address token = tokenLookup[chain];
        require(
            token != address(0),
            string.concat("no ", TOKEN_NAME, " for chain: ", chain)
        );
        ERC20(token).transfer(to, amount);
        stopImpersonating();
    }

    function getTokenAddress(
        string memory chain
    ) internal view returns (address) {
        return getTokenAddress(chain, true);
    }

    function getTokenAddress(
        string memory chain,
        bool revertOnFailure
    ) internal view returns (address) {
        address t = tokenLookup[chain];
        if (revertOnFailure) {
            require(t != address(0), string.concat("no ", TOKEN_NAME, " for chain: ", chain));
        }
        return t;
    }
}

contract UsdcHelper is TokenHelper("USDC"), ChainAliases {
    function getUsdc(string memory chain) public view returns (address) {
        return getTokenAddress(chain);
    }

    function getUsdcOrZeroAddress(string memory chain) public view returns (address) {
        return getTokenAddress(chain, false);
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
        _addTokenAddress(base, 0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA);
        _addTokenAddress(polygon, 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174);
        _addTokenAddress(avalanche, 0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E);
    }

    function _setupUsdcWhaleInfo() private {
        _addWhaleAddress(ethereum, 0xcEe284F754E854890e311e3280b767F80797180d);
        _addWhaleAddress(arbitrum, 0xB38e8c17e38363aF6EbdCb3dAE12e0243582891D);
        _addWhaleAddress(optimism, 0xacD03D601e5bB1B275Bb94076fF46ED9D753435A);
        _addWhaleAddress(base, 0x13A13869B814Be8F13B86e9875aB51bda882E391);
        _addWhaleAddress(polygon, 0xf89d7b9c864f589bbF53a82105107622B35EaA40);
        _addWhaleAddress(avalanche, 0x9f8c163cBA728e99993ABe7495F06c0A3c8Ac8b9);
    }
}
