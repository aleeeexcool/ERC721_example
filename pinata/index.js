const pinataSDK = require('@pinata/sdk');
require('dotenv').config();
const fs = require('fs');

const pinata = new pinataSDK(process.env.PINATA_API_KEY, process.env.PINATA_API_SERCRET);
const readableStreamForFile = fs.createReadStream('./images/cool-bear-#1.png');

const options = {
    pinataMetadata: {
        name: "Cool Bear #1",
        keyvalues: {
            customKey: 'customValue',
            customKey2: 'customValue2'
        }
    },
    pinataOptions: {
        cidVersion: 0
    }
};

const pinFileToIPFS = () => {
    return pinata.pinFileToIPFS(readableStreamForFile, options).then((result) => {
        return 'https://gateway.pinata.cloud/ipfs/${result.IpfsHash}' //Why I don't get IpfsHash ?????????

    }).catch((err) => {
        
        console.log(err);
    });
}

//IpfsHash: 'Qme5RqGiPZPFA65xNdvinZisirAU1VisAzAwZFWAzatSJ8',
//PinSize: 1204410,
//Timestamp: '2023-02-27T15:45:03.015Z'

const getMetadata = async () => {
    const imageUrl = await pinFileToIPFS()
    console.log(imageUrl)
}

getMetadata()