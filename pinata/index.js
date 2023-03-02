const pinataSDK = require('@pinata/sdk');
require('dotenv').config();
const fs = require('fs');

const pinata = new pinataSDK(process.env.PINATA_API_KEY, process.env.PINATA_API_SERCRET);
const readableStreamForFile = fs.createReadStream('./images/cool-bear-#2.png');

const options = {
    pinataMetadata: {
        name: "Cool Bear #2",
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
};

const pinJSONToIPFS = (body) => {
    return pinata.pinJSONToIPFS(body, options).then((result) => {
        return `https://gateway.pinata.cloud/ipfs/${result.IpfsHash}`

    }).catch((err) => {
        
        console.log(err);
    });
}

const getMetadata = async () => {
    const imageUrl = await pinFileToIPFS()
    const body = {
        name: "Cool Bears Collection",
        description: "The coolest NFT Collection",
        image: imageUrl
    };

    const metadata = await pinJSONToIPFS(body)
    console.log(metadata)
}

getMetadata()

// Cool Bear #1 - https://gateway.pinata.cloud/ipfs/QmUeuegqUXgRET42dxdvGTFQDmtf7X7x35aNcJP8u2JFeq
// Cool Bear #2 - https://gateway.pinata.cloud/ipfs/QmWsxAxT2qARKwzSjktWW7EXD4MD5hURayYGeuqN6swNZ1
