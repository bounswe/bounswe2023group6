import React from 'react'
import { Button } from "primereact/button";

const Suggestion = ({item}) => {
    return (
        <div className="suggestion-container">
            <div className="profile-photo">
                <img src={item.image} />
            </div>
            <div style={{marginBottom:'5px'}}>
                <h2 className="text">{item.username}</h2>
                <p style={{fontSize:'12px'}}>{item.tag}</p>
                <Button style={{ backgroundColor:'#B46060', color:'#FFF4E0', width:'70px', justifyContent:'center'}}>Follow</Button>
            </div>
        </div>
    );
};

export default Suggestion;
