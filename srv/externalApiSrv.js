import cds from  '@sap/cds'
import axios from 'axios'

export default cds.service.impl(async function(){
    // extracting the entity reference from the service
    const {ExternalData} = this.entities;

    this.on('READ',ExternalData , async(req)=>{
        try{
            const response = await axios.get('https://jsonplaceholder.typicode.com/posts');
            return response.data

        }
        catch(error){
            req.error(500,'Failed to fetch external data')
        }
    })
})
