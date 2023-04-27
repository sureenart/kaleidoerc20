pragma solidity ^0.6.2;

// import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.8.3/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.8.3/contracts/access/AccessControl.sol";
// import "@openzeppelin/contracts/access/AccessControl.sol";
// FOR QA ONLY
contract KaleidoERC20MintableBurnable is ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(string memory name, string memory symbol, uint8 decimals, uint256 initialSupply) ERC20(name, symbol) public {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(MINTER_ROLE, _msgSender());
        _setupDecimals(decimals);
        _mint(_msgSender(), initialSupply * 10**uint(super.decimals()));
    }

    function mint(address to, uint256 amount) public {
        require(hasRole(MINTER_ROLE, _msgSender()), "KaleidoERC20MintableBurnable: must have minter role to mint");
        _mint(to, amount);
    }
}

