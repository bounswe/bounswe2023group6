import React from 'react'
import { Button } from 'primereact/button';

const Post = ({item}) => {

    return (
        <div className="pb-4 bg-slate-100 px-2 py-2 rounded">
            <div className="flex flex-row gap-4">
                <div className='w-[180px]'>
                    <img src={item.image} width={180} alt="Resim" className="max-w-full" />
                </div>
                <div className='mb-1'>
                    <h2 className="text" style={{top:'5px'}}>{item.header}</h2>
                    <p style={{fontSize:'12px'}}>{item.content}</p>
                </div>
            </div>
            <div className="flex flex-row justify-between px-4 py-2">
                <div className="date">{item.date}</div>
                <div className='flex flex-row gap-1.5'>
                    <Button size='small' icon="pi pi-thumbs-up" className="p-button-text" style={{width: '30px',height:'30px', backgroundColor:'#B46060', color:'#FFF4E0', borderRadius:'50%'}}/>
                    <Button size='small' icon="pi pi-thumbs-down" className="p-button-text" style={{width: '30px',height:'30px', backgroundColor:'#B46060', color:'#FFF4E0', borderRadius:'50%'}}/>
                </div>
        </div>
        </div>
    );
}

export default Post;