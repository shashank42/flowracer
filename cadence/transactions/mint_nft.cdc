/// This script uses the NFTMinter resource to mint a new NFT
/// It must be run with the account that has the minter resource
/// stored in /storage/NFTMinter

// import NonFungibleToken from "NonFungibleToken"
// import CarNFT from "CarNFT"
// import MetadataViews from "MetadataViews"
// import FungibleToken from "FungibleToken"
// import FlowRacerToken from "FlowRacerToken"


import NonFungibleToken from 0x631e88ae7f1d7c20
import CarNFT from 0x1c5fd54be8de5259
import MetadataViews from 0x631e88ae7f1d7c20
import FungibleToken from 0x9a0766d93b6608b7
import FlowRacerToken from 0x1c5fd54be8de5259

transaction(
    type: String,
    url: String,
    amount: UFix64
) {

    let recipientCollectionRef: &{NonFungibleToken.CollectionPublic}
    let mintingIDBefore: UInt64
    let sender: @FlowRacerToken.Vault
    let tokenReceiver: &{FungibleToken.Receiver}

    prepare(signer: AuthAccount) {
        self.mintingIDBefore = CarNFT.totalSupply

        if signer.borrow<&AnyResource>(from: CarNFT.CollectionStoragePath) == nil {
            signer.save(<- CarNFT.createEmptyCollection(), to: CarNFT.CollectionStoragePath)
            signer.link<&AnyResource{NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection}>(CarNFT.CollectionPublicPath, target: CarNFT.CollectionStoragePath)
        }

        self.recipientCollectionRef = signer
            .getCapability(CarNFT.CollectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()!
        
        self.sender <- signer.borrow<&FlowRacerToken.Vault>(from: FlowRacerToken.VaultStoragePath)!.withdraw(amount: UFix64(amount)) as! @FlowRacerToken.Vault

        self.tokenReceiver = signer
            .getCapability(FlowRacerToken.ReceiverPublicPath)
            .borrow<&{FungibleToken.Receiver}>()!
    }
    execute {
        CarNFT.mintNFT(
            recipient: self.recipientCollectionRef,
            type: type,
            url: url,
            requestorVault: <- self.sender,
            receiverCapability: self.tokenReceiver
        )
    }
}