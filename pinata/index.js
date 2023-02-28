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
        return `https://gateway.pinata.cloud/ipfs/${result.IpfsHash}`

    }).catch((err) => {
        
        console.log(err);
    });
}

const getMetadata = async () => {
    const imageUrl = await pinFileToIPFS()
    console.log(imageUrl)
}

getMetadata()