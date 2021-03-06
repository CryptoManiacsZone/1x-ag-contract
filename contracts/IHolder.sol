pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract IIFlashLoan {
    function _flashLoan(IERC20 asset, uint256 amount, bytes memory data) internal;
    function _repayFlashLoan(IERC20 token, uint256 amount) internal;
}


contract IIExchange {
    function _exchange(IERC20 fromToken, IERC20 toToken, uint256 amount) internal returns(uint256);
}


contract IIOracle {
    function _getPrice(IERC20 token) internal view returns (uint256);
}


contract IIProtocol {
    function collateralAmount(IERC20 token) public returns(uint256);
    function borrowAmount(IERC20 token) public returns(uint256);
    function pnl(IERC20 collateral, IERC20 debt, uint256 leverageRatio) public returns(uint256);

    function _pnl(IERC20 collateral, IERC20 debt) internal returns(uint256);
    function _deposit(IERC20 token, uint256 amount) internal;
    function _redeem(IERC20 token, uint256 amount) internal;
    function _redeemAll(IERC20 token) internal;
    function _borrow(IERC20 token, uint256 amount) internal;
    function _repay(IERC20 token, uint256 amount) internal;
}


contract IHolder is IIFlashLoan, IIExchange, IIProtocol {
    function stopLoss() public view returns(uint256);
    function takeProfit() public view returns(uint256);

    function openPosition(
        IERC20 collateral,
        IERC20 debt,
        uint256 amount,
        uint256 leverageRatio,
        uint256 _stopLoss,
        uint256 _takeProfit
    )
        external
        payable
        returns(uint256);

    function closePosition(
        IERC20 collateral,
        IERC20 debt,
        address user
    )
        external;
}
