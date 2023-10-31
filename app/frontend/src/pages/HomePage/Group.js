import React from 'react';
import { Button } from 'primereact/button';

const Group = ({item}) => {

    return (
        <div className="pb-4 bg-slate-100 px-2 py-2 rounded">
            <div className="flex flex-row gap-4">
                <div className='w-[180px]'>
                    <img src={item.image}  alt="Resim" className="max-w-full" />
                </div>
                <div style={{marginBottom:'5px'}}>
                    <h2 className="text">{item.header}</h2>
                    <p style={{fontSize:'12px'}}>{item.text}</p>
                </div>
            </div>
            <div className="footer">
                <div className="date">Players: {item.players}</div>
                <Button  className="p-button-text" style={{height:'30px', backgroundColor:'#B46060', color:'#FFF4E0', justifyContent:'center'}}>Join</Button>
            </div>
        </div>
    );
}

export default Group;