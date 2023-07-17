// This transaction is a template for a transaction to allow
// anyone to add a Vault resource to their account so that
// they can use the exampleToken

// import FungibleToken from 0x9a0766d93b6608b7
// import FlowRacerToken from 0x0fb46f70bfa68d94
// import MetadataViews from 0x631e88ae7f1d7c20
// import CarNFT from 0x0fb46f70bfa68d94
// import InferenceNFT from 0x0fb46f70bfa68d94
// import NonFungibleToken from 0x631e88ae7f1d7c20



// import FungibleToken from "FungibleToken"
// import FlowRacerToken from "FlowRacerToken"
// import MetadataViews from "MetadataViews"
// import NonFungibleToken from "NonFungibleToken"



import FungibleToken from 0x9a0766d93b6608b7
import FlowRacerToken from 0xf56f22a9f0730d15
import MetadataViews from 0x631e88ae7f1d7c20
import NonFungibleToken from 0x631e88ae7f1d7c20



transaction () {
    prepare(signer: AuthAccount) {
        if signer.borrow<&FlowRacerToken.Vault>(from: FlowRacerToken.VaultStoragePath) != nil {
        } else {
            signer.save(
                <-FlowRacerToken.createEmptyVault(),
                to: FlowRacerToken.VaultStoragePath
            )

            signer.link<&FlowRacerToken.Vault{FungibleToken.Receiver}>(
                FlowRacerToken.ReceiverPublicPath,
                target: FlowRacerToken.VaultStoragePath
            )
            signer.link<&FlowRacerToken.Vault{FungibleToken.Balance, MetadataViews.Resolver}>(
                FlowRacerToken.VaultPublicPath,
                target: FlowRacerToken.VaultStoragePath
            )
            signer.link<&FlowRacerToken.Vault{FungibleToken.Provider}>(
                FlowRacerToken.VaultPublicPath,
                target: FlowRacerToken.VaultStoragePath
            )
        }  
    }
}



  // // Return early if the account already stores a FlowRacerToken Vault
        // if signer.borrow<&CarNFT.Collection>(from: CarNFT.CollectionStoragePath) != nil {
            
        // } else {
        //     log("Create a new CarNFT EmptyCollection and put it in storage")
        //     // Create a new FlowRacerToken Vault and put it in storage
        //     signer.save(
        //         <-CarNFT.createEmptyCollection(),
        //         to: CarNFT.CollectionStoragePath
        //     )

        //     // Create a public capability to the Vault that only exposes
        //     // the deposit function through the Receiver interface
        //     signer.link<&CarNFT.Collection{NonFungibleToken.Receiver}>(
        //         CarNFT.CollectionPublicPath,
        //         target: CarNFT.CollectionStoragePath
        //     )

        //     // // Create a public capability to the Vault that exposes the Balance and Resolver interfaces
        //     // signer.link<&CarNFT.Vault{FungibleToken.Balance, MetadataViews.Resolver}>(
        //     //     CarNFT.CollectionPublicPath,
        //     //     target: CarNFT.CollectionStoragePath
        //     // )

        //     // // Create a public capability to the Vault that only exposes
        //     // // the deposit function through the Receiver interface
        //     // signer.link<&FlowRacerToken.Vault{FungibleToken.Provider}>(
        //     //     FlowRacerToken.VaultPublicPath,
        //     //     target: FlowRacerToken.VaultStoragePath
        //     // )
        // }

        // // Return early if the account already stores a FlowRacerToken Vault
        // if signer.borrow<&InferenceNFT.Collection>(from: InferenceNFT.CollectionStoragePath) != nil {
            
        // } else {
        //     log("Create a new InferenceNFT EmptyCollection and put it in storage")
        //     // Create a new FlowRacerToken Vault and put it in storage
        //     signer.save(
        //         <-InferenceNFT.createEmptyCollection(),
        //         to: InferenceNFT.CollectionStoragePath
        //     )

        //     // Create a public capability to the Vault that only exposes
        //     // the deposit function through the Receiver interface
        //     signer.link<&InferenceNFT.Collection{NonFungibleToken.Receiver}>(
        //         InferenceNFT.CollectionPublicPath,
        //         target: InferenceNFT.CollectionStoragePath
        //     )

        //     // // Create a public capability to the Vault that exposes the Balance and Resolver interfaces
        //     // signer.link<&CarNFT.Vault{FungibleToken.Balance, MetadataViews.Resolver}>(
        //     //     CarNFT.CollectionPublicPath,
        //     //     target: CarNFT.CollectionStoragePath
        //     // )

        //     // // Create a public capability to the Vault that only exposes
        //     // // the deposit function through the Receiver interface
        //     // signer.link<&FlowRacerToken.Vault{FungibleToken.Provider}>(
        //     //     FlowRacerToken.VaultPublicPath,
        //     //     target: FlowRacerToken.VaultStoragePath
        //     // )
        // }