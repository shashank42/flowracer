// This script reads the balance field
// of an account's FlowRacerToken Balance

import FlowRacer from 0x1c5fd54be8de5259

pub fun main(): {UInt64: UInt64} {
    return FlowRacer.getTotalWagers()
}