

// import FlowRacer from "FlowRacer"
// import FlowRacerToken from "FlowRacerToken"
// import FungibleToken from "FungibleToken"


// import CarNFT from "CarNFT"
// import NonFungibleToken from "NonFungibleToken"
// import InferenceNFT from "InferenceNFT"


// import FlowRacer from 0x0fb46f70bfa68d94
// import FlowRacerToken from 0x0fb46f70bfa68d94
// import FungibleToken from 0x9a0766d93b6608b7
// import CarNFT from 0x0fb46f70bfa68d94
// import NonFungibleToken from 0x631e88ae7f1d7c20
// import InferenceNFT from 0x0fb46f70bfa68d94


import FungibleToken from 0x9a0766d93b6608b7
import FlowRacerToken from 0x1c5fd54be8de5259
import FlowRacer from 0x1c5fd54be8de5259

transaction(
        matchId: UInt64,
        winner: Address,
    ){ 
    let tokenReciever: &{FungibleToken.Receiver}
    let address: Address

    prepare(signer: AuthAccount){

        self.tokenReciever = getAccount(winner)
            .getCapability(FlowRacerToken.ReceiverPublicPath)
            .borrow<&{FungibleToken.Receiver}>()!

        self.address = signer.address

    }
    execute{
        FlowRacer.distributeWager(
            matchId: matchId, 
            winner: winner,
            responderRecievingCapability: self.tokenReciever
        )
    }
}




