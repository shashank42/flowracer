import CarNFT from 0x1c5fd54be8de5259
import MetadataViews from 0x631e88ae7f1d7c20

pub fun main(address: Address): [CarNFT.CarNFTData] {
    
    let collection = getAccount(address).getCapability(CarNFT.CollectionPublicPath)
                    .borrow<&{MetadataViews.ResolverCollection}>()
                    ?? panic("Could not borrow a reference to the nft collection")

    let ids = collection.getIDs()

    let answer: [CarNFT.CarNFTData] = []

    for id in ids {
    
    let nft = collection.borrowViewResolver(id: id)
    let view = nft.resolveView(Type<CarNFT.CarNFTData>())!

    let display = view as! CarNFT.CarNFTData
    answer.append(display)
    }
    
    return answer
}