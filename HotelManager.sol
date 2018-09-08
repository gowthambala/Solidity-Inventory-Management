pragma solidity ^0.4.18;
contract HotelDemo {
    address public owner;

    uint public Inventory;
    uint private ConfirmNumber;
    
     mapping(address => Guest) private Guests;
     
   modifier onlyOwner {
        require (msg.sender == owner);
        _;
    }

    struct Guest {
      uint ConfirmationNumber;
      GuestDetails GuestDetail;
    }
    
    struct GuestDetails{
        string Name;
        uint GuestCount; 
    }
    
    function HotelDemo() {
        owner = msg.sender;
        ConfirmNumber = 0;
    }

    function BookRoom(uint _roomCount,string _guestName,uint _guestCount){
        if(Inventory>=_roomCount)
        {
        Inventory =Inventory - _roomCount;
        ConfirmNumber ++;
        Guests[msg.sender].ConfirmationNumber = ConfirmNumber;
        Guests[msg.sender].GuestDetail.Name = _guestName;
        Guests[msg.sender].GuestDetail.GuestCount = _guestCount;
        }
    }
    
    function GetBookingDetails() constant returns (uint GuestConfirmationNumber,string GuestName, uint GuestCount)
    {
        return (Guests[msg.sender].ConfirmationNumber,Guests[msg.sender].GuestDetail.Name,Guests[msg.sender].GuestDetail.GuestCount);
    }
    
    function ModifyInventory(uint _inventory) onlyOwner {
        Inventory = _inventory;
    }
    
    function GetBookingByAddress(address _address) onlyOwner constant returns (uint GuestConfirmationNumber,string GuestName, uint GuestCount)
    {
        return (Guests[_address].ConfirmationNumber,Guests[_address].GuestDetail.Name,Guests[_address].GuestDetail.GuestCount);
    }
}