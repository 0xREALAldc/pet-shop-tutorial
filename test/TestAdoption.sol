pragma solidity ^0.5.0;

import 'truffle/Assert.sol';
import 'truffle/DeployedAddresses.sol';
import '../contracts/Adoption.sol';

contract TestAdoption {
  // the address of the adoption contact to be tested
  Adoption adoption = Adoption(DeployedAddresses.Adoption());

  //the id of the pet that will be used for testing
  uint expectedPetId = 8;

  //the expected owner of adopted pet is this contract
  address expectedAdopter = address(this);

  //testing the adopt() function
  function testUserCanAdoptPet() public {
    uint returnedId = adoption.adopt(expectedPetId);

    Assert.equal(returnedId, expectedPetId, "Adoption of the expected pet should match what is returned.");
  }

  //testing retrieval of a single pet`s owner
  function testGetAdopterAddressByPetId() public {
    address adopter = adoption.adopters(expectedPetId);

    Assert.equal(adopter, expectedAdopter, "Owner of the expected pet should be this contract");
  }

  //testing retrieval of all pet owners
  function testGetAdopterAddressByPetIdInArray() public {
    //store adopters in memory rather than contract`s storage
    address[16] memory adopters = adoption.getAdopters();

    Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be this contract");
  }
}