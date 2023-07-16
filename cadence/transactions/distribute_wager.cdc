

import FlowRacer from "FlowRacer"
import ExampleToken from "ExampleToken"
import FungibleToken from "FungibleToken"
// import ExampleNFT from "ExampleNFT"
// import NonFungibleToken from "NonFungibleToken"
// import InferenceNFT from "InferenceNFT"


// import FlowRacer from 0x0fb46f70bfa68d94
// import ExampleToken from 0x0fb46f70bfa68d94
// import FungibleToken from 0x9a0766d93b6608b7
// import ExampleNFT from 0x0fb46f70bfa68d94
// import NonFungibleToken from 0x631e88ae7f1d7c20
// import InferenceNFT from 0x0fb46f70bfa68d94

transaction(
        matchId: UInt64,
        winner: Address,
    ){ 
    let tokenReciever: &{FungibleToken.Receiver}
    // let NFTRecievingCapability: &{NonFungibleToken.CollectionPublic}
    // let minter: &InferenceNFT.NFTMinter

    let senderVault: Capability<&ExampleToken.Vault>
    let address: Address

    prepare(signer: AuthAccount){

        self.senderVault = signer.getCapability<&ExampleToken.Vault>(/private/exampleTokenVault)

        self.tokenReciever = signer
            .getCapability(ExampleToken.ReceiverPublicPath)
            .borrow<&{FungibleToken.Receiver}>()
            ?? panic("Unable to borrow receiver reference")


        // self.NFTRecievingCapability = getAccount(signer.address).getCapability(InferenceNFT.CollectionPublicPath) 
        //                 .borrow<&InferenceNFT.Collection{NonFungibleToken.CollectionPublic}>()
        //                 ?? panic("Failed to get User's collection.")

        // // borrow a reference to the NFTMinter resource in storage
        // self.minter = signer.borrow<&InferenceNFT.NFTMinter>(from: InferenceNFT.MinterStoragePath)
        //     ?? panic("Account does not store an object at the specified path")

        self.address = signer.address

    }
    execute{

        FlowRacer.distributeWager(
            matchId: matchId, 
            winner: winner,
            tokenProvider: self.senderVault,
            responderRecievingCapability: self.tokenReciever
        )

    }
}




