import React from 'react';
import { Button } from 'primereact/button';

const Group = ({item}) => {

    return (
        <div className="post-container">
            <div className="suggestion-container">
                <div className='profile-photo'>
                    <img src={item.image}  alt="Resim" className="image" />
                </div>
                <div style={{marginBottom:'5px'}}>
                    <h2 className="text">{item.header}</h2>
                    <p style={{fontSize:'12px'}}>{item.text}</p>
                </div>
            </div>
            <div className="footer">
                <div className="date">Players: {item.players}</div>
                <Button  className="p-button-text" style={{width: '130px',height:'30px', backgroundColor:'#B46060', color:'#FFF4E0', justifyContent:'center'}}>Join</Button>
            </div>
        </div>
    );
}

export default Group;