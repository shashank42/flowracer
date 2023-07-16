// This transaction is a template for a transaction to allow
// anyone to add a Vault resource to their account so that
// they can use the exampleToken

import FungibleToken from "FungibleToken"
import ExampleToken from "ExampleToken"
import MetadataViews from "MetadataViews"
// import ExampleNFT from "ExampleNFT"
// import InferenceNFT from "InferenceNFT"
import NonFungibleToken from "NonFungibleToken"

// import FungibleToken from 0x9a0766d93b6608b7
// import ExampleToken from 0x0fb46f70bfa68d94
// import MetadataViews from 0x631e88ae7f1d7c20
// import ExampleNFT from 0x0fb46f70bfa68d94
// import InferenceNFT from 0x0fb46f70bfa68d94
// import NonFungibleToken from 0x631e88ae7f1d7c20


transaction () {

    prepare(signer: AuthAccount) {

        
        // Return early if the account already stores a ExampleToken Vault
        if signer.borrow<&ExampleToken.Vault>(from: ExampleToken.VaultStoragePath) != nil {
            
        } else {
            log("Create a new ExampleToken Vault and put it in storage")
            // Create a new ExampleToken Vault and put it in storage
            signer.save(
                <-ExampleToken.createEmptyVault(),
                to: ExampleToken.VaultStoragePath
            )

            // Create a public capability to the Vault that only exposes
            // the deposit function through the Receiver interface
            signer.link<&ExampleToken.Vault{FungibleToken.Receiver}>(
                ExampleToken.ReceiverPublicPath,
                target: ExampleToken.VaultStoragePath
            )

            // Create a public capability to the Vault that exposes the Balance and Resolver interfaces
            signer.link<&ExampleToken.Vault{FungibleToken.Balance, MetadataViews.Resolver}>(
                ExampleToken.VaultPublicPath,
                target: ExampleToken.VaultStoragePath
            )

            // Create a public capability to the Vault that only exposes
            // the deposit function through the Receiver interface
            signer.link<&ExampleToken.Vault{FungibleToken.Provider}>(
                ExampleToken.VaultPublicPath,
                target: ExampleToken.VaultStoragePath
            )
        }

        // // Return early if the account already stores a ExampleToken Vault
        // if signer.borrow<&ExampleNFT.Collection>(from: ExampleNFT.CollectionStoragePath) != nil {
            
        // } else {
        //     log("Create a new ExampleNFT EmptyCollection and put it in storage")
        //     // Create a new ExampleToken Vault and put it in storage
        //     signer.save(
        //         <-ExampleNFT.createEmptyCollection(),
        //         to: ExampleNFT.CollectionStoragePath
        //     )

        //     // Create a public capability to the Vault that only exposes
        //     // the deposit function through the Receiver interface
        //     signer.link<&ExampleNFT.Collection{NonFungibleToken.Receiver}>(
        //         ExampleNFT.CollectionPublicPath,
        //         target: ExampleNFT.CollectionStoragePath
        //     )

        //     // // Create a public capability to the Vault that exposes the Balance and Resolver interfaces
        //     // signer.link<&ExampleNFT.Vault{FungibleToken.Balance, MetadataViews.Resolver}>(
        //     //     ExampleNFT.CollectionPublicPath,
        //     //     target: ExampleNFT.CollectionStoragePath
        //     // )

        //     // // Create a public capability to the Vault that only exposes
        //     // // the deposit function through the Receiver interface
        //     // signer.link<&ExampleToken.Vault{FungibleToken.Provider}>(
        //     //     ExampleToken.VaultPublicPath,
        //     //     target: ExampleToken.VaultStoragePath
        //     // )
        // }

        // // Return early if the account already stores a ExampleToken Vault
        // if signer.borrow<&InferenceNFT.Collection>(from: InferenceNFT.CollectionStoragePath) != nil {
            
        // } else {
        //     log("Create a new InferenceNFT EmptyCollection and put it in storage")
        //     // Create a new ExampleToken Vault and put it in storage
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
        //     // signer.link<&ExampleNFT.Vault{FungibleToken.Balance, MetadataViews.Resolver}>(
        //     //     ExampleNFT.CollectionPublicPath,
        //     //     target: ExampleNFT.CollectionStoragePath
        //     // )

        //     // // Create a public capability to the Vault that only exposes
        //     // // the deposit function through the Receiver interface
        //     // signer.link<&ExampleToken.Vault{FungibleToken.Provider}>(
        //     //     ExampleToken.VaultPublicPath,
        //     //     target: ExampleToken.VaultStoragePath
        //     // )
        // }
        
    }
}