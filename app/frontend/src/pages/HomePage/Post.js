import React from 'react'
import { Button } from 'primereact/button';

const Post = ({item}) => {

    return (
        <div className="post-container">
            <div className="suggestion-container">
                <div className='profile-photo'>
                    <img src={item.image}  alt="Resim" className="image" />
                </div>
                <div style={{marginBottom:'5px'}}>
                    <h2 className="text" style={{top:'5px'}}>{item.header}</h2>
                    <p style={{fontSize:'12px'}}>{item.content}</p>
                </div>
            </div>
            <div className="footer">
                <div className="date">{item.date}</div>
                <Button size='small' icon="pi pi-thumbs-up" className="p-button-text" style={{width: '30px',height:'30px', backgroundColor:'#B46060', color:'#FFF4E0', borderRadius:'50%'}}/>
                <Button size='small' icon="pi pi-thumbs-down" className="p-button-text" style={{width: '30px',height:'30px', backgroundColor:'#B46060', color:'#FFF4E0', borderRadius:'50%'}}/>
            </div>
        </div>
    );
}

export default Post;